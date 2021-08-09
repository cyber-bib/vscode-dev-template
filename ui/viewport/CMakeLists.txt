cmake_minimum_required(VERSION 3.20.0 FATAL_ERROR)

# message(STATUS "running \"./emsdk_env.ps1\" this may take a few minutes.")
# execute_process(
#   COMMAND powershell "${EMSDK_DIR}/emsdk_env.ps1"
#   RESULT_VARIABLE EMSDK_RESULT
#   OUTPUT_VARIABLE EMSDK_OUTPUT
#   ECHO_OUTPUT_VARIABLE
#   ECHO_ERROR_VARIABLE

# set(ENV{Path} "$ENV{Path};\
	# 	C:/UserData/z0042sxn/Documents/git/vscode-dev-template/build/tools/emsdk/bin;\
	# 	C:/UserData/z0042sxn/Documents/git/vscode-dev-template/build/tools/emsdk/bin/node/14.15.5_64bit/bin;\
	# 	C:/UserData/z0042sxn/Documents/git/vscode-dev-template/build/tools/emsdk/bin/upstream/emscripten;\
	# 	C:/Program Files (x86)/Zulu/zulu-8-jre/bin/;\
	# 	C:/Program Files/Zulu/zulu-8-jre/bin/;\
	# 	C:/Program Files (x86)/Common Files/Intel/Shared Libraries/redist/ia32/mpirt;\
	# 	C:/Program Files (x86)/Common Files/Intel/Shared Libraries/redist/ia32/compiler;\
	# 	C:/Program Files (x86)/Common Files/Intel/Shared Files/fortran/bin/ia32;\
	# 	C:/WINDOWS/system32;\
	# 	C:/WINDOWS;\
	# 	C:/WINDOWS/System32/Wbem;\
	# 	C:/WINDOWS/System32/WindowsPowerShell/v1.0/;\
	# 	C:/WINDOWS/System32/OpenSSH/;\
	# 	C:/Program Files/IcedTeaWeb/WebStart/bin;\
	# 	C:/Program Files (x86)/Pulse Secure/VC142.CRT/X64/;\
	# 	C:/Program Files (x86)/Pulse Secure/VC142.CRT/X86/;\
	# 	C:/Program Files/CMake/bin;\
	# 	C:/Program Files/Git/bin;\
	# 	C:/Program Files/Microsoft VS Code/bin;\
	# 	C:/Users/z0042sxn/AppData/Local/Microsoft/WindowsApps;\
	# 	C:/UserData/z0042sxn/Documents/git/vscode-dev-template/build/tools/python/bin;\
	# 	C:/UserData/z0042sxn/Documents/git/vscode-dev-template/build/tools/mingw64/bin/bin;\
	# 	C:/UserData/z0042sxn/Documents/git/vscode-dev-template/build/tools/python/bin"
	# ) )
# list(APPEND ENV{PATH} "C:/UserData/z0042sxn/Documents/git/vscode-dev-template/build/tools/python/bin")

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
		# set(TRAIN_UI_DIR "${CMAKE_CURRENT_LIST_DIR}/src/ui")
		# set(TRAIN_VIEWPORT_DIR "${TRAIN_UI_DIR}/gui/viewport")
		# Old way of setting compiler flags # {
			# message("\t- C compiler: ${CMAKE_C_COMPILER}")
			# message("\t- C++ compiler: ${CMAKE_CXX_COMPILER}")
			# message("emscripten toolchain file: ${CMAKE_TOOLCHAIN_FILE}")
			# message("emscripten root: ${EMSCRIPTEN_ROOT_PATH}")
			# message("\t- SDL2 Include: ${SDL2_INCLUDE_DIRS}")

			# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s EXPORT_NAME=CylinderExample")
			# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --bind")
			# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g3")
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
		# New way of setting compiler flags (seems to be broken) {
			# list(APPEND EMSCRIPTEN_OPTIONS
			# 	# "SHELL:-s EXPORT_NAME=geogram"
			# 	"SHELL:-s WASM=1"
			# 	"SHELL:-s WASM_ASYNC_COMPILATION=1"
			# 	"SHELL:-s USE_SDL=2"
			# 	"SHELL:-s FULL_ES3=1"
			# 	"SHELL:-s ALLOW_MEMORY_GROWTH=1"
			# 	"SHELL:-s DEMANGLE_SUPPORT=1"
			# 	"SHELL:-s EMULATE_FUNCTION_POINTER_CASTS=0"
			# 	"SHELL:-s ERROR_ON_UNDEFINED_SYMBOLS=0"
			# 	"SHELL:-s USE_PTHREADS=0"
			# 	"SHELL:-s MODULARIZE=1"
			# 	"SHELL:--shell-file ${TRAIN_VIEWPORT_DIR}/viewport.html"
			# 	# "SHELL:-s EXPORTED_FUNCTIONS=\"[]\""
			# 	# "SHELL:-s ENVIRONMENT=web"
			# 	# "-g3"
			# 	# "-O3"
			# 	# "--bind"
			# )
			# }

		# message("\t- Flags: ${CMAKE_CXX_FLAGS}")
		set(CMAKE_EXECUTABLE_SUFFIX ".html")
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