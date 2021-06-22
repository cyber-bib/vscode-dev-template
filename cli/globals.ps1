$Git = 'C:\Program Files\Git\bin\git.exe'
$CMake  = 'C:\Program Files\CMake\bin\cmake.exe'

$Root = $PSScriptRoot
$Root = Split-Path -Path $Root -Parent
$RootName = Split-Path -Path $Root -Leaf