. "${PSScriptRoot}\vars.ps1"

$logpath = "${LogDir}\config"
$logprefix = "config-"

If(!(Test-Path $logpath)) {
  New-Item -ItemType Directory -Force -Path $logpath
}

cmake `
  -S "${Root}" `
  --preset win-mingw `
  $args -LA `
  1> "${logpath}/${logprefix}${logout}${logpostfix}" `
  2> "${logpath}/${logprefix}${logerr}${logpostfix}" `
  3> "${logpath}/${logprefix}${logwrn}${logpostfix}" `
  4> "${logpath}/${logprefix}${logvrb}${logpostfix}" `
  5> "${logpath}/${logprefix}${logdbg}${logpostfix}" `
  6> "${logpath}/${logprefix}${loginf}${logpostfix}"