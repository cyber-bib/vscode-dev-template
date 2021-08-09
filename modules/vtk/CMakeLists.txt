cmake_minimum_required(VERSION 3.20.0 FATAL_ERROR)

project(vtk-install
	VERSION 0.0.0.1
	DESCRIPTION "VTK installition module"
	HOMEPAGE_URL "..."
  LANGUAGES C CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake")
include(Helpers)
add_project_defaults()

# message(STATUS "python: ${EMSDK_DIR}")

# https://gitlab.kitware.com/vtk/vtk.git

if((NOT DEFINED VTK_SOURCE_DIR) OR (VTK_SOURCE_DIR STREQUAL "VTK_SOURCE_DIR-NOTFOUND"))
  # set(VTK_DIR "VTK_DIR-NOTFOUND" CACHE PATH "vtk's cmake config file root directory")
  # message(FATAL_ERROR "vtk's cmake config file root directory not set/found")
  message(STATUS "vtk source was not found. attemping to download.")




  # message("\t- SDL2 Include: ${SDL2_INCLUDE_DIRS}")

  set(EMSCRIPTEN_CXX_FLAGS "")
  # set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s EXPORT_NAME=CylinderExample")
  # set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} --bind")
  # set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -g3")
  set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s USE_SDL=2")
  set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s FULL_ES3=1")
  set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s WASM=1")
  set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s WASM_ASYNC_COMPILATION=1")
  # set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s USE_WEBGL2=1")
  # set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s MIN_WEBGL_VERSION=2")
  # set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s MAX_WEBGL_VERSION=2")
  set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s ALLOW_MEMORY_GROWTH=1")
  set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s DISABLE_DEPRECATED_FIND_EVENT_TARGET_BEHAVIOR=0")
  set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s ERROR_ON_UNDEFINED_SYMBOLS=0")
  # set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s MODULARIZE=1")
  set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s USE_PTHREADS=0")
  set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s DEMANGLE_SUPPORT=1")
  set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s EMULATE_FUNCTION_POINTER_CASTS=0")

  set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -s FORCE_FILESYSTEM=1")
  # set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} -lnodefs.js")
  # set(EMSCRIPTEN_CXX_FLAGS "${EMSCRIPTEN_CXX_FLAGS} --shell-file ${CMAKE_CURRENT_LIST_DIR}/html/viewport.html")

  # message("\t- Flags: ${EMSCRIPTEN_CXX_FLAGS}")
  # set(EMSSCRIPTEN_EXECUTABLE_SUFFIX ".html")

  ExternalProject_Add(em-vtk-lib
    GIT_REPOSITORY
      "https://gitlab.kitware.com/vtk/vtk.git"
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
      -D "BUILD_SHARED_LIBS:BOOL=OFF"
      -D "CMAKE_BUILD_TYPE:STRING=Release"
      # vtk settings {
        -D "VTK_ENABLE_LOGGING:BOOL=OFF"
        -D "VTK_ENABLE_WRAPPING:BOOL=OFF"
        -D "VTK_LEGACY_REMOVE:BOOL=ON"
        -D "VTK_OPENGL_USE_GLES:BOOL=ON"
        -D "VTK_USE_SDL2:BOOL=ON"
        -D "VTK_NO_PLATFORM_SOCKETS:BOOL=ON"
        -D "VTK_MODULE_ENABLE_VTK_hdf5:STRING=NO"
        # } vtk settings
      # compiler flags {
        -D "CMAKE_CXX_FLAGS='${EMSCRIPTEN_CXX_FLAGS}'"

        # # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s EXPORT_NAME=CylinderExample'"
        # # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} --bind'"
        # # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -g3'"
        # -D "CMAKE_CXX_FLAGS='-s USE_SDL=2'"
        # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s FULL_ES3=1'"
        # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s WASM=1'"
        # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s WASM_ASYNC_COMPILATION=1'"
        # # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s USE_WEBGL2=1'"
        # # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s MIN_WEBGL_VERSION=2'"
        # # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s MAX_WEBGL_VERSION=2'"
        # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s ALLOW_MEMORY_GROWTH=1'"
        # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s DISABLE_DEPRECATED_FIND_EVENT_TARGET_BEHAVIOR=0'"
        # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s ERROR_ON_UNDEFINED_SYMBOLS=0'"
        # # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s MODULARIZE=1'"
        # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s USE_PTHREADS=0'"
        # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s DEMANGLE_SUPPORT=1'"
        # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s EMULATE_FUNCTION_POINTER_CASTS=0'"
        # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -s FORCE_FILESYSTEM=1'"
        # # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} -lnodefs.js'"
        # -D "CMAKE_CXX_FLAGS='${CMAKE_CXX_FLAGS} --shell-file ${CMAKE_CURRENT_LIST_DIR}/html/viewport.html'"
        # # compiler flags }
      # -D "CMAKE_EXECUTABLE_SUFFIX='.html'"
    # BUILD_COMMAND
      # ${CMAKE_COMMAND} -E env 
      #   EMSDK=${EMSDK_DIR}
      #   EM_CONFIG=${EMSDK_DIR}/.emscripten
      #   EMSDK_NODE=${EMSDK_DIR}/node/14.15.5_64bit/bin/node.exe
      #   EMSDK_PYTHON=${EMSDK_DIR}/python/3.9.2-1_64bit/python.exe
      #   JAVA_HOME=${EMSDK_DIR}/java/8.152_64bit
      #   ${CMAKE_COMMAND} --build .\ --config Release
    INSTALL_COMMAND
      ""
    BUILD_ALWAYS
      TRUE
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
  

  # add_custom_target(em-vtk-core ALL
  #   ${CMAKE_COMMAND}
  #     -E env
  #       EMSDK=${EMSDK_DIR}
  #       EM_CONFIG=${EMSDK_DIR}/.emscripten
  #       EMSDK_NODE=${EMSDK_DIR}/node/14.15.5_64bit/bin/node.exe
  #       EMSDK_PYTHON=${EMSDK_DIR}/python/3.9.2-1_64bit/python.exe
  #       JAVA_HOME=${EMSDK_DIR}/java/8.152_64bit
  #       ${CMAKE_COMMAND}
  #         --build ./
  #         --target em-vtk-lib
  #   USES_TERMINAL
  # )

else()
  find_package(VTK REQUIRED)
  message (STATUS "VTK_VERSION: ${VTK_VERSION}")
  if (VTK_VERSION VERSION_LESS "9.0.1")
    message(FATAL_ERROR "VTK Version ${VTK_VERSION} is not supported. Please Install VTK 9.0.1 or greater")
  endif()
endif()

# }

# if(NOT Python3_FOUND)
#   if(EXISTS ${PY_INSTALLER_PATH})
#     message(STATUS "Python installer found.")
#   else()
#     message(STATUS "Python not found. Downloading from ${PY_INSTALLER_SOURCE}")
#     file(DOWNLOAD
#       "${PY_INSTALLER_SOURCE}"
#       "${PY_INSTALLER_PATH}"
#       SHOW_PROGRESS
#     )
#   endif()

#   file(ARCHIVE_EXTRACT
#     INPUT "${PY_INSTALLER_PATH}"
#     DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
#     VERBOSE
#   )
#   # set(Python3_DIR ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
#   set(Python3_EXECUTABLE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/python.exe)
#   find_package(Python3 REQUIRED)
# else()
#   execute_process(
#     COMMAND powershell ${Python3_EXECUTABLE} --version
#     WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
#     RESULT_VARIABLE PYTHON_RESULT
#     OUTPUT_VARIABLE PYTHON_OUTPUT
#   )
#   string(REPLACE "\n" "" PYTHON_OUTPUT ${PYTHON_OUTPUT})
#   string(REPLACE "Python " "" PYTHON_OUTPUT ${PYTHON_OUTPUT})
#   message(STATUS "Found python version: ${PYTHON_OUTPUT}")
# endif()