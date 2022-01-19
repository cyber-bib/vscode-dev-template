. "${PSScriptRoot}\vars.ps1"

$logpath = "${LogDir}\build"
$logprefix = "build-"

If(!(Test-Path $logpath)) {
  New-Item -ItemType Directory -Force -Path $logpath
}

cmake --build "${BuildDir}" $args `
  1> "${logpath}/${logprefix}${logout}${logpostfix}" `
  2> "${logpath}/${logprefix}${logerr}${logpostfix}" `
  3> "${logpath}/${logprefix}${logwrn}${logpostfix}" `
  4> "${logpath}/${logprefix}${logvrb}${logpostfix}" `
  5> "${logpath}/${logprefix}${logdbg}${logpostfix}" `
  6> "${logpath}/${logprefix}${loginf}${logpostfix}"

# . $CMake --build "${BuildDir}" --target genexdebug