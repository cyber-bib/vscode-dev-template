. "${PSScriptRoot}\vars.ps1"

# $Env:C = $C
# $Env:CXX = $CXX

. $CMake `
	-S "$SourceDir" `
	-B "$BuildDir" `
	-G "MinGW Makefiles" `
	-D "CMAKE_MAKE_PROGRAM:FILEPATH=${Make}" `
	-D "CMAKE_C_COMPILER:FILEPATH='${C}'" `
	-D "CMAKE_CXX_COMPILER:FILEPATH='${CXX}'"

# -D "CMAKE_C_COMPILER='$($GCC -Replace '[\\]', '/')'" `
# -D "CMAKE_CXX_COMPILER=$($GCC -Replace '[\\]', '/')"