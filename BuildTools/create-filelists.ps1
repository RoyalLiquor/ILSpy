# Installation Package File List Generator
# 
# This script generates file lists for installer packages (.vsix, .msi) by examining
# the contents of built artifacts and creating corresponding .filelist files.
# These file lists are used during the packaging process for distribution.
# 
# Purpose: Automatically generate file lists for installer packages from build outputs
# Usage: Run after building the solution to update file lists for packaging
# Requirements: PowerShell, built artifacts must exist in bin\Debug\ directories
# Output: Creates/updates .filelist files for packaging tools
# 
$ErrorActionPreference = "Stop";

$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False

gci -Include *.vsix, *.msi -recurse | foreach ($_) {
    if (-not ($_.FullName -contains "\bin\Debug\")) {
        continue;
    }
    $idx=-1;
    $body=$false;
    $outputFileName = ".\BuildTools\$($_.Name -replace '-\d+\.\d+\.\d+\.\d+', '').filelist";
    $lines = 7z l $_.FullName  | foreach {
        if ($idx -eq -1) {
            $idx = $_.IndexOf("Name");
        }
        $p = $body;
        if ($idx -gt 0) {
            $body = ($body -ne ($_ -match ' *-[ -]+'))
        }
        if ($p -and $body) {
            $_.Substring($idx)
        }
    } | sort
    [System.IO.File]::WriteAllLines($outputFileName, $lines, $Utf8NoBomEncoding)
}
