cmake_minimum_required(VERSION 3.20.0 FATAL_ERROR)

project(layout-template
	VERSION 0.0.0.1
	DESCRIPTION "CMake Project Template"
	HOMEPAGE_URL "..."
	LANGUAGES NONE
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake")
include(Helpers)
add_project_defaults()

file(MAKE_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

# os files
file(COPY  "preload.js" DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
configure_file("main.js" ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} @ONLY)
configure_file("package.json" ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

# Add angular and bootstrap as part of dependencies
add_subdirectory(layout)
add_subdirectory(viewport)

execute_process(
  COMMAND powershell ${NPM_EXECUTABLE} start
  WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
  RESULTS_VARIABLE NPM_RESULTS
  OUTPUT_VARIABLE NPM_OUTPUT
  ERROR_VARIABLE NPM_ERROR
  ECHO_OUTPUT_VARIABLE
  ECHO_ERROR_VARIABLE
)