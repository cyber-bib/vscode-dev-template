. "${PSScriptRoot}\vars.ps1"

. $cmake `
    -S "$root\src"
    -B "$root\build\windows"