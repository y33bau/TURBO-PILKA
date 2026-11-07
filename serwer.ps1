# Turbo Piłka – mini serwer do uruchomienia gry na tym komputerze (nic nie instaluje)
$root = (Split-Path -Parent $MyInvocation.MyCommand.Path).TrimEnd('\')
$l = $null; $port = 0
foreach ($p in 8765, 8766, 8767, 8780, 8790) {
  try { $t = New-Object System.Net.HttpListener; $t.Prefixes.Add("http://localhost:$p/"); $t.Start(); $l = $t; $port = $p; break } catch { }
}
if (-not $l) { Write-Host "Nie udalo sie uruchomic serwera (zajete porty)."; Read-Host "Enter, aby zamknac"; exit }
$mime = @{ '.html'='text/html; charset=utf-8'; '.js'='application/javascript; charset=utf-8'; '.png'='image/png'; '.txt'='text/plain; charset=utf-8'; '.json'='application/json' }
Start-Process "http://localhost:$port/index.html"
Write-Host ""
Write-Host "  TURBO PILKA dziala:  http://localhost:$port/"
Write-Host "  Zamknij to okno, zeby wylaczyc gre."
Write-Host ""
while ($l.IsListening) {
  try {
    $ctx = $l.GetContext()
    $rel = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath.TrimStart('/'))
    if ($rel -eq '') { $rel = 'index.html' }
    $file = [IO.Path]::GetFullPath((Join-Path $root $rel))
    if ($file.StartsWith($root, [StringComparison]::OrdinalIgnoreCase) -and (Test-Path -LiteralPath $file -PathType Leaf)) {
      $bytes = [IO.File]::ReadAllBytes($file); $ext = [IO.Path]::GetExtension($file).ToLower()
      $ctx.Response.ContentType = $(if ($mime.ContainsKey($ext)) { $mime[$ext] } else { 'application/octet-stream' })
      $ctx.Response.ContentLength64 = $bytes.Length
      $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    } else { $ctx.Response.StatusCode = 404 }
    $ctx.Response.Close()
  } catch { }
}
