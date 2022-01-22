
find_package(VTK REQUIRED)
message(STATUS "vtk: ${VTK_LIBRARIES}")

add_library(em-viewport-lib)

target_sources(em-viewport-lib
	PUBLIC
		"${CMAKE_CURRENT_LIST_DIR}/viewport-fd.hxx"
		"${CMAKE_CURRENT_LIST_DIR}/viewport.hxx"
	PRIVATE
		"${CMAKE_CURRENT_LIST_DIR}/viewport.cxx"
)

target_link_libraries(em-viewport-lib
	PUBLIC
		"${VTK_LIBRARIES}"
)

target_include_directories(em-viewport-lib
	PUBLIC
		"${CMAKE_CURRENT_LIST_DIR}"
)

# add_custom_target(em-viewport-core ALL
# 	${CMAKE_COMMAND}
# 		-E env
# 			EMSDK=${EMSDK_PATH}
# 			EM_CONFIG=${EMSDK_PATH}/.emscripten
# 			EMSDK_NODE=${EMSDK_PATH}/node/14.15.5_64bit/bin/node.exe
# 			EMSDK_PYTHON=${EMSDK_PATH}/python/3.9.2-1_64bit/python.exe
# 			JAVA_HOME=${EMSDK_PATH}/java/8.152_64bit
# 			${CMAKE_COMMAND}
# 				--build ./
# 				--target em-viewport-lib
# 	USES_TERMINAL
# )