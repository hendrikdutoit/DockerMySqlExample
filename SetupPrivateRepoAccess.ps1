# SetupPrivateRepoAccess.ps1
Write-Host ''

function Remove-RepositoryConfiguration {
    param (
        [Object]$RepoDetails
    )
    Write-Host "Remove configuration" -ForegroundColor Magenta
    poetry source remove $RepoDetails.name
    poetry remove $RepoDetails.name
}

function Publish-RepositoryConfiguration {
    param (
        [Object]$RepoDetails
    )
    Write-Host "Add configuration" -ForegroundColor Magenta
    poetry source add --priority=explicit $RepoDetails.name ("https://github.com/" + $RepoDetails.org + "/" + $RepoDetails.name + ".git")
    poetry add --source $RepoDetails.name ("git+https://github.com/" + $RepoDetails.org + "/" + $RepoDetails.name + ".git" + $RepoDetails.version_branch)
}

Write-Host ''
$dateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "=[ START $dateTime ]===================[ SetupPrivateRepoAccess.ps1 ]=" -ForegroundColor Blue
Write-Host "Executing $PSCommandPath..." -ForegroundColor Yellow

# List of keys to configure in Poetry
poetry config "http-basic.BEE" "__token__" $env:GH_REPO_ACCESS_BEE_LOCAL_USER
poetry config "http-basic.RTE" "__token__" $env:GH_REPO_ACCESS_RTE_LOCAL_USER

$RepoDetails = [PSCustomObject]@{
    name = "PoetryPrivate"
    org = "BrightEdgeeServices"
    version_branch = "#master"
}
Remove-RepositoryConfiguration -RepoDetails $RepoDetails
#Publish-RepositoryConfiguration -RepoDetails $RepoDetails

Write-Host '-[ END SetupPrivateRepoAccess.ps1 ]---------------------------------------------' -ForegroundColor Cyan
Write-Host ''
