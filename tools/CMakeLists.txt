
# add_subdirectory(git)
# add_subdirectory(powershell)

add_subdirectory(python)
if(EXISTS ${Python3_EXECUTABLE})
  set(PYTHON_DIR ${PYTHON_DIR} PARENT_SCOPE)
  set(Python3_EXECUTABLE ${Python3_EXECUTABLE} PARENT_SCOPE)
  # set(ENV{PATH} "$ENV{PATH};${Python3_PATH}")
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
  set(MINGW_DIR ${MINGW_DIR} PARENT_SCOPE)
  set(MINGW_EXECUTABLE "${MINGW_EXECUTABLE}" PARENT_SCOPE)
  set(GCC_EXECUTABLE "${GCC_EXECUTABLE}" PARENT_SCOPE)
  set(GXX_EXECUTABLE "${GXX_EXECUTABLE}" PARENT_SCOPE)

  # set(ENV{PATH} "$ENV{PATH};${MINGW_DIR}")

  # string(REPLACE ";" "\n\t" TEMP $ENV{PATH})
  # message(STATUS "ENV:PATH:\n\t${TEMP}")
endif()

add_subdirectory(emsdk)
if(EXISTS ${EMSCRIPTEN_TOOLCHAIN_PATH})
  set(EMSCRIPTEN_TOOLCHAIN_PATH "${EMSCRIPTEN_TOOLCHAIN_PATH}" PARENT_SCOPE)
  set(EMSDK_DIR "${EMSDK_DIR}" PARENT_SCOPE)

endif()

# add_subdirectory(mingw)
