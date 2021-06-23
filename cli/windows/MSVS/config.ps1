. "${PSScriptRoot}\vars.ps1"

. $CMake `
	-S "$SourceDir" `
	-B "$BuildDir"