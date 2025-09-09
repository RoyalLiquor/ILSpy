@rem Code Formatting Trigger Script
@rem 
@rem This script manually triggers the same code formatting that runs during git commits.
@rem It uses the pre-commit hook script to format all C# files in the solution using dotnet-format.
@rem 
@rem Purpose: Allow developers to format code without making a commit
@rem Usage: Run this script from anywhere - it will change to the repository root automatically
@rem Requirements: Git for Windows must be installed (uses Git's bash)
@rem 
@rem This file can be used to trigger the commit hook's formatting,
@rem modifying the local formatting even if not committing all changes.
pushd %~dp0\..
"%ProgramFiles%\Git\usr\bin\bash.exe" BuildTools\pre-commit --format
popd