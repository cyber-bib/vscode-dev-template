# https://www.python.org/ftp/python/3.9.6/python-3.9.6-amd64.exe
# https://www.python.org/ftp/python/3.9.6/python-3.9.6-embed-amd64.zip

cmake_minimum_required(VERSION 3.20.0 FATAL_ERROR)

project(Python-Install
	VERSION 0.0.0.1
	DESCRIPTION "Python Installition module"
	HOMEPAGE_URL "..."
  LANGUAGES C CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake")
include(Helpers)
add_project_defaults()

# if(IS_WINDOWS)
# endif()

set(PY_POSTFIX "zip")
set(PY_VER "3.9.6")
set(PY_ARCH "amd64")
set(PY_INSTALLER_NAME "python-${PY_VER}-embed-${PY_ARCH}.${PY_POSTFIX}")
set(PY_INSTALLER_PATH "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${PY_INSTALLER_NAME}")
set(PY_INSTALLER_SOURCE "https://www.python.org/ftp/python/${PY_VER}/${PY_INSTALLER_NAME}")

find_package(Python3 QUIET)
if(NOT Python3_FOUND)
  if(EXISTS ${PY_INSTALLER_PATH})
    message(STATUS "Python installer found.")
  else()
    message(STATUS "Python not found. Downloading from ${PY_INSTALLER_SOURCE}")
    file(DOWNLOAD
      "${PY_INSTALLER_SOURCE}"
      "${PY_INSTALLER_PATH}"
      SHOW_PROGRESS
    )
  endif()

  file(ARCHIVE_EXTRACT
    INPUT "${PY_INSTALLER_PATH}"
    DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
    VERBOSE
  )
  # set(Python3_DIR ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
  set(Python3_EXECUTABLE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/python.exe)
  find_package(Python3 REQUIRED)
else()
  message(STATUS "Found Python.")
endif()

set(Python3_EXECUTABLE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/python.exe)
set(Python3_EXECUTABLE ${Python3_EXECUTABLE} PARENT_SCOPE)
# set(ENV{PATH} "$ENV{PATH}${Python3_EXECUTABLE}" PARENT_SCOPE)
# message(STATUS "$ENV{PATH}")

  # execute_process(
  #   COMMAND "${PY_INSTALLER_PATH}"
  #   COMMAND_ECHO STDOUT
  # )