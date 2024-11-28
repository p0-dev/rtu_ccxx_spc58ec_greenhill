/* ***************************************************************************************
  README
******************************************************************************************
@name       | readme.txt
@location   | PJT_ROOT_DIR_PATH
@brief      | Readme file for general information
******************************************************************************************
@desc       | Include:
            |   + General information and introduction to the project
            |   + Contributor list and contributor ID
            |   + Toolchain and tool information
            |   + Compilation and linking flags
            |   + Procedure for building the project
*************************************************************************************** */


/* =======================================================================================
  General Information
======================================================================================= */
Ready to use project for target hardware: ST SPC58EC with 
the toolchain from Green Hill MULTI.


/* =======================================================================================
  Contributor Table
==========================================================================================
[ID]  | [Name]        | [Contact_1]               | [Contact_2]
------------------------------------------------------------------------------------------
001   | Thanh Tran    | thanhvpt11235@gmail.com   | N/A
--------------------------------------------------------------------------------------- */


/* =======================================================================================
  Tool @ Toolchain Table
==========================================================================================
[Name]        | [Note]
------------------------------------------------------------------------------------------
Green Hill    | - URL   : https://www.ghs.com/products/MULTI_IDE.html
Multi         | - Type  : C/C++ compiler for PPC (PowerPC Architecture)
------------------------------------------------------------------------------------------
CMake         | - URL   : https://cmake.org/
              | - Type  : Build system (build script generator)
------------------------------------------------------------------------------------------
Ninja         | - URL   : https://ninja-build.org/
              | - Type  : build generator (for driving build script to build the project)
------------------------------------------------------------------------------------------
Graphviz      | - URL   : https://graphviz.org/
              | - Type  : graph generator (invoked by CMake)
--------------------------------------------------------------------------------------- */


/* =======================================================================================
  Project Build Prerequisite
======================================================================================= */
- Installation of the toolchain: clang64
  * Note: adding the toolchain binary directory to $PATH
  * Note: could use MSYS for installing the toolchain

- Installation of the tool: CMake
  * Note: adding the tool binary directory to $PATH

- Installation of the tool: Ninja
  * Note: adding the tool binary directory to $PATH


/* =======================================================================================
  Build Procedure
==========================================================================================
  * Note  : build script for platforms (Linux / Windows) are available through
          : Linux   : PJT_ROOT_DIR_PATH/script/linux
          : Windows : PJT_ROOT_DIR_PATH/script/windows
------------------------------------------------------------------------------------------
[Step]  | [Brief]   | [Task]
------------------------------------------------------------------------------------------
01      | Clean     | - Run the script "clean"
        |           | * Note : the script "clean" will delete the following
        |           |  + PJT_BUILD_DIR_NAME
        |           |  + PJT_DF_INSTALL_DIR_NAME
        |           |  + PJT_DF_GRAPH_DIR_NAME
        |           | * Note : the script "clean" will be needed to 
        |           |   run when a fresh build is required. Thus, no incremental build.
------------------------------------------------------------------------------------------
02      | Gen       | - Run the script "gen"
        |           | * Note : the script "gen" will output the build script and 
        |           |   intermediate files inside PJT_BUILD_DIR_NAME.
------------------------------------------------------------------------------------------
03      | Build     | - Run the script "build"
        |           | * Note : the script "build" will build the project 
        |           |   based from the build script from the last step. 
        |           |   All intermediate files and final files will be 
        |           |   inside PJT_BUILD_DIR_NAME.
        |           | * Note : the final output file will be 
        |           |   inside PJT_DF_INSTALL_DIR_NAME
--------------------------------------------------------------------------------------- */


/* =======================================================================================
  Directory Structure Table
==========================================================================================
[Path]          | [Type]        | [Desc]
------------------------------------------------------------------------------------------
doc             | Dir           | Related documents to the project
------------------------------------------------------------------------------------------
include         | Dir           | Public include header of the project
------------------------------------------------------------------------------------------
script          | Dir           | Supported shell script files for building the project
------------------------------------------------------------------------------------------
src             | Dir           | Contains all source files and private header files
------------------------------------------------------------------------------------------
toolchain       | Dir           | Contains toolchain definition files, 
                |               | in order to feed the input of build system
------------------------------------------------------------------------------------------
cmakelists.txt  | CMake Script  | Main input file for CMake build system
------------------------------------------------------------------------------------------
copyright.txt   | Copyright     | Copyright file, contains copyright contents 
                |               | and project owner
------------------------------------------------------------------------------------------
userconf.cfg    | Cfg File      | Configuration file for the end users
------------------------------------------------------------------------------------------
.ver            | Version File  | Contains development log of the project
--------------------------------------------------------------------------------------- */


/* ***************************************************************************************
  THE END
*************************************************************************************** */
