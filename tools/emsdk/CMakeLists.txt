# https://github.com/emscripten-core/emsdk.git
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip

cmake_minimum_required(VERSION 3.20.0 FATAL_ERROR)

project(EmSDK-Install
	VERSION 0.0.0.1
	DESCRIPTION "Emscripten SDK Installition module"
	HOMEPAGE_URL "..."
  LANGUAGES C CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake")
include(Helpers)
add_project_defaults()

# if(IS_WINDOWS)
# endif()

set(EMSDK_POSTFIX "zip")
set(EMSDK_VER "2.0.26")
set(EMSDK_ARCH "")
set(EMSDK_INSTALLER_NAME "${EMSDK_VER}.${EMSDK_POSTFIX}")
set(EMSDK_INSTALLER_PATH "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${EMSDK_INSTALLER_NAME}")
set(EMSDK_INSTALLER_SOURCE "https://github.com/emscripten-core/emsdk/archive/refs/tags/${EMSDK_INSTALLER_NAME}")

# find_package(EMSDK QUIET)
# if(NOT EMSDK_FOUND)
set(EMSDK_PATH "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
set(EMSCRIPTEN_RELATIVE_PATH "upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake")
set(EMSCRIPTEN_TOOLCHAIN_PATH "${EMSDK_PATH}/${EMSCRIPTEN_RELATIVE_PATH}")
if(NOT EXISTS ${EMSCRIPTEN_TOOLCHAIN_PATH})
  if(EXISTS ${EMSDK_INSTALLER_PATH})
    message(STATUS "Emscripten installer found.")
  else()
    message(STATUS "Emscripten not found. Downloading from ${EMSDK_INSTALLER_SOURCE}")
    file(DOWNLOAD
      "${EMSDK_INSTALLER_SOURCE}"
      "${EMSDK_INSTALLER_PATH}"
      SHOW_PROGRESS
    )
  endif()

  file(ARCHIVE_EXTRACT
    INPUT "${EMSDK_INSTALLER_PATH}"
    DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
    VERBOSE
  )
  file(COPY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/emsdk-${EMSDK_VER}/"
    DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
  )
  file(REMOVE_RECURSE "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/emsdk-${EMSDK_VER}")

  cmake_path(GET Python3_EXECUTABLE PARENT_PATH Python3_PATH)
  set(ENV{PATH} "$ENV{PATH}${Python3_PATH}")
  message(STATUS "$ENV{PATH}")

  message(STATUS "running \"./emsdk update\" this may take a few minutes.")
  execute_process(
    COMMAND ${Python3_EXECUTABLE} emsdk.py update
    WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    RESULT_VARIABLE EMSDK_RESULT
    OUTPUT_VARIABLE EMSDK_OUTPUT
    ECHO_OUTPUT_VARIABLE
    ECHO_ERROR_VARIABLE
  )

  message(STATUS "running \"./emsdk install latest\" this may take a few minutes.")
  execute_process(
    COMMAND ${Python3_EXECUTABLE} emsdk.py install latest
    WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    RESULT_VARIABLE EMSDK_RESULT
    OUTPUT_VARIABLE EMSDK_OUTPUT
    ECHO_OUTPUT_VARIABLE
    ECHO_ERROR_VARIABLE
  )

  string(REPLACE "\n" "\n--   " EMSDK_OUTPUT ${EMSDK_OUTPUT})
  message(STATUS "output ${EMSDK_RESULT}:\n--   ${EMSDK_OUTPUT}")
  unset(EMSDK_RESULT)
  unset(EMSDK_OUTPUT)

  message(STATUS "running \"./emsdk activate latest\" this may take a few minutes.")
  execute_process(
    COMMAND ${Python3_EXECUTABLE} emsdk.py activate latest
    WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    RESULT_VARIABLE EMSDK_RESULT
    OUTPUT_VARIABLE EMSDK_OUTPUT
    ECHO_OUTPUT_VARIABLE
    ECHO_ERROR_VARIABLE
  )

  string(REPLACE "\n" "\n--   " EMSDK_OUTPUT ${EMSDK_OUTPUT})
  message(STATUS "output ${EMSDK_RESULT}:\n--   ${EMSDK_OUTPUT}")


  set(EMSDK_PATH "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
else()
  message(STATUS "Found Emscripten.")
endif()

# string(REPLACE "\n" "\n--   " EMSDK_OUTPUT ${EMSDK_OUTPUT})
# message(STATUS "output ${EMSDK_RESULT}:\n--   ${EMSDK_OUTPUT}")

set(EMSDK_DIR "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
set(EMSDK_DIR "${EMSDK_DIR}" PARENT_SCOPE)

set(EMSCRIPTEN_TOOLCHAIN_PATH "${EMSDK_DIR}/${EMSCRIPTEN_RELATIVE_PATH}")
set(EMSCRIPTEN_TOOLCHAIN_PATH "${EMSCRIPTEN_TOOLCHAIN_PATH}" PARENT_SCOPE)

# execute_process(
#   COMMAND powershell ${EMSDK_DIR}/emsdk_env.ps1
#   WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
#   RESULT_VARIABLE EMSDK_RESULT
#   OUTPUT_VARIABLE EMSDK_OUTPUT
#   ECHO_OUTPUT_VARIABLE
#   ECHO_ERROR_VARIABLE
# )
# string(REPLACE "\n" "\n--   " EMSDK_OUTPUT ${EMSDK_OUTPUT})
# message(STATUS "output ${EMSDK_RESULT}:\n--   ${EMSDK_OUTPUT}")