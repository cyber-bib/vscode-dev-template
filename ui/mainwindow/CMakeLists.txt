
# find_package(VTK REQUIRED)
# message(STATUS "vtk: ${VTK_LIBRARIES}")

add_library(em-mainwindow-obj)

target_sources(em-mainwindow-obj
	PUBLIC
		"${CMAKE_CURRENT_LIST_DIR}/mainwindow.hxx"
	PRIVATE
		"${CMAKE_CURRENT_LIST_DIR}/mainwindow.cxx"
)

target_link_libraries(em-mainwindow-obj
	PUBLIC
		em-viewport-obj
)

target_include_directories(em-mainwindow-obj
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