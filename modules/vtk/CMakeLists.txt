cmake_minimum_required(VERSION 3.20.0 FATAL_ERROR)

project(vtk-install
	VERSION 0.0.0.1
	DESCRIPTION "VTK installition module"
	HOMEPAGE_URL "..."
  LANGUAGES C CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake")
include(Helpers)
add_project_defaults()

# message(STATUS "python: ${EMSDK_DIR}")

# https://gitlab.kitware.com/vtk/vtk.git

if((NOT DEFINED VTK_SOURCE_DIR) OR (VTK_SOURCE_DIR STREQUAL "VTK_SOURCE_DIR-NOTFOUND"))
  # set(VTK_DIR "VTK_DIR-NOTFOUND" CACHE PATH "vtk's cmake config file root directory")
  # message(FATAL_ERROR "vtk's cmake config file root directory not set/found")
  message(STATUS "vtk source was not found. attemping to download.")

  ExternalProject_Add(em-vtk-lib
    GIT_REPOSITORY
      "https://gitlab.kitware.com/vtk/vtk.git"
    UPDATE_DISCONNECTED
      TRUE
    CMAKE_COMMAND
      ${CMAKE_COMMAND} -E env 
        # latest {
          # EMSDK=${EMSDK_DIR}
          # EM_CONFIG=${EMSDK_DIR}/.emscripten
          # EMSDK_NODE=${EMSDK_DIR}/node/14.15.5_64bit/bin/node.exe
          # EMSDK_PYTHON=${EMSDK_DIR}/python/3.9.2-1_64bit/python.exe
          # JAVA_HOME=${EMSDK_DIR}/java/8.152_64bit
          # } latest
        # fastcomp_1_38_31 
          # "PATH": "possibly some other settings",
          # EMSDK=${EMSDK_DIR}
          # EM_CONFIG=${EMSDK_DIR}/.emscripten
          # } fastcomp_1_38_31
        
        ${CMAKE_COMMAND}
    CMAKE_GENERATOR
      "MinGW Makefiles"
    CMAKE_ARGS
      -DCMAKE_MAKE_PROGRAM:FILEPATH=${MINGW_EXECUTABLE}
      -DCMAKE_TOOLCHAIN_FILE:FILEPATH=${EMSCRIPTEN_TOOLCHAIN_PATH}
      -DNODE_JS_EXECUTABLE=${EMSDK_DIR}/node/14.15.5_64bit/bin/node.exe
      -DCMAKE_BUILD_TYPE:STRING=Release
      # vtk settings {
        -DVTK_ENABLE_LOGGING:BOOL=OFF
        -DVTK_ENABLE_WRAPPING:BOOL=OFF
        -DVTK_LEGACY_REMOVE:BOOL=ON

        -DVTK_USE_SDL2:BOOL=ON
        -DVTK_OPENGL_USE_GLES:BOOL=ON
        -DVTK_NO_PLATFORM_SOCKETS:BOOL=ON
        -DVTK_MODULE_ENABLE_VTK_hdf5:STRING=NO
        -DH5_HAVE_GETPWUID:BOOL=OFF

        -DVTK_GROUP_ENABLE_Rendering:STRING=YES
        -DVTK_GROUP_ENABLE_Qt:STRING=YES

        # -D "FREETYPE_INCLUDE_DIRS:PATH='include'"
        # -D "FREETYPE_LIBRARY:STRING='freetype'"

        # -D "VTK_MODULE_ENABLE_VTK_RenderingContextOpenGL2=NO"

        -DBUILD_SHARED_LIBS:BOOL=OFF
        -DBUILD_EXAMPLES:BOOL=OFF
        -DBUILD_TESTING:BOOL=OFF

        -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}
        # } vtk settings
      # opengl settings {
        -DOPENGL_INCLUDE_DIR:PATH=${EMSDK_DIR}/upstream/emscripten/system/include 
        -DOPENGL_EGL_INCLUDE_DIR:PATH=${EMSDK_DIR}/upstream/emscripten/system/include 
        -DOPENGL_GLES2_INCLUDE_DIR:PATH=${EMSDK_DIR}/upstream/emscripten/system/include  
        -DOPENGL_GLES3_INCLUDE_DIR:PATH=${EMSDK_DIR}/upstream/emscripten/system/include 
        # }
      # compiler flags {
        # -D "CMAKE_CXX_FLAGS='${EMSCRIPTEN_CXX_FLAGS}'"
        # # compiler flags }
    # INSTALL_COMMAND
    #   ""
    # BUILD_ALWAYS
    #   TRUE
    LOG_CONFIGURE
      TRUE
    LOG_BUILD
      TRUE
    LOG_INSTALL
      TRUE
    USES_TERMINAL_CONFIGURE
      TRUE
    USES_TERMINAL_BUILD
      TRUE
    USES_TERMINAL_INSTALL
      TRUE
    )

endif()

# ExternalProject_Get_Property(em-vtk-lib BINARY_DIR)
set(EMVTK_DIR "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
set(EMVTK_DIR "${EMVTK_DIR}" PARENT_SCOPE)

# find_package(VTK REQUIRED)
# message (STATUS "VTK_VERSION: ${VTK_VERSION}")
# if (VTK_VERSION VERSION_LESS "9.0.1")
#   message(FATAL_ERROR "VTK Version ${VTK_VERSION} is not supported. Please Install VTK 9.0.1 or greater")
# endif()
