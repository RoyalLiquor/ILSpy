# ICSharpCode.Decompiler PowerShell Module Demo Script
# 
# This script demonstrates how to use the ICSharpCode.Decompiler PowerShell cmdlets
# for programmatic decompilation of .NET assemblies. It shows basic usage patterns
# and examples of the PowerShell interface to the ILSpy decompiler engine.
# 
# Purpose: Provide examples and test the PowerShell decompiler module
# Prerequisites: ICSharpCode.Decompiler.PowerShell module must be built first
# Usage: Run from the PowerShell project directory to test module functionality
# 
$basePath = $PSScriptRoot
if ([string]::IsNullOrEmpty($basePath))
{
    $basePath = Split-Path -parent $psISE.CurrentFile.Fullpath
}

$modulePath = $basePath + '\bin\Debug\netstandard2.0\ICSharpCode.Decompiler.Powershell.dll'

Import-Module $modulePath
$version = Get-DecompilerVersion
Write-Output $version

# different test assemblies - it makes a difference wrt .deps.json so there are two netstandard tests here
$asm_netstdWithDepsJson = $basePath + '\bin\Debug\netstandard2.0\ICSharpCode.Decompiler.Powershell.dll'
$asm_netstd = $basePath + '\bin\Debug\netstandard2.0\ICSharpCode.Decompiler.dll'

$decompiler = Get-Decompiler $asm_netstdWithDepsJson

$classes = Get-DecompiledTypes $decompiler -Types class
$classes.Count

foreach ($c in $classes)
{
    Write-Output $c.FullName
}


Get-DecompiledSource $decompiler -TypeName ICSharpCode.Decompiler.PowerShell.GetDecompilerCmdlet

Get-DecompiledProject $decompiler -OutputPath .\decomptest