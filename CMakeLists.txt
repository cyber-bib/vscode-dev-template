cmake_minimum_required(VERSION 3.20.0 FATAL_ERROR)

project(dev-template
	VERSION 0.0.0.1
	DESCRIPTION "CMake Development template project"
	HOMEPAGE_URL "..."
  LANGUAGES C CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(Helpers)
add_project_defaults()

add_subdirectory(modules external)

# set(CMAKE_TOOLCHAIN_FILE ${EMSCRIPTEN_TOOLCHAIN_PATH})
add_subdirectory(src core)

# if(IS_WINDOWS)
# endif()

# add_subdirectory(src)