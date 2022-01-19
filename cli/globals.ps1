$Git = "C:\Program Files\Git\bin\git.exe"
$CMake  = "C:\Program Files\CMake\bin\cmake.exe"

$MinGWDir = "C:\Program Files\mingw-w64\x86_64-8.1.0-posix-seh-rt_v6-rev0\mingw64\bin"
$Make = "${MinGWDir}\mingw32-make.exe"
$C = "${MinGWDir}\gcc.exe"
$CXX = "${MinGWDir}\g++.exe"

$Env:Path += ";${MinGWDir}"

$Root = $PSScriptRoot
$Root = Split-Path -Path $Root -Parent
$RootName = Split-Path -Path $Root -Leaf
$ExeName = $RootName

$SourceDir = "${Root}\src"

$logout = "out"
$logerr = "err"
$logwrn = "wrn"
$logvrb = "verbose"
$logdbg = "dbg"
$loginf = "info"
$logpostfix = ".log"