@rem Clean Build Script for ILSpy
@rem 
@rem This script removes all build artifacts and output files from both Debug and Release configurations.
@rem It automatically locates Visual Studio 2022's MSBuild and runs the Clean target on the solution.
@rem 
@rem Prerequisites: Visual Studio 2022 must be installed
@rem Usage: Simply run this script from the repository root directory
@rem 
@setlocal enabledelayedexpansion
@set MSBUILD=
@for /D %%M in ("%ProgramFiles%\Microsoft Visual Studio\2022"\*) do (
    @if exist "%%M\MSBuild\Current\Bin\MSBuild.exe" (
        @set "MSBUILD=%%M\MSBuild\Current\Bin\MSBuild.exe"
    )
)
@if "%MSBUILD%" == "" (
    @echo Could not find VS2022 MSBuild
    @exit /b 1
)
"%MSBUILD%" /m ILSpy.sln /t:Clean /p:Configuration=Debug "/p:Platform=Any CPU" || pause
"%MSBUILD%" /m ILSpy.sln /t:Clean /p:Configuration=Release "/p:Platform=Any CPU" || pause
