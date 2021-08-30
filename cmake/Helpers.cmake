macro(developer_info) # {
  set(DEVELOPER_NAME "Luis Vega")
  set(DEVELOPER_EMAIL "luis.vega_merchan@siemens.com")
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

  set(CMAKE_CXX_STANDARD 11)
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

function(_ExternalProject_Add # {
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
    )
  ExternalProject_Add(PROJECT_NAME
    DIRECTORY_OPTIONS
    DOWNLOAD_OPTIONS
    UPDATE_OPTIONS
    CONFIGURE_OPTIONS
    BUILD_OPTIONS
    INSTALL_OPTIONS
    TEST_OPTIONS
    TERMINAL_OPTIONS
    TARGET_OPTIONS
  )
  endfunction() # } _ExternalProject_Add
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
