:: ***************************************************************************************
:: GENERATING BUILD SCRIPT
:: ***************************************************************************************
:: \name      : gen.cmd
:: \location  : PJT_ROOT_DIR_PATH/script/windows
:: \brief     : Build script for Windows
:: ***************************************************************************************
:: \desc      : Invoke:
::            :   + common\process_userconf.cmd
:: ***************************************************************************************


:: =======================================================================================
:: Pre-Processing
:: =======================================================================================
@echo off

:: =======================================================================================
:: Standard Variable
:: =======================================================================================
set GEN_HERE=%cd%
set STD_RETURN_FAIL=1
set STD_RETURN_OK=0
set STD_TRUE=1
set STD_FALSE=0

:: =======================================================================================
:: Dynamic Variable
:: =======================================================================================
set USERCONF_FILE=userconf.cfg
set local_debug=%STD_FALSE%
set PROCESS_USERCONF_BATCH_SCRIPT=common\process_userconf.cmd

:: =======================================================================================
:: Verbose
:: =======================================================================================
if "--verbose" == "%~1%" (
  set local_debug=%STD_TRUE%
)

:: =======================================================================================
:: Navigating User Configuration Batch Script
:: =======================================================================================
if not exist %GEN_HERE%\%PROCESS_USERCONF_BATCH_SCRIPT% (
  echo -- [ERROR][Clean] Cannot found PROCESS_USERCONF_BATCH_SCRIPT.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Clean] PROCESS_USERCONF_BATCH_SCRIPT: ^
  %GEN_HERE%\%PROCESS_USERCONF_BATCH_SCRIPT%
)

set PROCESS_USERCONF_BATCH_SCRIPT_PATH=%GEN_HERE%\%PROCESS_USERCONF_BATCH_SCRIPT%

:: =======================================================================================
:: Navigate User Configuration File
:: =======================================================================================
cd ../..

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Clean] PJT_ROOT_DIR_PATH: %cd%
)

if not exist %cd%\%USERCONF_FILE% (
  echo -- [ERROR][Clean] USERCONF_FILE is not existed.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Clean] USERCONF_FILE: %cd%\%USERCONF_FILE%
)

set USERCONF_FILE_PATH=%cd%\%USERCONF_FILE%

:: =======================================================================================
:: Invoke User Configuration File
:: =======================================================================================
if %STD_TRUE% == %local_debug% (
  call %PROCESS_USERCONF_BATCH_SCRIPT_PATH% %USERCONF_FILE_PATH% --verbose
) else (
  call %PROCESS_USERCONF_BATCH_SCRIPT_PATH% %USERCONF_FILE_PATH%
)

:: =======================================================================================
:: Secondary User Configuration Validation
:: =======================================================================================
:: PJT_BUILD_TYPE
if "" == "%PJT_BUILD_TYPE%" (
  echo -- [ERROR][Gen] PJT_BUILD_TYPE is not set.
  exit /b %STD_RETURN_FAIL%
)

:: PJT_ROOT_DIR_PATH
if "" == "%PJT_ROOT_DIR_PATH%" (
  echo -- [ERROR][Gen] PJT_ROOT_DIR_PATH is not set.
  exit /b %STD_RETURN_FAIL%
)

if not exist %PJT_ROOT_DIR_PATH% (
  echo -- [ERROR][Gen] PJT_ROOT_DIR_PATH is not existed.
  exit /b %STD_RETURN_FAIL%
)

:: PJT_BUILD_DIR_NAME
if "" == "%PJT_BUILD_DIR_NAME%" (
  echo -- [ERROR][Gen] PJT_BUILD_DIR_NAME is not set.
  exit /b %STD_RETURN_FAIL%
)

:: BUILDSYS_GENERATOR_NAME
if "" == "%BUILDSYS_GENERATOR_NAME%" (
  echo -- [ERROR][Gen] BUILDSYS_GENERATOR_NAME is not set.
  exit /b %STD_RETURN_FAIL%
)

:: PJT_NAME
if "" == "%PJT_NAME%" (
  echo -- [ERROR][Gen] PJT_NAME is not set.
  exit /b %STD_RETURN_FAIL%
)

:: BUILDSYS_TOOLCHAIN_DEF_FILE
if "" == "%BUILDSYS_TOOLCHAIN_DEF_FILE%" (
  echo -- [ERROR][Gen] BUILDSYS_TOOLCHAIN_DEF_FILE is not set.
  exit /b %STD_RETURN_FAIL%
)

if not exist %BUILDSYS_TOOLCHAIN_DEF_FILE% (
  echo -- [ERROR][Gen] BUILDSYS_TOOLCHAIN_DEF_FILE is not existed.
  exit /b %STD_RETURN_FAIL%
)

:: BUILDGRAPH_SUPPORT_ENABLE
if "" == "%BUILDGRAPH_SUPPORT_ENABLE%" (
  echo -- [ERROR][Gen] BUILDGRAPH_SUPPORT_ENABLE is not set.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %BUILDGRAPH_SUPPORT_ENABLE% (
  :: PJT_DF_GRAPH_DIR_NAME
  if "" == "%PJT_DF_GRAPH_DIR_NAME%" (
    echo -- [ERROR][Gen] PJT_DF_GRAPH_DIR_NAME is not set.
    exit /b %STD_RETURN_FAIL%
  )
  :: BUILDGRAPH_RESULT_FILE
  if "" == "%BUILDGRAPH_RESULT_FILE%" (
    echo -- [ERROR][Gen] BUILDGRAPH_RESULT_FILE is not set.
    exit /b %STD_RETURN_FAIL%
  )
)

:: =======================================================================================
:: Build System Generation
:: =======================================================================================
:: Navigation
cd %PJT_ROOT_DIR_PATH%

:: Argument
set arg=

:: Dynamic flag
set arg=%arg% -S %PJT_ROOT_DIR_PATH%
set arg=%arg% -B %PJT_BUILD_DIR_NAME%
set arg=%arg% -G %BUILDSYS_GENERATOR_NAME%
set arg=%arg% -D PJT_NAME=%PJT_NAME%
set arg=%arg% -D CMAKE_BUILD_TYPE=%PJT_BUILD_TYPE%
set arg=%arg% --toolchain %BUILDSYS_TOOLCHAIN_DEF_FILE%

if %STD_TRUE% == %BUILDGRAPH_SUPPORT_ENABLE% (
  set arg=%arg% --graphviz=%PJT_ROOT_DIR_PATH%/%PJT_DF_GRAPH_DIR_NAME%/%BUILDGRAPH_RESULT_FILE%
)

:: Static flag
set arg=%arg% -Wdev
set arg=%arg% -Werror=dev
set arg=%arg% -Wdeprecated

:: Debug
if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Gen] %arg%
)

:: Run
call %BUILDSYS_EXE% %arg%

:: Validation
if %STD_RETURN_FAIL% == %errorlevel% (
  echo -- [ERROR][Gen] Failed at generation with: %BUILDSYS_EXE%
  exit /b %STD_RETURN_FAIL%
)

:: =======================================================================================
:: Build Graph Generation
:: =======================================================================================
:: Navigating to PJT_ROOT_DIR_PATH
cd %PJT_ROOT_DIR_PATH%

:: Graph convert
if %STD_TRUE% == %BUILDGRAPH_SUPPORT_ENABLE% (
  cd %PJT_ROOT_DIR_PATH%/%PJT_DF_GRAPH_DIR_NAME%
  dot -T%BUILDGRAPH_CONVERT_FORMAT% %BUILDGRAPH_RESULT_FILE% ^
  -o %PJT_NAME%.%BUILDGRAPH_CONVERT_FORMAT%
)

:: =======================================================================================
:: Post Processing
:: =======================================================================================
echo -- [INFO][Gen] Done.
cd %GEN_HERE%
exit /b %STD_RETURN_OK%


:: ***************************************************************************************
:: THE END
:: ***************************************************************************************