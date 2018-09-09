param(
    [Parameter(Mandatory = $true)]
    [string]
    $SPOTenatUrl
)

Connect-SPOService -Url $SPOTenatUrl

[System.Collections.ArrayList]$siteCollList=@()

function DeleteSiteCollection($siteColl) {

    Write-Host -ForegroundColor Yellow "Processing $siteColl"

    Remove-SPOSite $siteColl -Confirm
    Remove-SPODeletedSite $siteColl -Confirm
}


do {
    $siteColl = Read-Host "Enter the site collection URL to delete"
    $siteCollList.Add($siteColl)
    [ValidateSet('Y','y','N','n')]$continue=Read-Host "Do you want to delete another site collection (y/n) ?"
} while($continue -cmatch 'y')

foreach ($siteCollection in $siteCollList) {
    DeleteSiteCollection $siteCollection
}