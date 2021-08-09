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
  CMAKE_GENERATOR
    "MinGW Makefiles"
  CMAKE_ARGS
    -D "EMSDK_DIR:FILEPATH='${EMSDK_DIR}'"
    # -D "Python3_EXECUTABLE='${Python3_EXECUTABLE}'"
    -D "CMAKE_MAKE_PROGRAM:FILEPATH='${MINGW_EXECUTABLE}'"
    # -D "CMAKE_C_COMPILER=. ${Python3_EXECUTABLE} ${EMSDK_PATH}/emcc.py"
    # -D "CMAKE_CXX_COMPILER=. ${Python3_EXECUTABLE}${EMSDK_PATH}/em++.py"
    -D "CMAKE_TOOLCHAIN_FILE:FILEPATH='${EMSCRIPTEN_TOOLCHAIN_PATH}'"
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