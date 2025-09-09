# GitHub Actions Installation Script
# 
# This script installs required tools and dependencies for GitHub Actions CI/CD workflows.
# It's designed to be run in the GitHub Actions environment to set up the build environment.
# 
# Purpose: Prepare the CI environment with necessary build tools and dependencies
# Usage: Called automatically by GitHub Actions workflows (.github/workflows/*.yml)
# Requirements: PowerShell and appropriate permissions in the CI environment
# 
$ErrorActionPreference = "Stop"

$baseCommit = "d779383cb85003d6dabeb976f0845631e07bf463";
$baseCommitRev = 1;

# make sure this matches artifacts-only branches list in appveyor.yml!
$masterBranches = '^refs/heads/(master|release/.+)$';

$decompilerVersionInfoTemplateFile = "ICSharpCode.Decompiler/Properties/DecompilerVersionInfo.template.cs";

$versionParts = @{};
Get-Content $decompilerVersionInfoTemplateFile | where { $_ -match 'string (\w+) = "?(\w+)"?;' } | foreach { $versionParts.Add($Matches[1], $Matches[2]) }

$major = $versionParts.Major;
$minor = $versionParts.Minor;
$build = $versionParts.Build;
$versionName = $versionParts.VersionName;

if ($versionName -ne "null") {
    $versionName = "-$versionName";
} else {
    $versionName = "";
}

Write-Host "GITHUB_REF: '$env:GITHUB_REF'";

if ($env:GITHUB_REF -match $masterBranches) {
	$branch = "";
	$suffix = "";
} elseif ($env:GITHUB_REF -match '^refs/pull/(\d+)/merge$') {
	$branch = "";
	$suffix = "-pr" + $Matches[1];
} elseif ($env:GITHUB_REF -match '^refs/heads/(.+)$') {
	$branch = "-" + $Matches[1];
	$suffix = "";
} else {
	$branch = "";
	$suffix = "";
}

$revision = [Int32]::Parse((git rev-list --count "$baseCommit..HEAD")) + $baseCommitRev;

$newVersion="$major.$minor.$build.$revision";
$ilspyVersionNumber = "$newVersion$branch$versionName$suffix";
$ilspyVersionNumber = $ilspyVersionNumber.Replace("/", "-");
$env:ILSPY_VERSION_NUMBER="$ilspyVersionNumber";
$env:ILSPY_VERSION_NUMBER | Out-File "ILSPY_VERSION"
Write-Host "new version: $ilspyVersionNumber";
