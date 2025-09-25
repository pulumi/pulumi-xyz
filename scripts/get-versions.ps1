Param()

  $gomod = Join-Path "{{config_root}}" "go.mod"
  if (!(Test-Path $gomod)) {
      Write-Error "missing $gomod"
      exit 1
  }

  $lines = Get-Content $gomod

  # Pulumi version (strip the leading v)
  $pulumiLine = $lines | Where-Object { $_ -match 'github\.com/pulumi/pulumi/pkg/v3' } | Select-Object -First 1
  if (-not $pulumiLine) {
      Write-Error "failed to determine Pulumi version from $gomod"
      exit 1
  }
  $pulumiVersion = ($pulumiLine -split '\s+') | Where-Object { $_ -match '^v[0-9]' } | Select-Object -First 1
  $pulumiVersion = $pulumiVersion.TrimStart('v')

  # Go version (prefer toolchain, fall back to go line)
  $goToolchain = $lines | Where-Object { $_ -match '^toolchain\s+go[0-9]' } | Select-Object -First 1
  if ($goToolchain) {
      $goVersion = ($goToolchain -split '\s+')[-1].TrimStart('go')
  } else {
      $goLine = $lines | Where-Object { $_ -match '^go\s+[0-9]' } | Select-Object -First 1
      if (-not $goLine) {
          Write-Error "failed to determine Go version from $gomod"
          exit 1
      }
      $goVersion = ($goLine -split '\s+')[-1]
  }

  Write-Output "GO_VERSION=$goVersion"
  Write-Output "PULUMI_VERSION=$pulumiVersion"
