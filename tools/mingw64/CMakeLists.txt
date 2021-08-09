# https://downloads.sourceforge.net/project/mingw-w64/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-posix/seh/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z

cmake_minimum_required(VERSION 3.20.0 FATAL_ERROR)

# set(CMAKE_TOOLCHAIN_FILE "${EMSCRIPTEN_TOOLCHAIN_PATH}")
project(MinGW-Install
	VERSION 0.0.0.1
	DESCRIPTION "CMake Project Template"
	HOMEPAGE_URL "..."
	LANGUAGES C CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake")
include(Helpers)
add_project_defaults()

set(MINGW_POSTFIX "7z")
set(MINGW_VERSION "8.1.0")
set(MINGW_ARCH "x86_64")
set(MINGW_OS "Win64")
set(MINGW_THREADS "posix")
set(MINGW_EXCEPTION "seh")

set(MINGW_INSTALLER_NAME "${MINGW_ARCH}-${MINGW_VERSION}-release-${MINGW_THREADS}-${MINGW_EXCEPTION}-rt_v6-rev0.${MINGW_POSTFIX}")
set(MINGW_INSTALLER_PATH "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${MINGW_INSTALLER_NAME}")
set(MINGW_INSTALLER_SOURCE "https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20${MINGW_OS}/Personal%20Builds/mingw-builds/${MINGW_VERSION}/threads-${MINGW_THREADS}/${MINGW_EXCEPTION}/${MINGW_INSTALLER_NAME}")

# set(MINGW_INSTALLER_SOURCE "https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/mingw-w64-v9.0.0.zip/download")

set(GCC_EXECUTABLE "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/bin/gcc.exe")
if(NOT EXISTS ${GCC_EXECUTABLE})
  if(EXISTS ${MINGW_INSTALLER_PATH})
    message(STATUS "MinGW installer found.")
  else()
    message(STATUS "MinGW not found. Downloading from ${MINGW_INSTALLER_SOURCE}")
    file(DOWNLOAD
      "${MINGW_INSTALLER_SOURCE}"
      "${MINGW_INSTALLER_PATH}"
      SHOW_PROGRESS
    )
  endif()

  file(ARCHIVE_EXTRACT
    INPUT "${MINGW_INSTALLER_PATH}"
    DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
    VERBOSE
  )
  file(COPY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/mingw64/"
    DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
  )
  file(REMOVE_RECURSE "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/mingw64")

else()
  execute_process(
    COMMAND powershell ${GCC_EXECUTABLE} --version
    WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    RESULT_VARIABLE GCC_RESULT
    OUTPUT_VARIABLE GCC_OUTPUT
  )
  string(REPLACE "\n" ";" GCC_OUTPUT ${GCC_OUTPUT})
  list(GET GCC_OUTPUT 0 GCC_OUTPUT)

  string(REPLACE " " ";" GCC_OUTPUT ${GCC_OUTPUT})
  list(GET GCC_OUTPUT -1 GCC_OUTPUT)

  # string(REPLACE "Python " "" PYTHON_OUTPUT ${PYTHON_OUTPUT})
  message(STATUS "Found GCC version: ${GCC_OUTPUT}")

  # message(STATUS "Found MinGW.")
endif()

set(MINGW_DIR "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/bin")
set(MINGW_DIR "${MINGW_DIR}" PARENT_SCOPE)

set(MINGW_EXECUTABLE "${MINGW_DIR}/mingw32-make.exe")
set(MINGW_EXECUTABLE "${MINGW_EXECUTABLE}" PARENT_SCOPE)

set(GCC_EXECUTABLE "${MINGW_DIR}/gcc.exe")
set(GCC_EXECUTABLE "${GCC_EXECUTABLE}" PARENT_SCOPE)

set(GXX_EXECUTABLE "${MINGW_DIR}/g++.exe")
set(GXX_EXECUTABLE "${GXX_EXECUTABLE}" PARENT_SCOPE)
