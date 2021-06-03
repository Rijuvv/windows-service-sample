﻿$pkg_name="wintest"
$pkg_origin="bbb"
$pkg_version="0.2.0"
$pkg_maintainer="Matt Wrock, Murali Valluri"
$pkg_license=@('MIT')
$pkg_description="A sample .NET Windows Service"
$pkg_bin_dirs=@("bin")

function Invoke-Build {
  Copy-Item $PLAN_CONTEXT/../* $HAB_CACHE_SRC_PATH/$pkg_dirname -recurse -force -Exclude ".vs"
  ."$env:SystemRoot\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe" $HAB_CACHE_SRC_PATH/$pkg_dirname/${pkg_name}.csproj /t:Build /p:Configuration=Release
  if($LASTEXITCODE -ne 0) {
      Write-Error "dotnet build failed!"
  }
}

function Invoke-Install {
  Copy-Item $HAB_CACHE_SRC_PATH/$pkg_dirname/bin/release/* $pkg_prefix/bin
}
