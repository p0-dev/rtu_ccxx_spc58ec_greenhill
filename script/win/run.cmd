:: ***************************************************************************************
:: RUN BUILD SCRIPT
:: ***************************************************************************************
:: \name        : run.cmd
:: \brief       : running result file of the project
:: \location    : project_root_dir/script/windows
:: ***************************************************************************************


:: =======================================================================================
:: Pre-Processing
:: =======================================================================================
@echo off

:: =======================================================================================
:: Variable
:: =======================================================================================
set RUN_HERE=%cd%
set STD_RETURN_FAIL=1
set STD_RETURN_OK=0
set STD_TRUE=1
set STD_FALSE=0
set local_debug=%STD_FALSE%
set PROCESS_USERCONF_BATCH_SCRIPT=common\process_userconf.cmd
set USERCONF_FILE=userconf.cfg

:: =======================================================================================
:: Verbose
:: =======================================================================================
if "--verbose" == "%~1%" (
  set local_debug=%STD_TRUE%
)

:: =======================================================================================
:: Navigating User Configuration Batch Script
:: =======================================================================================
if not exist %RUN_HERE%\%PROCESS_USERCONF_BATCH_SCRIPT% (
  echo -- [ERROR][Clean] Cannot found PROCESS_USERCONF_BATCH_SCRIPT.
  exit /b %STD_RETURN_FAIL%
)

if %STD_TRUE% == %local_debug% (
  echo -- [DEBUG][Clean] PROCESS_USERCONF_BATCH_SCRIPT: ^
  %RUN_HERE%\%PROCESS_USERCONF_BATCH_SCRIPT%
)

set PROCESS_USERCONF_BATCH_SCRIPT_PATH=%RUN_HERE%\%PROCESS_USERCONF_BATCH_SCRIPT%

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
:: Running
:: =======================================================================================
call %PJT_ROOT_DIR_PATH%/%PJT_DF_INSTALL_DIR_NAME%/%PJT_NAME%

:: =======================================================================================
:: Final Return
:: =======================================================================================
echo:
echo -- [INFO][Run] Done.
cd %RUN_HERE%
exit /b %STD_RETURN_OK%


:: ***************************************************************************************
:: THE END
:: ***************************************************************************************