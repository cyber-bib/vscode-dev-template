cmake_minimum_required(VERSION 3.20.0 FATAL_ERROR)

set(ENV{EMSDK} "${EMSDK_DIR}")
set(ENV{EM_CONFIG} "${EMSDK_DIR}/.emscripten")
set(ENV{EMSDK_NODE} "${EMSDK_DIR}/node/14.15.5_64bit/bin/node.exe")
set(ENV{EMSDK_PYTHON} "${EMSDK_DIR}/python/3.9.2-1_64bit/python.exe")
set(ENV{JAVA_HOME} "${EMSDK_DIR}/java/8.152_64bit")

project(em-viewport-core
	VERSION 0.0.0.1
	DESCRIPTION "CMake Project Template"
	HOMEPAGE_URL "..."
	LANGUAGES C CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake")
include(Helpers)
add_project_defaults()


# Compiler configuration
	if("${CMAKE_SYSTEM_NAME}" MATCHES "Emscripten")
		# Old way of setting compiler flags # {
			# message("\t- C compiler: ${CMAKE_C_COMPILER}")
			# message("\t- C++ compiler: ${CMAKE_CXX_COMPILER}")
			# message("emscripten toolchain file: ${CMAKE_TOOLCHAIN_FILE}")
			# message("emscripten root: ${EMSCRIPTEN_ROOT_PATH}")
			# message("\t- SDL2 Include: ${SDL2_INCLUDE_DIRS}")

			# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s EXPORT_NAME=CylinderExample")
			# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --bind")
			# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g3")
			# set(EMSCRIPTEN_CXX_FLAGS "-s USE_FREETYPE=0")
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s USE_FREETYPE=0")
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s USE_SDL=2")
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s FULL_ES3=1")
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s WASM=1")
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s WASM_ASYNC_COMPILATION=1")
			# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s USE_WEBGL2=1")
			# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s MIN_WEBGL_VERSION=2")
			# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s MAX_WEBGL_VERSION=2")
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s ALLOW_MEMORY_GROWTH=1")
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s DISABLE_DEPRECATED_FIND_EVENT_TARGET_BEHAVIOR=0")
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s ERROR_ON_UNDEFINED_SYMBOLS=0")
			# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s MODULARIZE=1")
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s USE_PTHREADS=0")
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s DEMANGLE_SUPPORT=1")
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s EMULATE_FUNCTION_POINTER_CASTS=0")

			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s FORCE_FILESYSTEM=1")
			# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lnodefs.js")
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --shell-file ${CMAKE_CURRENT_LIST_DIR}/html/viewport.html")
			# }	

		# message("\t- Flags: ${CMAKE_CXX_FLAGS}")
		set(CMAKE_EXECUTABLE_SUFFIX ".html")
		
		find_package(VTK REQUIRED)
		
		message(STATUS "vtk: ${VTK_LIBRARIES}")
	else()
		message(FATAL_ERROR "${CMAKE_SYSTEM_NAME} system build is not supported")
	endif()

add_subdirectory(src)

# add_executable(${CMAKE_PROJECT_NAME}-bin main.cxx)
# set_target_properties(${CMAKE_PROJECT_NAME}-bin
# 	PROPERTIES
# 		OUTPUT_NAME ${CMAKE_PROJECT_NAME}
# )

# add_custom_target(genexdebug
# 	COMMAND ${CMAKE_COMMAND} -E echo "configuration type: $<CONFIG>"
# )