# Resource File Sorting Script
# 
# This script sorts XML elements in .resx (resource) files to ensure consistent ordering.
# It helps maintain clean diffs and reduces merge conflicts in resource files.
# 
# Purpose: Automatically sort resource entries in .resx files across the solution
# Usage: Run from repository root to sort all .resx files recursively
# Requirements: PowerShell with .NET Framework XML support
# Output: Modifies .resx files in-place with sorted entries
# 
$ErrorActionPreference = "Stop";

[Reflection.Assembly]::LoadWithPartialName("System.Xml.Linq") | Out-Null

Write-Host "Sorting .resx files...";

Get-ChildItem -Include *.resx -Recurse | foreach ($_) {
	Write-Host $_.FullName;
	
	$doc = [System.Xml.Linq.XDocument]::Load($_.FullName);
	$descendants = [System.Linq.Enumerable]::ToArray($doc.Descendants("data"));

	[System.Xml.Linq.Extensions]::Remove($descendants);
	$ordered = [System.Linq.Enumerable]::OrderBy($descendants, [System.Func[System.Xml.Linq.XElement,string]] { param ($e) $e.Attribute("name").Value }, [System.StringComparer]::Ordinal);
	$doc.Root.Add($ordered);
	$doc.Save($_.FullName);
}

