# Publicar perfil Deima120/Deima120 en GitHub
# Ejecutar en PowerShell desde esta carpeta

$gh = "${env:ProgramFiles}\GitHub CLI\gh.exe"
$repoDir = $PSScriptRoot

Set-Location $repoDir

# 1. Verificar sesión GitHub
$auth = & $gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "`nNo hay sesión en GitHub. Se abrirá el login en el navegador...`n" -ForegroundColor Yellow
    & $gh auth login --hostname github.com --git-protocol https --web
}

# 2. Crear repo y subir (si ya existe, solo hace push)
$exists = & $gh repo view Deima120/Deima120 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Creando repositorio Deima120/Deima120..." -ForegroundColor Cyan
    & $gh repo create Deima120/Deima120 --public --source . --remote origin --push --description "Perfil GitHub de Emanuel Garcia — Full Stack Developer"
} else {
    Write-Host "El repo ya existe. Subiendo cambios..." -ForegroundColor Cyan
    git push -u origin main
}

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nListo. Perfil: https://github.com/Deima120`n" -ForegroundColor Green
} else {
    Write-Host "`nAlgo falló. Revisa el mensaje de arriba.`n" -ForegroundColor Red
}
