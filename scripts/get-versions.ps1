Param(
      [ValidateSet('go','pulumi')]
      [string]$Name
  )

  $gomod = Join-Path "{{config_root}}" "go.mod"
  if (!(Test-Path $gomod)) {
      throw "missing $gomod"
  }

  $lines = Get-Content $gomod

  # Pulumi version (strip the leading “v”)
  $pulumiLine = $lines |
      Where-Object { $_ -match 'github\.com/pulumi/pulumi/pkg/v3' } |
      Select-Object -First 1
  if (-not $pulumiLine) {
      throw "failed to determine Pulumi version from $gomod"
  }
  $pulumiVersion = ($pulumiLine -split '\s+') |
      Where-Object { $_ -match '^v[0-9]' } |
      Select-Object -First 1
  $pulumiVersion = $pulumiVersion.TrimStart('v')

  # Go version (prefer toolchain, fall back to go line)
  $goToolchain = $lines |
      Where-Object { $_ -match '^toolchain\s+go[0-9]' } |
      Select-Object -First 1
  if ($goToolchain) {
      $goVersion = ($goToolchain -split '\s+')[-1].TrimStart('go')
  } else {
      $goLine = $lines |
          Where-Object { $_ -match '^go\s+[0-9]' } |
          Select-Object -First 1
      if (-not $goLine) {
          throw "failed to determine Go version from $gomod"
      }
      $goVersion = ($goLine -split '\s+')[-1]
  }

  if ($Name -eq 'go') {
      Write-Output $goVersion
  } elseif ($Name -eq 'pulumi') {
      Write-Output $pulumiVersion
  }
