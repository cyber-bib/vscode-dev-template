. "${PSScriptRoot}\vars.ps1"

$logpath = "${LogDir}\config"
$logprefix = "config-"

If(!(Test-Path $logpath)) {
  New-Item -ItemType Directory -Force -Path $logpath
}

cmake `
  -S "${Root}" `
  --preset win-emsdk `
  $args -LA `
  1> "${logpath}/${logprefix}${logout}${logpostfix}" `
  2> "${logpath}/${logprefix}${logerr}${logpostfix}" `
  3> "${logpath}/${logprefix}${logwrn}${logpostfix}" `
  4> "${logpath}/${logprefix}${logvrb}${logpostfix}" `
  5> "${logpath}/${logprefix}${logdbg}${logpostfix}" `
  6> "${logpath}/${logprefix}${loginf}${logpostfix}"

# cmake -S "${Root}" -B "${BuildDir}" --preset win-emsdk $args -LA 1> "${logpath}/${logprefix}${logout}${logpostfix}" 2> "${logpath}/${logprefix}${logerr}${logpostfix}" 3> "${logpath}/${logprefix}${logwrn}${logpostfix}" 4> "${logpath}/${logprefix}${logvrb}${logpostfix}" 5> "${logpath}/${logprefix}${logdbg}${logpostfix}" 6> "${logpath}/${logprefix}${loginf}${logpostfix}"

# $Env:C = $C
# $Env:CXX = $CXX

# . $CMake `
# 	-S "$SourceDir" `
# 	-B "$BuildDir" `
# 	-G "MinGW Makefiles" `
# 	-D "CMAKE_MAKE_PROGRAM:FILEPATH=${Make}" `
# 	-D "CMAKE_C_COMPILER:FILEPATH='${C}'" `
# 	-D "CMAKE_CXX_COMPILER:FILEPATH='${CXX}'"

# -D "CMAKE_C_COMPILER='$($GCC -Replace '[\\]', '/')'" `
# -D "CMAKE_CXX_COMPILER=$($GCC -Replace '[\\]', '/')"