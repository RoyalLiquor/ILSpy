# ILSpy Distribution Publishing Script
# 
# This script publishes ILSpy and its plugins for distribution to end users.
# It creates framework-dependent and self-contained builds for multiple architectures.
# 
# What it does:
#   - Publishes ILSpy WPF application for win-arm64 and win-x64 (framework-dependent)
#   - Publishes ILSpy.ReadyToRun and ILSpy.BamlDecompiler plugins
#   - Creates a self-contained win-x64 build with bundled .NET runtime
# 
# Prerequisites: 
#   - .NET 8.0 SDK or later must be installed
#   - Solution must be built in Release configuration first
# 
# Usage: Run from repository root after building the solution
# Output: Published files will be in ILSpy/bin/Release/net10.0-windows/{runtime}/publish/
# 

$output_arm64 = "./ILSpy/bin/Release/net10.0-windows/win-arm64/publish/fwdependent"
$output_x64 = "./ILSpy/bin/Release/net10.0-windows/win-x64/publish/fwdependent"
$output_x64_selfcontained = "./ILSpy/bin/Release/net10.0-windows/win-x64/publish/selfcontained"

dotnet publish ./ILSpy/ILSpy.csproj -c Release --no-restore --no-self-contained -r win-arm64 -o $output_arm64
dotnet publish ./ILSpy.ReadyToRun/ILSpy.ReadyToRun.csproj -c Release --no-restore --no-self-contained -r win-arm64 -o $output_arm64
dotnet publish ./ILSpy.BamlDecompiler/ILSpy.BamlDecompiler.csproj -c Release --no-restore --no-self-contained -r win-arm64 -o $output_arm64

dotnet publish ./ILSpy/ILSpy.csproj -c Release --no-restore --no-self-contained -r win-x64 -o $output_x64
dotnet publish ./ILSpy.ReadyToRun/ILSpy.ReadyToRun.csproj -c Release --no-restore --no-self-contained -r win-x64 -o $output_x64
dotnet publish ./ILSpy.BamlDecompiler/ILSpy.BamlDecompiler.csproj -c Release --no-restore --no-self-contained -r win-x64 -o $output_x64

dotnet publish ./ILSpy/ILSpy.csproj -c Release --no-restore --self-contained -r win-x64 -o $output_x64_selfcontained
dotnet publish ./ILSpy.ReadyToRun/ILSpy.ReadyToRun.csproj -c Release --no-restore --self-contained -r win-x64 -o $output_x64_selfcontained
dotnet publish ./ILSpy.BamlDecompiler/ILSpy.BamlDecompiler.csproj -c Release --no-restore --self-contained -r win-x64 -o $output_x64_selfcontained