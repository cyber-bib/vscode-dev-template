cmake_minimum_required(VERSION 3.20.0 FATAL_ERROR)

project(ui-template
	VERSION 0.0.0.1
	DESCRIPTION "CMake Project Template"
	HOMEPAGE_URL "..."
	LANGUAGES C CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../cmake")
include(Helpers)

add_project_defaults()
add_subdirectory(layout)

# viewport needs to be build as an external project
# message(STATUS "${EMSCRIPTEN_TOOLCHAIN_PATH}")
# add_subdirectory(viewport)

# -D CMAKE_MAKE_PROGRAM=${MINGW_EXECUTABLE}"
# -D CMAKE_C_COMPILER=${GCC_EXECUTABLE}"
# -D CMAKE_CXX_COMPILER=${GXX_EXECUTABLE}"
# message(STATUS "EMSDK: $ENV{EMSDK}")

ExternalProject_Add(em-viewport
  SOURCE_DIR
    "${CMAKE_CURRENT_LIST_DIR}/viewport"
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
    -DCMAKE_MAKE_PROGRAM:FILEPATH=${MINGW_EXECUTABLE}
    -DCMAKE_TOOLCHAIN_FILE:FILEPATH=${EMSCRIPTEN_TOOLCHAIN_PATH}
    -DNODE_JS_EXECUTABLE:FILEPATH=${EMSDK_DIR}/node/14.15.5_64bit/bin/node.exe
    -DEMSDK_DIR:FILEPATH=${EMSDK_DIR}
    -DVTK_DIR:PATH=${EMVTK_DIR}/lib/cmake/vtk-9.0
    # OpenGl Settings {
      -DOPENGL_INCLUDE_DIR:PATH=${EMSDK_DIR}/upstream/emscripten/system/include 
      -DOPENGL_EGL_INCLUDE_DIR:PATH=${EMSDK_DIR}/upstream/emscripten/system/include 
      -DOPENGL_GLES2_INCLUDE_DIR:PATH=${EMSDK_DIR}/upstream/emscripten/system/include 
      -DOPENGL_GLES3_INCLUDE_DIR:PATH=${EMSDK_DIR}/upstream/emscripten/system/include 
      # } OpenGl Settings
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
)

file(MAKE_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

# os files
file(COPY  "preload.js" DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
configure_file("main.js" ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} @ONLY)
configure_file("package.json" ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} @ONLY)

# Add angular and bootstrap as part of dependencies

# execute_process(
#   COMMAND powershell ${NPM_EXECUTABLE} start
#   WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
#   RESULTS_VARIABLE NPM_RESULTS
#   OUTPUT_VARIABLE NPM_OUTPUT
#   ERROR_VARIABLE NPM_ERROR
#   ECHO_OUTPUT_VARIABLE
#   ECHO_ERROR_VARIABLE
# )