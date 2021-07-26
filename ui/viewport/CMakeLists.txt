cmake_minimum_required(VERSION 3.20.0 FATAL_ERROR)

project(layout-template
	VERSION 0.0.0.1
	DESCRIPTION "CMake Project Template"
	HOMEPAGE_URL "..."
	LANGUAGES NONE
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake")
include(Helpers)
add_project_defaults()


# add_executable(${CMAKE_PROJECT_NAME}-bin main.cxx)
# set_target_properties(${CMAKE_PROJECT_NAME}-bin
# 	PROPERTIES
# 		OUTPUT_NAME ${CMAKE_PROJECT_NAME}
# )

# add_custom_target(genexdebug
# 	COMMAND ${CMAKE_COMMAND} -E echo "configuration type: $<CONFIG>"
# )