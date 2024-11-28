:: ***************************************************************************************
:: CLEANING RESULT FILES BATCH SCRIPT
:: ***************************************************************************************
:: \name      : clean.cmd
:: \desc      : cleaning result files, for a fresh project build
:: \location  : project_root_dir/script/windows
:: ***************************************************************************************
:: \desc      :
:: - Cleaning if existed:
::  + PJT_BUILD_DIR_NAME
::  + PJT_DF_INSTALL_DIR_NAME
::  + PJT_DF_GRAPH_DIR_NAME
:: ***************************************************************************************


:: =======================================================================================
:: Pre-Processing
:: =======================================================================================
@echo off

:: =======================================================================================
:: Variable
:: =======================================================================================
set CLEAN_HERE=%cd%
set STD_RETURN_FAIL=1
set STD_RETURN_OK=0
set STD_TRUE=1
set STD_FALSE=0
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
:: Processing User Configuration Batch Script
:: =======================================================================================
if not exist %CLEAN_HERE%\%PROCESS_USERCONF_BATCH_SCRIPT% (
  echo -- [ERROR][Clean] Cannot found PROCESS_USERCONF_BATCH_SCRIPT.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Clean] PROCESS_USERCONF_BATCH_SCRIPT: ^
  %CLEAN_HERE%\%PROCESS_USERCONF_BATCH_SCRIPT%
)

set PROCESS_USERCONF_BATCH_SCRIPT_PATH=%CLEAN_HERE%\%PROCESS_USERCONF_BATCH_SCRIPT%

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
:: Cleaning Process
:: =======================================================================================
:: PJT_BUILD_DIR_NAME
if exist %PJT_ROOT_DIR_PATH%/%PJT_BUILD_DIR_NAME% (
  cd %PJT_ROOT_DIR_PATH%
  rmdir /s /q %PJT_BUILD_DIR_NAME%
)

if %STD_TRUE% == %local_debug% (
  if %STD_RETURN_FAIL% == %errorlevel% (
    echo -- [ERROR][Clean] Failed at command: 
          ^rmdir PJT_BUILD_DIR_NAME: %PJT_BUILD_DIR_NAME%
    exit /b %STD_RETURN_FAIL%
  ) else (
    echo -- [DEBUG][Clean] Cleaned PJT_BUILD_DIR_NAME: %PJT_BUILD_DIR_NAME%
  )
)

:: PJT_DF_INSTALL_DIR_NAME
if exist %PJT_ROOT_DIR_PATH%/%PJT_DF_INSTALL_DIR_NAME% (
  cd %PJT_ROOT_DIR_PATH%
  rmdir /s /q %PJT_DF_INSTALL_DIR_NAME%
)

if %STD_TRUE% == %local_debug% (
  if %STD_RETURN_FAIL% == %errorlevel% (
    echo -- [ERROR][Clean] Failed at command: 
          ^rmdir PJT_DF_INSTALL_DIR_NAME: %PJT_DF_INSTALL_DIR_NAME%
    exit /b %STD_RETURN_FAIL%
  ) else (
    echo -- [DEBUG][Clean] Cleaned PJT_DF_INSTALL_DIR_NAME: %PJT_DF_INSTALL_DIR_NAME%
  )
)

:: PJT_DF_GRAPH_DIR_NAME
if exist %PJT_ROOT_DIR_PATH%/%PJT_DF_GRAPH_DIR_NAME% (
  cd %PJT_ROOT_DIR_PATH%
  rmdir /s /q %PJT_DF_GRAPH_DIR_NAME%
)

if %STD_TRUE% == %local_debug% (
  if %STD_RETURN_FAIL% == %errorlevel% (
    echo -- [ERROR][Clean] Failed at command: 
          ^rmdir PJT_DF_GRAPH_DIR_NAME: %PJT_DF_GRAPH_DIR_NAME%
    exit /b %STD_RETURN_FAIL%
  ) else (
    echo -- [DEBUG][Clean] Cleaned PJT_DF_GRAPH_DIR_NAME: %PJT_DF_GRAPH_DIR_NAME%
  )
)

:: =======================================================================================
:: Post-Processing
:: =======================================================================================
echo -- [INFO][Clean] Done.
cd %CLEAN_HERE%
exit /b %STD_RETURN_OK%


:: ***************************************************************************************
:: THE END
:: ***************************************************************************************