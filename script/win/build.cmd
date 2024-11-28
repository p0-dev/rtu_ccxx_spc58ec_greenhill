:: ***************************************************************************************
:: BUILDING PROJECT BATCH SCRIPT
:: ***************************************************************************************
:: \name          : build.cmd
:: \location      : project_root_dir/script/windows
:: \prerequisite  : running gen.cmd
:: ***************************************************************************************
:: \desc          : 
:: - Building project script
:: ***************************************************************************************


:: =======================================================================================
:: Pre-Processing
:: =======================================================================================
@echo off

:: =======================================================================================
:: Variable
:: =======================================================================================
set BUILD_HERE=%cd%
set STD_RETURN_FAIL=1
set STD_RETURN_OK=0
set STD_TRUE=1
set STD_FALSE=0
set USERCONF_FILE=userconf.cfg
set PROCESS_USERCONF_BATCH_SCRIPT=common\process_userconf.cmd
set local_debug=%STD_FALSE%

:: =======================================================================================
:: Verbose
:: =======================================================================================
if "--verbose" == "%~1%" (
  set local_debug=%STD_TRUE%
)

:: =======================================================================================
:: Navigating User Configuration Batch Script
:: =======================================================================================
if not exist %BUILD_HERE%\%PROCESS_USERCONF_BATCH_SCRIPT% (
  echo -- [ERROR][Clean] Cannot found PROCESS_USERCONF_BATCH_SCRIPT.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Clean] PROCESS_USERCONF_BATCH_SCRIPT: %BUILD_HERE%\%PROCESS_USERCONF_BATCH_SCRIPT%
)

set PROCESS_USERCONF_BATCH_SCRIPT_PATH=%BUILD_HERE%\%PROCESS_USERCONF_BATCH_SCRIPT%

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
:: Building Process
:: =======================================================================================
:: Navigation to PJT_ROOT_DIR_PATH
cd %PJT_ROOT_DIR_PATH%

:: Argument
set arg=

:: Dynamic flag
set arg=%arg% --build %PJT_BUILD_DIR_NAME%
set arg=%arg% --parallel %BUILDGEN_PARALLEL_PROCESSES%

:: Static lag
set arg=%arg% --clean-first

if %STD_TRUE% == %local_debug% (
  set arg=%arg% --verbose
)

:: Debug
if %STD_TRUE% == %local_debug% (
  echo -- [Debug][Build] %arg%
)

:: Run
call %BUILDSYS_EXE% %arg%

:: Validation
if %STD_RETURN_FAIL% == %errorlevel% (
  echo -- [Error][Build] Failed at building process with %BUILDSYS_EXE%
  exit /b %STD_RETURN_FAIL%
)

:: =======================================================================================
:: Default Installation Process
:: =======================================================================================
:: Navigation
cd %PJT_ROOT_DIR_PATH%

:: Argument
set arg=

:: Dynamic argument
set arg=%arg% --install %PJT_BUILD_DIR_NAME%
set arg=%arg% --prefix %PJT_DF_INSTALL_DIR_NAME%

:: Run
call %BUILDSYS_EXE% %arg%

:: Validation
if %STD_RETURN_FAIL% == %errorlevel% (
  echo -- [Error][Build] Failed at default installation with %BUILDSYS_EXE%
  exit /b %STD_RETURN_FAIL%
)

:: =======================================================================================
:: Final Result
:: =======================================================================================
echo -- [Info][Build] Done.
cd %BUILD_HERE%
exit /b %STD_RETURN_OK%


:: ***************************************************************************************
:: THE END
:: ***************************************************************************************
