# Add viewport library {
	set(EM_VIEWPORT_LIB "em-viewport" PARENT_SCOPE)

	# list(APPEND TRAIN_LIBRARIES "${TEMP_LIB}")
	# set(TRAIN_LIBRARIES "${TRAIN_LIBRARIES}" PARENT_SCOPE)

	add_library("em-viewport" "")

	target_sources("em-viewport"
		PUBLIC
			"${CMAKE_CURRENT_LIST_DIR}/viewport-fd.hxx"
			"${CMAKE_CURRENT_LIST_DIR}/viewport.hxx"
		PRIVATE
			"${CMAKE_CURRENT_LIST_DIR}/viewport.cxx"
	)

	target_link_libraries("em-viewport"
		PUBLIC
			"${VTK_LIBRARIES}"
	)

	target_include_directories("em-viewport"
		PUBLIC
			"${CMAKE_CURRENT_LIST_DIR}"
	)
	# }