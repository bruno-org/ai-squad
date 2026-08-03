# Instalador do AI-SQUAD para Windows.
#
# O que ele faz:
#   1. copia o AI-SQUAD para ~\.ai-squad (vendor, templates, ferramentas)
#   2. copia as skills para ~\.claude\skills, que e onde o Claude Code as encontra
#   3. cria o registro global de projetos
#   4. confere as dependencias minimas e diz o que falta
#
# Ele NAO instala dependencia. Quem instala e a fase 0 do proprio AI-SQUAD,
# explicando cada passo para quem esta usando. Aqui so verificamos.
#
# Uso:  powershell -ExecutionPolicy Bypass -File instalar.ps1
#       powershell -ExecutionPolicy Bypass -File instalar.ps1 -Destino C:\caminho
#
# -Destino existe para poder instalar numa pasta de teste sem tocar na maquina.
# Sem ele, instala no lugar de sempre. $HOME do PowerShell nao aceita ser
# redirecionado por variavel de ambiente, entao sem este parametro nao havia
# como exercitar o instalador sem efeito real.

param([string]$Destino = $HOME)

$ErrorActionPreference = "Stop"

$origem = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$casa   = Join-Path $Destino ".ai-squad"
$skills = Join-Path $Destino ".claude\skills"

Write-Host ""
Write-Host "  AI-SQUAD"
Write-Host "  Instalando a partir de: $origem"
Write-Host ""
Write-Host "  Sistema detectado: Windows"

# ---- 1. copiar o sistema ---------------------------------------------------
if (-not (Test-Path $casa)) { New-Item -ItemType Directory -Path $casa -Force | Out-Null }
foreach ($parte in @("vendor", "templates", "ferramentas")) {
    $de = Join-Path $origem $parte
    if (Test-Path $de) {
        $para = Join-Path $casa $parte
        if (Test-Path $para) { Remove-Item $para -Recurse -Force }
        Copy-Item $de $para -Recurse -Force
        Write-Host "  Copiado: $parte"
    }
}

# ---- 2. instalar as skills -------------------------------------------------
if (-not (Test-Path $skills)) { New-Item -ItemType Directory -Path $skills -Force | Out-Null }
$conta = 0
foreach ($pasta in Get-ChildItem (Join-Path $origem "skills") -Directory) {
    $destino = Join-Path $skills $pasta.Name
    if (Test-Path $destino) { Remove-Item $destino -Recurse -Force }
    Copy-Item $pasta.FullName $destino -Recurse -Force
    $conta++
}
Write-Host "  Skills instaladas: $conta em $skills"

# ---- 3. registro global de projetos ----------------------------------------
$registro = Join-Path $casa "projetos.json"
if (-not (Test-Path $registro)) {
    '{"projetos": []}' | Out-File -FilePath $registro -Encoding utf8
    Write-Host "  Registro de projetos criado."
} else {
    Write-Host "  Registro de projetos preservado."
}

# ---- 4. conferir dependencias ----------------------------------------------
Write-Host ""
Write-Host "  Dependencias minimas:"
$falta = @()
foreach ($dep in @("git", "node", "python", "claude")) {
    $cmd = Get-Command $dep -ErrorAction SilentlyContinue
    if ($cmd) {
        Write-Host ("    ok      {0}" -f $dep.PadRight(8))
    } else {
        Write-Host ("    falta   {0}" -f $dep.PadRight(8))
        $falta += $dep
    }
}

Write-Host ""
if ($falta.Count -gt 0) {
    Write-Host ("  Falta instalar: " + ($falta -join " "))
    Write-Host "  Nao precisa fazer nada agora. Abra o Claude Code e diga que quer criar"
    Write-Host "  um produto: o AI-SQUAD instala o que faltar, explicando cada passo."
    Write-Host "  (O gerenciador deste sistema e o winget.)"
} else {
    Write-Host "  Tudo pronto."
}

Write-Host ""
Write-Host "  Para começar: abra o Claude Code e diga o que você quer criar."
Write-Host ""
