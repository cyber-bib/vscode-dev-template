
# add_subdirectory(git)
# add_subdirectory(powershell)

add_subdirectory(python)
if(EXISTS ${Python3_EXECUTABLE})
  set(Python3_EXECUTABLE ${Python3_EXECUTABLE} PARENT_SCOPE)
endif()

add_subdirectory(node)
if(EXISTS ${NODE_EXECUTABLE})
  set(NODE_EXECUTABLE ${NODE_EXECUTABLE} PARENT_SCOPE)
endif()
if(EXISTS ${NPM_EXECUTABLE})
  set(NPM_EXECUTABLE ${NPM_EXECUTABLE} PARENT_SCOPE)
endif()

add_subdirectory(electron)
if(EXISTS ${ELECTRON_EXECUTABLE})
  set(ELECTRON_EXECUTABLE ${ELECTRON_EXECUTABLE} PARENT_SCOPE)
endif()

add_subdirectory(mingw64)
if(EXISTS ${MINGW_DIR})
  set(ELECTRON_EXECUTABLE ${MINGW_DIR} PARENT_SCOPE)
endif()

add_subdirectory(emsdk)
if(EXISTS ${EMSCRIPTEN_TOOLCHAIN_PATH})
  set(EMSCRIPTEN_TOOLCHAIN_PATH ${EMSCRIPTEN_TOOLCHAIN_PATH} PARENT_SCOPE)
endif()

# add_subdirectory(mingw)
