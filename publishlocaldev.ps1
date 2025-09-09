# ILSpy Local Development Publishing Script
# 
# This script is specifically designed for local development of Visual Studio extensions (VSIX packages).
# It publishes ILSpy and plugins for both x64 and ARM64 architectures that VS2022 requires.
# 
# What it does:
#   - Publishes framework-dependent builds for win-x64 and win-arm64
#   - Includes ILSpy.ReadyToRun and ILSpy.BamlDecompiler plugins
#   - Optimized for VSIX development workflow (no self-contained builds)
# 
# Prerequisites: 
#   - .NET 8.0 SDK or later must be installed
#   - Solution must be built in Release configuration first
# 
# Usage: Run from repository root when developing VS extensions
# Output: Published files will be in ILSpy/bin/Release/net10.0-windows/{runtime}/publish/fwdependent/
# 

$output_x64 = "./ILSpy/bin/Release/net10.0-windows/win-x64/publish/fwdependent"

dotnet publish ./ILSpy/ILSpy.csproj -c Release --no-restore --no-self-contained -r win-x64 -o $output_x64
dotnet publish ./ILSpy.ReadyToRun/ILSpy.ReadyToRun.csproj -c Release --no-restore --no-self-contained -r win-x64 -o $output_x64
dotnet publish ./ILSpy.BamlDecompiler/ILSpy.BamlDecompiler.csproj -c Release --no-restore --no-self-contained -r win-x64 -o $output_x64

$output_arm64 = "./ILSpy/bin/Release/net10.0-windows/win-arm64/publish/fwdependent"

dotnet publish ./ILSpy/ILSpy.csproj -c Release --no-restore --no-self-contained -r win-arm64 -o $output_arm64
dotnet publish ./ILSpy.ReadyToRun/ILSpy.ReadyToRun.csproj -c Release --no-restore --no-self-contained -r win-arm64 -o $output_arm64
dotnet publish ./ILSpy.BamlDecompiler/ILSpy.BamlDecompiler.csproj -c Release --no-restore --no-self-contained -r win-arm64 -o $output_arm64