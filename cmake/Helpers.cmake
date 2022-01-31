# macros {
macro(developer_info) # {
  set(DEVELOPER_NAME "Luis Vega")
  set(DEVELOPER_EMAIL "lvega1@uncc.edu")
  endmacro() # }
macro(system_support) # {
  set(BAD_SYSTEM_NAME_MSG " system is currently not supported. Please email ${DEVELOPER_NAME} to ${DEVELOPER_EMAIL} to add support.")
  set(BAD_SYSTEM_PROCESSOR_MSG " processor is currently not supported. Please email ${DEVELOPER_NAME} to ${DEVELOPER_EMAIL} to add support.")
    string(COMPARE EQUAL ${CMAKE_SYSTEM_NAME} "Windows" IS_WINDOWS)
    string(COMPARE EQUAL ${CMAKE_SYSTEM_PROCESSOR} "AMD64" IS_AMD64)

    # message(STATUS "${CMAKE_SYSTEM_PROCESSOR}")

    # if(NOT IS_WINDOWS)
    #   message(FATAL_ERROR "${CMAKE_SYSTEM_NAME}${BAD_SYSTEM_NAME_MSG}")
    # endif()

    # if(NOT IS_AMD64)
    #   message(FATAL_ERROR "${CMAKE_SYSTEM_PROCESSOR}${BAD_SYSTEM_PROCESSOR_MSG}")
    # endif()

    endmacro() # }
  macro(folder_build_structure) #{
    # get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
    # message(STATUS "Genarator type: ${isMultiConfig}")
    # message(STATUS "${CMAKE_CONFIGURATION_TYPES}")

    set(CMAKE_BUILD_TYPE "Release")

    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_EXTENSIONS OFF)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)

    include(GNUInstallDirs)

    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR})

    # foreach(TYPE IN LISTS CMAKE_CONFIGURATION_TYPES)
    # 	string(TOUPPER "${TYPE}" TYPE_DIR)
    # 	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${TYPE_DIR} "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}/${TYPE}")
    # 	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${TYPE_DIR} "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}/${TYPE}")
    # 	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${TYPE_DIR} "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}/${TYPE}")
    #
    # 	# message(STATUS "type: ${TYPE} (${TYPE_DIR})")
    # 	# message(STATUS "path: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_${TYPE_DIR}}")
    # endforeach()
    # message(STATUS "path: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE}")
    endmacro() # }
  macro(external_project_settings) # {
    set_property(DIRECTORY PROPERTY EP_BASE ${CMAKE_BINARY_DIR}/external)
    include(ExternalProject)

    endmacro() # }
  macro(add_project_defaults) # {
    developer_info()
    system_support()
    folder_build_structure()
    external_project_settings()
    endmacro() # }
  # } macros
# functions {
  # _ExternalProject_* {
    function(_ExternalProject_ParsePreset)
      # Partial implementation of CMakePresets.json
        # supported members
        # -- configurePresets{generator, environment, cacheVariables}
        # members to be implemented
        # -- configurePresets{inherits}
        # -- buildPresets {configurePreset}
        # -- testPresets {configurePreset}
      if(NOT DEFINED ARGV0)
        return()
      endif()

      # find_file {
        set(PRESET_FILE "${CMAKE_CURRENT_LIST_DIR}/CMakePresets.json")
        if(NOT EXISTS ${PRESET_FILE})
          message(FATAL_ERROR "Could not find preset file in current directory.")
        endif()
        
        file(READ ${PRESET_FILE} JSON_PRESET)
        string(JSON JSON_CONFIGS GET ${JSON_PRESET} configurePresets)
        # } find_file

      # find_config {
        unset(CONFIG_INDEX)
        string(JSON JSON_CONFIGS_LENGTH LENGTH ${JSON_CONFIGS})
        math(EXPR JSON_CONFIGS_LENGTH "${JSON_CONFIGS_LENGTH} - 1" OUTPUT_FORMAT DECIMAL)
        foreach(INDEX RANGE ${JSON_CONFIGS_LENGTH}) # {
          string(JSON JSON_CONFIG GET ${JSON_CONFIGS} ${INDEX})

          string(JSON JSON_CONFIG_NAME GET ${JSON_CONFIG} name)
          if(JSON_CONFIG_NAME STREQUAL ARGV0)
            set(CONFIG_INDEX ${INDEX})
            break()
          endif()
          endforeach() # }
        if(NOT DEFINED CONFIG_INDEX)
          message(FATAL_ERROR "${ARGV0} configuration not found in preset file.")
        endif()
        # } find_config
      # find_generator {
        unset(PARSE_ERROR)
        string(
          JSON JSON_CONFIG_GENERATOR
          ERROR_VARIABLE PARSE_ERROR
          GET ${JSON_CONFIG}
          generator
          )
        if(DEFINED PARSE_ERROR)
          # message(STATUS ${PARSE_ERROR})
        endif()
        # } find_generator
      # find_enviroment {
        unset(PARSE_ERROR)
        string(
          JSON JSON_CONFIG_ENVIRONMENT
          ERROR_VARIABLE PARSE_ERROR
          GET ${JSON_CONFIG}
          environment
          )
        if(DEFINED PARSE_ERROR)
          # message(STATUS ${PARSE_ERROR})
        endif()
        # } find_enviroment
      # find_cache {
        unset(PARSE_ERROR)
        string(
          JSON JSON_CONFIG_CACHE
          ERROR_VARIABLE PARSE_ERROR
          GET ${JSON_CONFIG}
          cacheVariables
          )
        if(DEFINED PARSE_ERROR)
          # message(STATUS ${PARSE_ERROR})
        endif()
        # } find_enviroment
      #

      # message(STATUS "gen: \n${JSON_CONFIG_GENERATOR}")
      # message(STATUS "env: \n${JSON_CONFIG_ENVIRONMENT}")
      # message(STATUS "cache: \n${JSON_CONFIG_CACHE}")
      endfunction()
    function(_ExternalProject_DirectoryOptions)
      # arguments {
        set(options)
        set(oneValueArgs
          PREFIX_DIR
          TMP_DIR
          STAMP_DIR
          DOWNLOAD_DIR
          SOURCE_DIR
          BINARY_DIR
          INSTALL_DIR
          LOG_DIR
          )
        set(multiValueArgs)
        cmake_parse_arguments(SUBPROJ
          "${options}"
          "${oneValueArgs}"
          "${multiValueArgs}"
          ${ARGN}
          )
        # } arguments
      # meat {
        if(NOT PREFIX_DIR)
          set(SUBPROJ_PREFIX_DIR ${CMAKE_CURRENT_BINARY_DIR})
        endif()

        if(NOT SUBPROJ_TMP_DIR)
          set(SUBPROJ_TMP_DIR ${SUBPROJ_PREFIX_DIR}/tmp)
        endif()
        if(NOT SUBPROJ_STAMP_DIR)
          set(SUBPROJ_STAMP_DIR ${SUBPROJ_PREFIX_DIR}/stamp)
        endif()
        if(NOT SUBPROJ_DOWNLOAD_DIR)
          set(SUBPROJ_DOWNLOAD_DIR ${SUBPROJ_PREFIX_DIR}/download)
        endif()
        if(NOT SUBPROJ_SOURCE_DIR)
          set(SUBPROJ_SOURCE_DIR ${SUBPROJ_PREFIX_DIR}/src)
        endif()
        if(NOT SUBPROJ_BINARY_DIR)
          set(SUBPROJ_BINARY_DIR ${SUBPROJ_PREFIX_DIR}/out)
        endif()
        if(NOT SUBPROJ_INSTALL_DIR)
          set(SUBPROJ_INSTALL_DIR ${SUBPROJ_PREFIX_DIR}/install)
        endif()
        if(NOT SUBPROJ_LOG_DIR)
          set(SUBPROJ_LOG_DIR ${SUBPROJ_PREFIX_DIR}/log)
        endif()
        # } meat
      # return {
        set(SUBPROJ_DIRECTORY_OPTIONS
          TMP_DIR ${SUBPROJ_TMP_DIR}
          STAMP_DIR ${SUBPROJ_STAMP_DIR}
          DOWNLOAD_DIR ${SUBPROJ_DOWNLOAD_DIR}
          SOURCE_DIR ${SUBPROJ_SOURCE_DIR}
          BINARY_DIR ${SUBPROJ_BINARY_DIR}
          INSTALL_DIR ${SUBPROJ_INSTALL_DIR}
          LOG_DIR ${SUBPROJ_LOG_DIR}
          )
        # string(REPLACE ";" "\n" SUBPROJ_DIRECTORY_OPTIONS "${SUBPROJ_DIRECTORY_OPTIONS}")
        set(SUBPROJ_DIRECTORY_OPTIONS ${SUBPROJ_DIRECTORY_OPTIONS} PARENT_SCOPE)
        # } return
      endfunction()
    function(_ExternalProject_DownloadOptions)
      # arguments {
        set(options)
        set(oneValueArgs)
        set(multiValueArgs)
        cmake_parse_arguments(SUBPROJ
          "${options}"
          "${oneValueArgs}"
          "${multiValueArgs}"
          ${ARGN}
          )
        # } arguments
      # return {
        set(SUBPROJ_DOWNLOAD_OPTIONS
          ${SUBPROJ_UNPARSED_ARGUMENTS}
          )
        # string(REPLACE ";" "\n" SUBPROJ_DOWNLOAD_OPTIONS "${SUBPROJ_DOWNLOAD_OPTIONS}")
        set(SUBPROJ_DOWNLOAD_OPTIONS ${SUBPROJ_DOWNLOAD_OPTIONS} PARENT_SCOPE)
        # } return
      endfunction()
    function(_ExternalProject_UpdateOptions)
      # arguments {
        set(options UPDATE_DISCONNECTED)
        set(oneValueArgs)
        set(multiValueArgs)
        cmake_parse_arguments(SUBPROJ
          "${options}"
          "${oneValueArgs}"
          "${multiValueArgs}"
          ${ARGN}
          )
        # } arguments
      # meat {
        if(NOT DEFINED SUBPROJ_UPDATE_DISCONNECTED)
          set(SUBPROJ_UPDATE_DISCONNECTED TRUE)
          endif()
        # } meat
      # return {
        set(SUBPROJ_UPDATE_OPTIONS
          ${SUBPROJ_UPDATE_DISCONNECTED}
          ${SUBPROJ_UNPARSED_ARGUMENTS}
          )
        # string(REPLACE ";" "\n" SUBPROJ_UPDATE_OPTIONS "${SUBPROJ_UPDATE_OPTIONS}")
        set(SUBPROJ_UPDATE_OPTIONS ${SUBPROJ_UPDATE_OPTIONS} PARENT_SCOPE)
        # } return
      endfunction()
    function(_ExternalProject_ConfigureOptions)
      # arguments {
        set(options)
        set(oneValueArgs)
        set(multiValueArgs)
        cmake_parse_arguments(SUBPROJ
          "${options}"
          "${oneValueArgs}"
          "${multiValueArgs}"
          ${ARGN}
          )
        # } arguments
      # return {
        set(SUBPROJ_CONFIGURE_OPTIONS
          "${SUBPROJ_UNPARSED_ARGUMENTS}"
          )
        string(REPLACE ";" "\n" SUBPROJ_CONFIGURE_OPTIONS "${SUBPROJ_CONFIGURE_OPTIONS}")
        set(SUBPROJ_CONFIGURE_OPTIONS ${SUBPROJ_CONFIGURE_OPTIONS} PARENT_SCOPE)
        # } return
      endfunction()
    function(_ExternalProject_BuildOptions)
      # arguments {
        set(options)
        set(oneValueArgs)
        set(multiValueArgs)
        cmake_parse_arguments(SUBPROJ
          "${options}"
          "${oneValueArgs}"
          "${multiValueArgs}"
          ${ARGN}
          )
        # } arguments
      # return {
        set(SUBPROJ_BUILD_OPTIONS
          "${SUBPROJ_UNPARSED_ARGUMENTS}"
          )
        string(REPLACE ";" "\n" SUBPROJ_BUILD_OPTIONS "${SUBPROJ_BUILD_OPTIONS}")
        set(SUBPROJ_BUILD_OPTIONS ${SUBPROJ_BUILD_OPTIONS} PARENT_SCOPE)
        # } return
      endfunction()
    function(_ExternalProject_InstallOptions)
      # arguments { 
        set(options)
        set(oneValueArgs)
        set(multiValueArgs)
        cmake_parse_arguments(SUBPROJ
          "${options}"
          "${oneValueArgs}"
          "${multiValueArgs}"
          ${ARGN}
          )
        # } arguments
      # return {
        set(SUBPROJ_INSTALL_OPTIONS
          "${SUBPROJ_UNPARSED_ARGUMENTS}"
          )
        string(REPLACE ";" "\n" SUBPROJ_INSTALL_OPTIONS "${SUBPROJ_INSTALL_OPTIONS}")
        set(SUBPROJ_INSTALL_OPTIONS ${SUBPROJ_INSTALL_OPTIONS} PARENT_SCOPE)
        # } return
      endfunction()
    function(_ExternalProject_TestOptions)
      # arguments { 
        set(options)
        set(oneValueArgs)
        set(multiValueArgs)
        cmake_parse_arguments(SUBPROJ
          "${options}"
          "${oneValueArgs}"
          "${multiValueArgs}"
          ${ARGN}
          )
        # } arguments
      # return {
        set(SUBPROJ_TEST_OPTIONS
          "${SUBPROJ_UNPARSED_ARGUMENTS}"
          )
        string(REPLACE ";" "\n" SUBPROJ_TEST_OPTIONS "${SUBPROJ_TEST_OPTIONS}")
        set(SUBPROJ_TEST_OPTIONS ${SUBPROJ_TEST_OPTIONS} PARENT_SCOPE)
        # } return
      endfunction()
    function(_ExternalProject_TerminalOptions)
      # arguments { 
        set(options)
        set(oneValueArgs)
        set(multiValueArgs)
        cmake_parse_arguments(SUBPROJ
          "${options}"
          "${oneValueArgs}"
          "${multiValueArgs}"
          ${ARGN}
          )
        # } arguments
      # return {
        set(SUBPROJ_TERMINAL_OPTIONS
          "${SUBPROJ_UNPARSED_ARGUMENTS}"
          )
        string(REPLACE ";" "\n" SUBPROJ_TERMINAL_OPTIONS "${SUBPROJ_TERMINAL_OPTIONS}")
        set(SUBPROJ_TERMINAL_OPTIONS ${SUBPROJ_TERMINAL_OPTIONS} PARENT_SCOPE)
        # } return
      endfunction()
    function(_ExternalProject_TargetOptions)
      # arguments { 
        set(options)
        set(oneValueArgs)
        set(multiValueArgs)
        cmake_parse_arguments(SUBPROJ
          "${options}"
          "${oneValueArgs}"
          "${multiValueArgs}"
          ${ARGN}
          )
        # } arguments
      # return {
        set(SUBPROJ_TARGET_OPTIONS
          "${SUBPROJ_UNPARSED_ARGUMENTS}"
          )
        string(REPLACE ";" "\n" SUBPROJ_TARGET_OPTIONS "${SUBPROJ_TARGET_OPTIONS}")
        set(SUBPROJ_TARGET_OPTIONS ${SUBPROJ_TARGET_OPTIONS} PARENT_SCOPE)
        # } return
      endfunction()
    function(_ExternalProject_MiscOptions)
      # arguments { 
        set(options)
        set(oneValueArgs)
        set(multiValueArgs)
        cmake_parse_arguments(SUBPROJ
          "${options}"
          "${oneValueArgs}"
          "${multiValueArgs}"
          ${ARGN}
          )
        # } arguments
      # return {
        set(SUBPROJ_MISC_OPTIONS
          "${SUBPROJ_UNPARSED_ARGUMENTS}"
          )
        string(REPLACE ";" "\n" SUBPROJ_MISC_OPTIONS "${SUBPROJ_MISC_OPTIONS}")
        set(SUBPROJ_MISC_OPTIONS ${SUBPROJ_MISC_OPTIONS} PARENT_SCOPE)
        # } return
      endfunction()
    function(_ExternalProject_Add) # {
      # arguments {
        set(options)
        set(oneValueArgs
          PRESET_CONFIG
        )
        set(multiValueArgs
          DIRECTORY_OPTIONS
          DOWNLOAD_OPTIONS
          UPDATE_OPTIONS
          CONFIGURE_OPTIONS
          BUILD_OPTIONS
          INSTALL_OPTIONS
          TEST_OPTIONS
          TERMINAL_OPTIONS
          TARGET_OPTIONS
          MISC_OPTIONS
          )
        cmake_parse_arguments(PARSE_ARGV 1 SUBPROJ
          "${options}"
          "${oneValueArgs}"
          "${multiValueArgs}"
          )
        # } arguments
      
      _ExternalProject_ParsePreset(${SUBPROJ_PRESET_CONFIG})
      _ExternalProject_DirectoryOptions(${SUBPROJ_DIRECTORY_OPTIONS})
      _ExternalProject_DownloadOptions(${SUBPROJ_DOWNLOAD_OPTIONS})
      _ExternalProject_UpdateOptions(${SUBPROJ_UPDATE_OPTIONS})
      _ExternalProject_ConfigureOptions(${SUBPROJ_CONFIGURE_OPTIONS})
      _ExternalProject_BuildOptions(${SUBPROJ_BUILD_OPTIONS})
      _ExternalProject_InstallOptions(${SUBPROJ_INSTALL_OPTIONS})
      _ExternalProject_TestOptions(${SUBPROJ_TEST_OPTIONS})
      _ExternalProject_TerminalOptions(${SUBPROJ_TERMINAL_OPTIONS})
      _ExternalProject_TargetOptions(${SUBPROJ_TARGET_OPTIONS})
      _ExternalProject_MiscOptions(${SUBPROJ_MISC_OPTIONS})

      # debug_messages {
        # message(STATUS "PROJECT_NAME      ${SUBPROJ_PROJECT_NAME}")
        # message(STATUS "DIRECTORY_OPTIONS \n${SUBPROJ_DIRECTORY_OPTIONS}")
        # message(STATUS "DOWNLOAD_OPTIONS  \n${SUBPROJ_DOWNLOAD_OPTIONS}")
        # message(STATUS "UPDATE_OPTIONS    \n${SUBPROJ_UPDATE_OPTIONS}")
        # message(STATUS "CONFIGURE_OPTIONS \n${SUBPROJ_CONFIGURE_OPTIONS}")
        # message(STATUS "BUILD_OPTIONS     \n${SUBPROJ_BUILD_OPTIONS}")
        # message(STATUS "INSTALL_OPTIONS   \n${SUBPROJ_INSTALL_OPTIONS}")
        # message(STATUS "TEST_OPTIONS      \n${SUBPROJ_TEST_OPTIONS}")
        # message(STATUS "TERMINAL_OPTIONS  \n${SUBPROJ_TERMINAL_OPTIONS}")
        # message(STATUS "TARGET_OPTIONS    \n${SUBPROJ_TARGET_OPTIONS}")
        # message(STATUS "UNPARSED_OPTIONS  \n${SUBPROJ_UNPARSED_ARGUMENTS}")
        # } debug_messages
      
      ExternalProject_Add(
        ${ARGV0}
        ${SUBPROJ_DIRECTORY_OPTIONS}
        ${SUBPROJ_DOWNLOAD_OPTIONS}
        ${SUBPROJ_UPDATE_OPTIONS}
        ${SUBPROJ_CONFIGURE_OPTIONS}
        ${SUBPROJ_BUILD_OPTIONS}
        ${SUBPROJ_INSTALL_OPTIONS}
        ${SUBPROJ_TEST_OPTIONS}
        ${SUBPROJ_TERMINAL_OPTIONS}
        ${SUBPROJ_TARGET_OPTIONS}
        ${SUBPROJ_UNPARSED_ARGUMENTS}
        )

      endfunction() # } _ExternalProject_Add
    # } _ExternalProject*

  function(Emscripten_ExternalProject_Add
    PROJECT_NAME
    DIRECTORY_OPTIONS
    DOWNLOAD_OPTIONS
    UPDATE_OPTIONS
    CONFIGURE_OPTIONS
    BUILD_OPTIONS
    INSTALL_OPTIONS
    TEST_OPTIONS
    TERMINAL_OPTIONS
    TARGET_OPTIONS
    ) # {
    ExternalProject_Add(PROJECT_NAME
      GIT_REPOSITORY
        "https://gitlab.kitware.com/vtk/vtk.git"
      UPDATE_DISCONNECTED
        TRUE
      CMAKE_COMMAND
        ${CMAKE_COMMAND} -E env 
          EMSDK=${EMSDK_DIR}
          EM_CONFIG=${EMSDK_DIR}/.emscripten
          EMSDK_NODE=${EMSDK_DIR}/node/14.15.5_64bit/bin/node.exe
          EMSDK_PYTHON=${EMSDK_DIR}/python/3.9.2-1_64bit/python.exe
          JAVA_HOME=${EMSDK_DIR}/java/8.152_64bit
          ${CMAKE_COMMAND}
      CMAKE_GENERATOR
        "MinGW Makefiles"
      CMAKE_ARGS
        -D "CMAKE_MAKE_PROGRAM:FILEPATH='${MINGW_EXECUTABLE}'"
        -D "CMAKE_TOOLCHAIN_FILE:FILEPATH='${EMSCRIPTEN_TOOLCHAIN_PATH}'"
        -D "NODE_JS_EXECUTABLE=${EMSDK_DIR}/node/14.15.5_64bit/bin/node.exe"
        -D "CMAKE_BUILD_TYPE:STRING=Release"
        # vtk settings {
          -D "VTK_ENABLE_LOGGING:BOOL=OFF"
          -D "VTK_ENABLE_WRAPPING:BOOL=OFF"
          -D "VTK_LEGACY_REMOVE:BOOL=ON"
          -D "VTK_OPENGL_USE_GLES:BOOL=ON"
          -D "VTK_USE_SDL2:BOOL=ON"
          -D "VTK_NO_PLATFORM_SOCKETS:BOOL=ON"
          -D "VTK_MODULE_ENABLE_VTK_hdf5:STRING=NO"
          -D "H5_HAVE_GETPWUID:BOOL=OFF"

          -D "VTK_GROUP_ENABLE_Rendering:STRING=WANT"
          # -D "Module_vtkRenderingContextOpenGL2:BOOL=OFF"
          -D "VTK_MODULE_ENABLE_VTK_RenderingContextOpenGL2=NO"
          # -D "FREETYPE_INCLUDE_DIRS:PATH='include'"
          # -D "FREETYPE_LIBRARY:STRING='freetype'"

          -D "BUILD_SHARED_LIBS:BOOL=OFF"
          -D "BUILD_EXAMPLES:BOOL=OFF"
          -D "BUILD_TESTING:BOOL=OFF"

          -D "CMAKE_INSTALL_PREFIX:PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}"
          # } vtk settings
        # opengl settings {
          # -D "OPENGL_INCLUDE_DIR:PATH=${EMSDK_DIR}/upstream/emscripten/system/include" 
          # -D "OPENGL_EGL_INCLUDE_DIR:PATH=${EMSDK_DIR}/upstream/emscripten/system/include" 
          # -D "OPENGL_GLES2_INCLUDE_DIR:PATH=${EMSDK_DIR}/upstream/emscripten/system/include"  
          # -D "OPENGL_GLES3_INCLUDE_DIR:PATH=${EMSDK_DIR}/upstream/emscripten/system/include" 
          # }
        # compiler flags {
          -D "CMAKE_CXX_FLAGS='${EMSCRIPTEN_CXX_FLAGS}'"
          # # compiler flags }
        # -D "CMAKE_EXECUTABLE_SUFFIX='.html'"
      # INSTALL_COMMAND
      #   ""
      # BUILD_ALWAYS
      #   TRUE
      LOG_CONFIGURE
        TRUE
      LOG_BUILD
        TRUE
      LOG_INSTALL
        TRUE
      USES_TERMINAL_CONFIGURE
        TRUE
      USES_TERMINAL_BUILD
        TRUE
      USES_TERMINAL_INSTALL
        TRUE
      )
    endfunction() # }
  # } functions