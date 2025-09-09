@rem Debug Build Script for ILSpy
@rem 
@rem This script builds the ILSpy solution in Debug configuration using Visual Studio 2022's MSBuild.
@rem It first restores NuGet packages, then compiles all projects in the solution.
@rem 
@rem Prerequisites: 
@rem   - Visual Studio 2022 must be installed
@rem   - NuGet CLI tools must be available in PATH
@rem Usage: Run this script from the repository root directory to build debug binaries
@rem Output: Debug binaries will be generated in bin/Debug folders of each project
@rem 
@setlocal enabledelayedexpansion
@set MSBUILD=
@for /D %%M in ("%ProgramFiles%\Microsoft Visual Studio\2022"\*) do @(
    @if exist "%%M\MSBuild\Current\Bin\MSBuild.exe" (
        @set "MSBUILD=%%M\MSBuild\Current\Bin\MSBuild.exe"
    )
)
@if "%MSBUILD%" == "" (
    @echo Could not find VS2022 MSBuild
    @exit /b 1
)
@nuget restore ILSpy.sln || (pause && exit /b 1)
"%MSBUILD%" ILSpy.sln /p:Configuration=Debug "/p:Platform=Any CPU" || (pause && exit /b 1)
