# punkmzn/20260311 저장소로 푸시 스크립트
# Git 설치 후: 이 파일 우클릭 -> "PowerShell에서 실행"
# UTF-8 인코딩
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

$ErrorActionPreference = "Stop"
$repoPath = "c:\Users\SD2-14\Desktop\20260311"

Set-Location $repoPath

# Git 미설치 확인
try {
    git --version | Out-Null
} catch {
    Write-Host "Git이 설치되어 있지 않습니다. https://git-scm.com/download/win 에서 설치해주세요." -ForegroundColor Red
    exit 1
}

# 저장소 초기화 (최초 1회)
if (-not (Test-Path ".git")) {
    git init
    git remote add origin https://github.com/punkmzn/test.git
    Write-Host "저장소 초기화 완료" -ForegroundColor Green
}

# 원격 설정 (없으면 추가, 있으면 test 저장소로 업데이트)
$targetUrl = "https://github.com/punkmzn/20260311.git"
$remote = git remote get-url origin 2>$null
if (-not $remote) {
    git remote add origin $targetUrl
} elseif ($remote -ne $targetUrl) {
    git remote set-url origin $targetUrl
}

# 추가 및 커밋
git add .
$status = git status --porcelain
if ($status) {
    git commit -m "Update: 로또 추첨기 프로젝트 업데이트"
    git branch -M main 2>$null
    git push -u origin main
    Write-Host "`nGitHub 업데이트 완료: https://github.com/punkmzn/20260311" -ForegroundColor Green
} else {
    Write-Host "변경사항이 없습니다." -ForegroundColor Yellow
    git push 2>$null
}
