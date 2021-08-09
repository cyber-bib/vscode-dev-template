macro(developer_info) # {
  set(DEVELOPER_NAME "Luis Vega")
  set(DEVELOPER_EMAIL "luis.vega_merchan@siemens.com")
  endmacro() # }
macro(system_support) # {
  set(BAD_SYSTEM_NAME_MSG " system is currently not supported. Please email ${DEVELOPER_NAME} to ${DEVELOPER_EMAIL} to add support.")
  set(BAD_SYSTEM_PROCESSOR_MSG " processor is currently not supported. Please email ${DEVELOPER_NAME} to ${DEVELOPER_EMAIL} to add support.")

  string(COMPARE EQUAL ${CMAKE_SYSTEM_NAME} "Windows" IS_WINDOWS)
  string(COMPARE EQUAL ${CMAKE_SYSTEM_PROCESSOR} "AMD64" IS_AMD64)

  # message(STATUS "${CMAKE_SYSTEM_PROCESSOR}")

  # if(NOT IS_WINDOWS)
  #   message(FATAL_ERROR "${CMAKE_SYSTEM_NAME}${BAD_SYSTEM_NAME_MSG}")
  # endif()

  # if(NOT IS_AMD64)
  #   message(FATAL_ERROR "${CMAKE_SYSTEM_PROCESSOR}${BAD_SYSTEM_PROCESSOR_MSG}")
  # endif()

  endmacro() # }
macro(folder_build_structure) #{
  # get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
  # message(STATUS "Genarator type: ${isMultiConfig}")
  # message(STATUS "${CMAKE_CONFIGURATION_TYPES}")

  set(CMAKE_BUILD_TYPE "Release")

  set(CMAKE_CXX_STANDARD 11)
  set(CMAKE_CXX_EXTENSIONS OFF)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)

  include(GNUInstallDirs)

  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR})

  # foreach(TYPE IN LISTS CMAKE_CONFIGURATION_TYPES)
  # 	string(TOUPPER "${TYPE}" TYPE_DIR)
  # 	set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${TYPE_DIR} "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}/${TYPE}")
  # 	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${TYPE_DIR} "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}/${TYPE}")
  # 	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${TYPE_DIR} "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}/${TYPE}")
  #
  # 	# message(STATUS "type: ${TYPE} (${TYPE_DIR})")
  # 	# message(STATUS "path: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_${TYPE_DIR}}")
  # endforeach()
  # message(STATUS "path: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE}")
  endmacro() # }
macro(external_project_settings) # {
  set_property(DIRECTORY PROPERTY EP_BASE ${CMAKE_BINARY_DIR}/external)
  include(ExternalProject)

  endmacro() # }
macro(add_project_defaults) # {
  developer_info()
  system_support()
  folder_build_structure()
  external_project_settings()
endmacro() # }