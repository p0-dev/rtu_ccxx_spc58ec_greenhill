# ****************************************************************************************
# CMAKE TOOLCHAIN FILE - GREEN HILL MULTI
# ****************************************************************************************
# /name         : gh_ppc.cmake
# /brief        : cmake toolchain file for the toolchain: Green Hill MULTI
# /location     : PJT_ROOT_DIR_PATH/toolchain
# ****************************************************************************************
# /desc         :
# The toolchain definition file is for the toolchain Green Hill MULTI 
# (for Power PC architecture).
# The version of the toolchain: v2015.1.6
# ****************************************************************************************
# /note         :
# * As the toolchain already supports start up files and linker script, 
#   this project will not define those.
# ****************************************************************************************


# ========================================================================================
# User Configuration
# ========================================================================================

# ----------------------------------------------------------------------------------------
# CMake ROOT_PATH
# ----------------------------------------------------------------------------------------
# * Note : ABSOLUTE PATH
set (
  CMAKE_FIND_ROOT_PATH 
  "D:/ts_mirr/gh/PPC.V2015.1.6/comp_201516"
)

# ----------------------------------------------------------------------------------------
# C Compiler Execution 
# ----------------------------------------------------------------------------------------
# * Note : refer to the toolchain user manual
set (
  CMAKE_C_COMPILER      
  "ccppc"
)

# ----------------------------------------------------------------------------------------
# C++ Compiler Execution 
# ----------------------------------------------------------------------------------------
# * Note : refer to the toolchain user manual
set (
  CMAKE_CXX_COMPILER    
  "cxppc"
)

# ----------------------------------------------------------------------------------------
# Toolchain Standard Include Directory
# ----------------------------------------------------------------------------------------
# * Note : ABSOLUTE PATH
# * Note : refer to the toolchain user manual
set (
  CMAKE_C_STANDARD_INCLUDE_DIRECTORIES 
  "D:/ts_mirr/gh/PPC.V2015.1.6/comp_201516/ansi"
)

# ----------------------------------------------------------------------------------------
# S-Record File Output
# ----------------------------------------------------------------------------------------
# * Note : ABSOLUTE PATH
set (
  USERCFG_SREC_OUTPUT_PATH
  "D:/thanhtvp2/workspace/private/test/test_ccxx_spc58ec_greenhill/build/${PROJECT_NAME}.srec"
)

# ========================================================================================
# General Configuration
# ========================================================================================

# ----------------------------------------------------------------------------------------
# CMake Find Program
# ----------------------------------------------------------------------------------------
set (
  CMAKE_FIND_ROOT_PATH_MODE_PROGRAM 
  NEVER
)

# ----------------------------------------------------------------------------------------
# CMake Find Library
# ----------------------------------------------------------------------------------------
# * Note: only each libraries inside ROOT_PATH
set (
  CMAKE_FIND_ROOT_PATH_MODE_LIBRARY 
  ONLY
)

# ----------------------------------------------------------------------------------------
# CMake Find Header / Include
# ----------------------------------------------------------------------------------------
# * Note: only search "include header" inside ROOT_PATH
set (
  CMAKE_FIND_ROOT_PATH_MODE_INCLUDE 
  ONLY
)

# ----------------------------------------------------------------------------------------
# CMake System Name
# ----------------------------------------------------------------------------------------
# * Note: system "Generic for cross-compiling"
set (
  CMAKE_SYSTEM_NAME 
  Generic
)

# ----------------------------------------------------------------------------------------
# Compiler Settings
# ----------------------------------------------------------------------------------------
# * Note: skip compiler validation
set (CMAKE_C_COMPILER_WORKS    1)
set (CMAKE_C_COMPIER_FORCED    1)
set (CMAKE_CXX_COMPILER_WORKS  1)
set (CMAKE_CXX_COMPIER_FORCED  1)

# ========================================================================================
# Compilation Flag
# ========================================================================================
# * Note : refer to the toolchain user manual
add_compile_options (
  # --------------------------------------------------------------------------------------
  # Global
  # --------------------------------------------------------------------------------------
  -DGLOBAL_COMPILE=1                                # Usercfg : test
  -bsp=spc58ec                                      # Target  : BSP type              
  -passsource                                       # Opt     : produce original code
  -sda=0                                            # Opt     : no small data area macros
  -list                                             # Opt     : output listing file
  -preprocess_assembly_files                        # Opt     : pre-process asm files
  -bigendian                                        # Opt     : big endian system
  -ppc32                                            # Opt     : power PC 32 bits
  -C99                                              # Opt     : c99 standard
  --warnings                                        # Opt     : warning level
  --remarks                                         # Opt     : remark level
  --quit_after_warnings                             # Opt     : exit after warnings
  -Wformat                                          # Opt     : checking printf and scanf
  -Wall                                             # Opt     : enable all warnings
  -double_check.level=high                          # Opt     : double check system

  # --------------------------------------------------------------------------------------
  # Debug
  # --------------------------------------------------------------------------------------
  $<$<CONFIG:CustomizedDebug>:-Omaxdebug>           # Debug   : optimize debug
  $<$<CONFIG:CustomizedDebug>:-dual_debug>          # Debug   : debug symbols for .elf file
  $<$<CONFIG:CustomizedDebug>:-G>                   # Debug   : debug symbol level
)

# ========================================================================================
# Linking Flag
# ========================================================================================
# * Note : refer to the toolchain user manual
add_link_options (
  # --------------------------------------------------------------------------------------
  # Global
  # --------------------------------------------------------------------------------------
  -DGLOBAL_COMPILE=1                                # Usercfg : test
  -bsp=spc58ec                                      # Target  : BSP type              
  -passsource                                       # Opt     : produce original code
  -sda=0                                            # Opt     : no small data area macros
  -list                                             # Opt     : output listing file
  -preprocess_assembly_files                        # Opt     : pre-process asm files
  -bigendian                                        # Opt     : big endian system
  -ppc32                                            # Opt     : power PC 32 bits
  -C99                                              # Opt     : c99 standard
  --warnings                                        # Opt     : warning level
  --remarks                                         # Opt     : remark level
  --quit_after_warnings                             # Opt     : exit after warnings
  -Wformat                                          # Opt     : checking printf and scanf
  -Wall                                             # Opt     : enable all warnings
  -double_check.level=high                          # Opt     : double check system

  # --------------------------------------------------------------------------------------
  # Debug
  # --------------------------------------------------------------------------------------
  $<$<CONFIG:CustomizedDebug>:-Omaxdebug>           # Debug   : optimize debug
  $<$<CONFIG:CustomizedDebug>:-dual_debug>          # Debug   : debug symbols for .elf file
  $<$<CONFIG:CustomizedDebug>:-G>                   # Debug   : debug symbol level

  # --------------------------------------------------------------------------------------
  # Linker Only
  # --------------------------------------------------------------------------------------
  -no_ignore_debug_references                       # Linker  : no ignore debug references
  -gsize                                            # Linker  : .siz file for checking size
  -srec=${USERCFG_SREC_OUTPUT_PATH}                 # Linker  : produce .srec file
  -nostrip                                          # Linker  : do not strip debug symbols
  --preprocess_linker_directive_full                # Linker  : process directive fully
  -linker_warnings                                  # Linker  : enable linker warnings
  -map                                              # Linker  : generate map file
  -nokeepmap                                        # Linker  : delete map if linker error
  -Mx                                               # Linker  : map file cross-reference
  -Mu                                               # Linker  : unused function to map file
  -Ml                                               # Linker  : add local symbols to map file
  -Mn                                               # Linker  : map file sorted by address
  -map_eofn_symbols                                 # Linker  : end of function symbol
  -strict_overlap_check                             # Linker  : overlap check
  -checksum                                         # Linker  : proceduce checksum
  -globalcheck=full                                 # Linker  : global check
  -globalcheck_qualifiers                           # Linker  : global check for qualifiers
  -stdlib                                           # Linker  : linking with stdlib (Green Hill)
)


# ****************************************************************************************
# THE END
# ****************************************************************************************