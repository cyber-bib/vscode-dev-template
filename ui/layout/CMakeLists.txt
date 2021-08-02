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


# Generate html files
  set(HTML_DOCUMENT_TITLE "CMake-Generated File")

  file(READ html/links.html HTML_LINKS_FILE)
  string(REPLACE "\n" "\n  " HTML_LINKS_FILE "${HTML_LINKS_FILE}")
  file(READ html/scripts.html HTML_SCRIPTS_FILE)
  string(REPLACE "\n" "\n  " HTML_SCRIPS_FILE "${HTML_SCRIPTS_FILE}")

  file(READ html/head.html HTML_HEAD_FILE)
  string(REPLACE "@HTML_DOCUMENT_TITLE@" "${HTML_DOCUMENT_TITLE}" HTML_HEAD_FILE "${HTML_HEAD_FILE}")
  string(REPLACE "@HTML_LINKS_FILE@" "${HTML_LINKS_FILE}" HTML_HEAD_FILE "${HTML_HEAD_FILE}")
  string(REPLACE "@HTML_SCRIPTS_FILE@" "${HTML_SCRIPTS_FILE}" HTML_HEAD_FILE "${HTML_HEAD_FILE}")
  string(REPLACE "\n" "\n  " HTML_HEAD_FILE "${HTML_HEAD_FILE}")

  file(READ html/navbar.html HTML_NAVBAR_FILE)
  string(REPLACE "\n" "\n    " HTML_NAVBAR_FILE "${HTML_NAVBAR_FILE}")
  file(READ html/header.html HTML_HEADER_FILE)
  string(REPLACE "\n" "\n    " HTML_HEADER_FILE "${HTML_HEADER_FILE}")
  file(READ html/main.html HTML_MAIN_FILE)
  string(REPLACE "\n" "\n    " HTML_MAIN_FILE "${HTML_MAIN_FILE}")
  file(READ html/footer.html HTML_FOOTER_FILE)
  string(REPLACE "\n" "\n    " HTML_FOOTER_FILE "${HTML_FOOTER_FILE}")
  file(READ html/templates.html HTML_TEMPLATE_FILE)
  string(REPLACE "\n" "\n    " HTML_TEMPLATE_FILE "${HTML_TEMPLATE_FILE}")

  file(READ html/single.html HTML_SINGLE_FILE)
  string(REPLACE "@HTML_HEAD_FILE@" "${HTML_HEAD_FILE}" HTML_SINGLE_FILE "${HTML_SINGLE_FILE}")
  string(REPLACE "@HTML_NAVBAR_FILE@" "${HTML_NAVBAR_FILE}" HTML_SINGLE_FILE "${HTML_SINGLE_FILE}")
  string(REPLACE "@HTML_HEADER_FILE@" "${HTML_HEADER_FILE}" HTML_SINGLE_FILE "${HTML_SINGLE_FILE}")
  string(REPLACE "@HTML_MAIN_FILE@" "${HTML_MAIN_FILE}" HTML_SINGLE_FILE "${HTML_SINGLE_FILE}")
  string(REPLACE "@HTML_FOOTER_FILE@" "${HTML_FOOTER_FILE}" HTML_SINGLE_FILE "${HTML_SINGLE_FILE}")
  string(REPLACE "@HTML_TEMPLATE_FILE@" "${HTML_TEMPLATE_FILE}" HTML_SINGLE_FILE "${HTML_SINGLE_FILE}")

# Generate javascript files
  file(READ js/helpers.js JS_HELPERS_FILE)
  file(READ js/actions.js JS_ACTIONS_FILE)

  file(READ json/navbar.json JSON_NAVBAR_FILE)
  string(REPLACE "\n" "\n  " JSON_NAVBAR_FILE "${JSON_NAVBAR_FILE}")

  file(READ js/single.js JS_SINGLE_FILE)
  string(REPLACE "@JS_HELPERS_FILE@" "${JS_HELPERS_FILE}" JS_SINGLE_FILE "${JS_INDEX_FILE}")
  string(REPLACE "@JSON_NAVBAR_FILE@" "${JSON_NAVBAR_FILE}" JS_SINGLE_FILE "${JS_INDEX_FILE}")


# Configure files
  # set(HTML_INDEX_FILE ${HTML_SINGLE_FILE})
  # set(HTML_INDEX_FILE ${HTML_SINGLE_FILE})

  file(MAKE_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/layout)

  configure_file(js/single.js ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/layout/index.js @ONLY)
  configure_file(html/single.html ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/layout/index.html @ONLY)

  # file(COPY js/index.js DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/layout/)

  set(UI_LAYOUT_DIR ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/layout)
  set(UI_LAYOUT_DIR ${UI_LAYOUT_DIR} PARENT_SCOPE)