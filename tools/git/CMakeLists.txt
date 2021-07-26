# https://github.com/git/git.git
# https://github.com/git-for-windows/git/releases/download/v2.32.0.windows.2/MinGit-2.32.0.2-64-bit.zip
# https://github.com/git-for-windows/git/releases/download/v2.32.0.windows.2/PortableGit-2.32.0.2-64-bit.7z.exe

cmake_minimum_required(VERSION 3.20.0 FATAL_ERROR)

project(Git-Install
	VERSION 0.0.0.1
	DESCRIPTION "Git Installition module"
	HOMEPAGE_URL "..."
  LANGUAGES C CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake")
include(Helpers)
add_project_defaults()

# if(IS_WINDOWS)
# endif()

set(GIT_POSTFIX "zip")
set(GIT_VER "2.32.0.2")
set(GIT_ARCH "64-bit")
set(GIT_INSTALLER_NAME "MinGit-${GIT_VER}-${GIT_ARCH}.${GIT_POSTFIX}")
set(GIT_INSTALLER_PATH "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${GIT_INSTALLER_NAME}")
set(GIT_INSTALLER_SOURCE "https://github.com/git-for-windows/git/releases/download/v2.32.0.windows.2/${GIT_INSTALLER_NAME}")

find_package(Git QUIET)
if(NOT Git_FOUND)
  if(EXISTS ${GIT_INSTALLER_PATH})
    message(STATUS "Git installer found.")
  else()
    message(STATUS "Git not found. Downloading from ${GIT_INSTALLER_SOURCE}")
    file(DOWNLOAD
      "${GIT_INSTALLER_SOURCE}"
      "${GIT_INSTALLER_PATH}"
      SHOW_PROGRESS
    )
  endif()

  file(ARCHIVE_EXTRACT
    INPUT "${GIT_INSTALLER_PATH}"
    DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
    VERBOSE
  )
else()
  message(STATUS "Found Git.")
endif()
