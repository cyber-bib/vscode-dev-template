cmake_minimum_required(VERSION 3.20.0 FATAL_ERROR)

# message(STATUS ${EMSCRIPTEN_TOOLCHAIN_PATH})
project(src-template
	VERSION 0.0.0.1
	DESCRIPTION "CMake Project Template"
	HOMEPAGE_URL "..."
	LANGUAGES C CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../cmake")
include(Helpers)
add_project_defaults()

if("${CMAKE_SYSTEM_NAME}" MATCHES "Emscripten")
	# # Old way of setting compiler flags # {
	# 	# message("\t- C compiler: ${CMAKE_C_COMPILER}")
	# 	# message("\t- C++ compiler: ${CMAKE_CXX_COMPILER}")
	# 	# message("emscripten toolchain file: ${CMAKE_TOOLCHAIN_FILE}")
	# 	# message("emscripten root: ${EMSCRIPTEN_ROOT_PATH}")
	# 	# message("\t- SDL2 Include: ${SDL2_INCLUDE_DIRS}")

	# 	# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s EXPORT_NAME=CylinderExample")
	# 	# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --bind")
	# 	# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g3")
	# 	# set(EMSCRIPTEN_CXX_FLAGS "-s USE_FREETYPE=0")
	# 	# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s USE_FREETYPE=0")
	# 	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s USE_SDL=2")
	# 	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s FULL_ES3=1")
	# 	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s WASM=1")
	# 	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s WASM_ASYNC_COMPILATION=1")
	# 	# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s USE_WEBGL2=1")
	# 	# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s MIN_WEBGL_VERSION=2")
	# 	# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s MAX_WEBGL_VERSION=2")
	# 	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s ALLOW_MEMORY_GROWTH=1")
		# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s DISABLE_DEPRECATED_FIND_EVENT_TARGET_BEHAVIOR=0")
	# 	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s ERROR_ON_UNDEFINED_SYMBOLS=0")
	# 	# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s MODULARIZE=1")
	# 	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s USE_PTHREADS=0")
	# 	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s DEMANGLE_SUPPORT=1")
	# 	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s EMULATE_FUNCTION_POINTER_CASTS=0")

	# 	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s FORCE_FILESYSTEM=1")
	# 	# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lnodefs.js")
		# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --shell-file ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/viewport.html")
	# 	# }	

			# "SHELL:--shell-file ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/viewport.html"
		set(emscripten_options)
		list(APPEND emscripten_options
			"--bind"
			"-g3"
			"-O3"
			"SHELL:-s EXPORT_NAME=vtkApp"
			"SHELL:-s ALLOW_MEMORY_GROWTH=1"
			"SHELL:-s DEMANGLE_SUPPORT=1"
			"SHELL:-s EMULATE_FUNCTION_POINTER_CASTS=0"
			"SHELL:-s ERROR_ON_UNDEFINED_SYMBOLS=0"
			"SHELL:-s MODULARIZE=1"
			"SHELL:-s USE_PTHREADS=0"
			"SHELL:-s WASM=1"
			"SHELL:-s WASM_ASYNC_COMPILATION=1"
			"SHELL:-s ASSERTIONS=1"
			"SHELL:-s DISABLE_DEPRECATED_FIND_EVENT_TARGET_BEHAVIOR=0"
		)
	# message("\t- Flags: ${CMAKE_CXX_FLAGS}")
		# set(CMAKE_EXECUTABLE_SUFFIX ".html")
	
else()
	message(FATAL_ERROR "${CMAKE_SYSTEM_NAME} system build is not supported")
endif()

find_package(VTK REQUIRED)
add_executable(${CMAKE_PROJECT_NAME}-bin main.cxx)

	# "${VTK_LIBRARIES}"
target_link_libraries(${CMAKE_PROJECT_NAME}-bin
	PUBLIC
		em-mainwindow-obj
)
target_compile_options(${CMAKE_PROJECT_NAME}-bin
  PUBLIC
    ${emscripten_options}
)
target_link_options(${CMAKE_PROJECT_NAME}-bin
  PUBLIC
    ${emscripten_options}
)
set_target_properties(${CMAKE_PROJECT_NAME}-bin
	PROPERTIES
		OUTPUT_NAME ${CMAKE_PROJECT_NAME}
)

vtk_module_autoinit(
  TARGETS  ${CMAKE_PROJECT_NAME}-bin
  MODULES  ${VTK_LIBRARIES}
)

# add_custom_target(genexdebug
# 	COMMAND ${CMAKE_COMMAND} -E echo "configuration type: $<CONFIG>"
# )

# set(MAIN_EXECUTABLE_PATH "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/Debug/${CMAKE_PROJECT_NAME}.exe")
# set(MAIN_EXECUTABLE_PATH ${MAIN_EXECUTABLE_PATH} PARENT_SCOPE)