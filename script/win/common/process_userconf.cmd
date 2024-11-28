:: ***************************************************************************************
:: PROCESSING USER CONFIGURATION FILE
:: ***************************************************************************************
:: \name      : process_userconf.cmd
:: \location  : project_root_dir/script/windows/common
:: ***************************************************************************************
:: \desc      :
:: - Processing userconf.cfg file.
:: - Basic validation for user configuration.
:: ***************************************************************************************


:: =======================================================================================
:: Pre-Processing
:: =======================================================================================
@echo off

:: =======================================================================================
:: Standard Variable
:: =======================================================================================
set PROCESS_HERE=%cd%
set STD_TRUE=1
set STD_FALSE=0
set STD_RETURN_OK=0
set STD_RETURN_FAIL=1
set local_debug=%STD_FALSE%

:: =======================================================================================
:: Verbose
:: =======================================================================================
if "--verbose" == "%~2%" (
  set local_debug=%STD_TRUE%
)

:: =======================================================================================
:: Getting User Configuration File
:: =======================================================================================
:: * Note : input configuration file path to the process_userconf.cmd for 
::        : a better management

:: Input: User Configuration File
if "" == "%~1%" (
  echo -- [ERROR][Process] User input - configuration file path - is not found.
  exit /b %STD_RETURN_FAIL%
) else (
  if %STD_TRUE% == %local_debug% (
    echo -- [DEBUG][Process] User input: %~1%
  )
)

if not exist %~1% (
  echo -- [ERROR][Process] Configuration file not found.
  exit /b %STD_RETURN_FAIL%
) else (
  if %STD_TRUE% == %local_debug% (
    echo -- [DEBUG][Process] User configuration file is found.
  )
)

set USERCONF_FILE=%~1%

:: =======================================================================================
:: Processing User Configuration File
:: =======================================================================================
for /f "tokens=1,2 delims==" %%A in (%USERCONF_FILE%) do (
  set %%A=%%B
  if %STD_TRUE% == %local_debug% (
    echo %%A=%%B
  )  
)

:: =======================================================================================
:: User Configuration Validation
:: =======================================================================================
:: PJT_BUILD_TYPE
if "" == "%PJT_BUILD_TYPE%" (
  echo -- [ERROR][Process] PJT_BUILD_TYPE is not set. Refer to readme.txt for detail.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] PJT_BUILD_TYPE is validated.
)

:: PJT_ROOT_DIR_PATH
if "" == "%PJT_ROOT_DIR_PATH%" (
  echo -- [ERROR][Process] PJT_ROOT_DIR_PATH is not set.
  exit /b %STD_RETURN_FAIL%
)

if not exist %PJT_ROOT_DIR_PATH% (
  echo -- [ERROR][Process] PJT_ROOT_DIR_PATH is not existed.
  exit /b %STD_RETURN_FAIL%
)

if not exist %PJT_ROOT_DIR_PATH%\cmakelists.txt (
  echo -- [ERROR][Process] Main cmakelists.txt is not existed.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] PJT_ROOT_DIR_PATH is validated.
)

:: PJT_NAME
if "" == "%PJT_NAME%" (
  echo -- [ERROR][Process] PJT_NAME is not set.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] PJT_NAME is validated.
)

:: PJT_BUILD_DIR_NAME
if "" == "%PJT_BUILD_DIR_NAME%" (
  echo -- [ERROR][Process] PJT_BUILD_DIR_NAME is not set.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] PJT_BUILD_DIR_NAME is validated.
)

:: PJT_DF_INSTALL_DIR_NAME
if "" == "%PJT_DF_INSTALL_DIR_NAME%" (
  echo -- [ERROR][Process] PJT_DF_INSTALL_DIR_NAME is not set.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] PJT_DF_INSTALL_DIR_NAME is validated.
)

:: PJT_DF_GRAPH_DIR_NAME
if "" == "%PJT_DF_GRAPH_DIR_NAME%" (
  echo -- [ERROR][Process] PJT_DF_GRAPH_DIR_NAME is not set.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] PJT_DF_GRAPH_DIR_NAME is validated.
)

:: BUILDSYS_TOOLCHAIN_DEF_FILE
if "" == "%BUILDSYS_TOOLCHAIN_DEF_FILE%" (
  echo -- [ERROR][Process] BUILDSYS_TOOLCHAIN_DEF_FILE is not set.
  exit /b %STD_RETURN_FAIL%
)

if not exist %BUILDSYS_TOOLCHAIN_DEF_FILE% (
  echo -- [ERROR][Process] BUILDSYS_TOOLCHAIN_DEF_FILE is not existed.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] BUILDSYS_TOOLCHAIN_DEF_FILE is validated.
)

:: BUILDSYS_BIN_DIR_PATH
if "" == "%BUILDSYS_BIN_DIR_PATH%" (
  echo -- [ERROR][Process] BUILDSYS_BIN_DIR_PATH is not set.
  exit /b %STD_RETURN_FAIL%
)

if not exist %BUILDSYS_BIN_DIR_PATH% (
  echo -- [ERROR][Process] BUILDSYS_BIN_DIR_PATH is not existed.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] BUILDSYS_BIN_DIR_PATH is validated.
)

:: BUILDSYS_EXE
if "" == "%BUILDSYS_EXE%" (
  echo -- [ERROR][Process] BUILDSYS_EXE is not set.
  exit /b %STD_RETURN_FAIL%
)

if not exist %BUILDSYS_BIN_DIR_PATH%/%BUILDSYS_EXE% (
  echo -- [ERROR][Process] BUILDSYS_EXE is not existed.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] BUILDSYS_EXE is validated.
)

:: BUILDSYS_GENERATOR_NAME
if "" == "%BUILDSYS_GENERATOR_NAME%" (
  echo -- [ERROR][Process] BUILDSYS_GENERATOR_NAME is not set.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] BUILDSYS_GENERATOR_NAME is validated.
)

:: BUILDGEN_BIN_DIR_PATH
if "" == "%BUILDGEN_BIN_DIR_PATH%" (
  echo -- [ERROR][Process] BUILDGEN_BIN_DIR_PATH is not set.
  exit /b %STD_RETURN_FAIL%
)

if not exist %BUILDGEN_BIN_DIR_PATH% (
  echo -- [ERROR][Process] BUILDGEN_BIN_DIR_PATH is not existed.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] BUILDGEN_BIN_DIR_PATH is validated.
)

:: BUILDGEN_EXE
if "" == "%BUILDGEN_EXE%" (
  echo -- [ERROR][Process] BUILDGEN_EXE is not set.
  exit /b %STD_RETURN_FAIL%
)

if not exist %BUILDGEN_BIN_DIR_PATH%/%BUILDGEN_EXE% (
  echo -- [ERROR][Process] BUILDGEN_BIN_DIR_PATH is not existed.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] BUILDGEN_EXE is validated.
)

:: BUILDGEN_PARALLEL_PROCESSES
if "" == "%BUILDGEN_PARALLEL_PROCESSES%" (
  echo -- [ERROR][Process] BUILDGEN_PARALLEL_PROCESSES is not set.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] BUILDGEN_PARALLEL_PROCESSES is validated.
)

:: TOOLCHAIN_BIN_DIR_PATH
if "" == "%TOOLCHAIN_BIN_DIR_PATH%" (
  echo -- [ERROR][Process] TOOLCHAIN_BIN_DIR_PATH is not set.
  exit /b %STD_RETURN_FAIL%
)

if not exist %TOOLCHAIN_BIN_DIR_PATH% (
  echo -- [ERROR][Process] TOOLCHAIN_BIN_DIR_PATH is not existed.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] TOOLCHAIN_BIN_DIR_PATH is validated.
)

:: BUILDGRAPH_SUPPORT_ENABLE
if "" == "%BUILDGRAPH_SUPPORT_ENABLE%" (
  echo -- [ERROR][Process] BUILDGRAPH_SUPPORT_ENABLE is not set.
  exit /b %STD_RETURN_FAIL%
)

if not %STD_TRUE% == %BUILDGRAPH_SUPPORT_ENABLE% (
  if not %STD_FALSE% == %BUILDGRAPH_SUPPORT_ENABLE% (
    echo -- [ERROR][Process] BUILDGRAPH_SUPPORT_ENABLE is not valid.
    exit /b %STD_RETURN_FAIL%
  )
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] BUILDGRAPH_SUPPORT_ENABLE is validated.
)

if %STD_TRUE% == %BUILDGRAPH_SUPPORT_ENABLE% (
  :: BUILDGRAPH_BIN_DIR_PATH
  if "" == "%BUILDGRAPH_BIN_DIR_PATH%" (
    echo -- [ERROR][Process] BUILDGRAPH_BIN_DIR_PATH is not set.
    exit /b %STD_RETURN_FAIL%
  )

  if not exist %BUILDGRAPH_BIN_DIR_PATH% (
    echo -- [ERROR][Process] BUILDGRAPH_BIN_DIR_PATH is not existed.
    exit /b %STD_RETURN_FAIL%
  )

  if %STD_TRUE% == %local_debug% (
    echo -- [DEBUG][Process] BUILDGRAPH_BIN_DIR_PATH is validated.
  )

  :: BUILDGRAPH_RESULT_FILE
  if "" == "%BUILDGRAPH_RESULT_FILE%" (
    echo -- [ERROR][Process] BUILDGRAPH_RESULT_FILE is not set.
    exit /b %STD_RETURN_FAIL%
  )

  if %STD_TRUE% == %local_debug% (
    echo -- [DEBUG][Process] BUILDGRAPH_RESULT_FILE is validated.
  )

  :: BUILDGRAPH_CONVERT_FORMAT
  if "" == "%BUILDGRAPH_CONVERT_FORMAT%" (
    echo -- [ERROR][Process] BUILDGRAPH_CONVERT_FORMAT is not set.
    exit /b %STD_RETURN_FAIL%
  )

  if %STD_TRUE% == %local_debug% (
    echo -- [DEBUG][Process] BUILDGRAPH_CONVERT_FORMAT is validated.
  )
)

:: =======================================================================================
:: Set Environment Variable
:: =======================================================================================
:: BUILDSYS_BIN_DIR_PATH
set Path=%Path%;%BUILDSYS_BIN_DIR_PATH%
if %STD_RETURN_FAIL% == %errorlevel% (
  echo -- [ERROR][Process] Cannot set BUILDSYS_BIN_DIR_PATH to $PATH.
) else (
  if %STD_TRUE% == %local_debug% (
    echo -- [DEBUG][Process] BUILDSYS_BIN_DIR_PATH is added to $PATH.
  )
)

:: BUILDGEN_BIN_DIR_PATH
set Path=%Path%;%BUILDGEN_BIN_DIR_PATH%
if %STD_RETURN_FAIL% == %errorlevel% (
  echo -- [ERROR][Process] Cannot set BUILDGEN_BIN_DIR_PATH to $PATH.
) else (
  if %STD_TRUE% == %local_debug% (
    echo -- [DEBUG][Process] BUILDGEN_BIN_DIR_PATH is added to $PATH.
  )
)

:: BUILDGRAPH_BIN_DIR_PATH
set Path=%Path%;%BUILDGRAPH_BIN_DIR_PATH%
if %STD_RETURN_FAIL% == %errorlevel% (
  echo -- [ERROR][Process] Cannot set BUILDGRAPH_BIN_DIR_PATH to $PATH.
) else (
  if %STD_TRUE% == %local_debug% (
    echo -- [DEBUG][Process] BUILDGRAPH_BIN_DIR_PATH is added to $PATH.
  )
)

:: TOOLCHAIN_BIN_DIR_PATH
set Path=%Path%;%TOOLCHAIN_BIN_DIR_PATH%
if %STD_RETURN_FAIL% == %errorlevel% (
  echo -- [ERROR][Process] Cannot set TOOLCHAIN_BIN_DIR_PATH to $PATH.
) else (
  if %STD_TRUE% == %local_debug% (
    echo -- [DEBUG][Process] TOOLCHAIN_BIN_DIR_PATH is added to $PATH.
  )
)

:: =======================================================================================
:: Post-Processing
:: =======================================================================================
if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Process] Done.
)
cd %PROCESS_HERE%
exit /b %STD_RETURN_OK%


:: ***************************************************************************************
:: THE END
:: ***************************************************************************************
