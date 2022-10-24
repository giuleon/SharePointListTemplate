#https://learn.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online
#Install-Module -Name Microsoft.Online.SharePoint.PowerShell
$tenant1 = ""
$tenant2 = ""
Connect-SPOService -Url https://$tenant1-admin.sharepoint.com

#Training Sessions
$extractedTS = Get-SPOSiteScriptFromList -ListUrl "https://$tenant1.sharepoint.com/Lists/Training%20Sessions"
$extractedPT = Get-SPOSiteScriptFromList -ListUrl "https://$tenant1.sharepoint.com/Lists/Projects%20Tracker"
$extractedWS = Get-SPOSiteScriptFromList -ListUrl "https://$tenant1.sharepoint.com/Lists/Workshop%20Scheduler"
$extractModernView = Get-SPOSiteScriptFromList -ListUrl "https://$tenant1.sharepoint.com/Lists/Modern%20View%20Components"

Disconnect-SPOService

Connect-SPOService -Url https://$tenant2-admin.sharepoint.com

#Creating a new microsoft lists template
Add-SPOSiteScript -Title "Training Sessions" -Description "Schedule all your training session" -Content $extractedTS
Add-SPOListDesign -Title "Training Sessions" -Description "Schedule all your training session" -SiteScripts "<- Add the site script Id from the previous command ->" -ListColor Orange -ListIcon Insights -Thumbnail "https://www.vevox.com/getmedia/a46979ef-7ae7-431f-b37d-ab4caf32a42e/Artboard-1-copy-3.png"

#Creating a new microsoft lists template
Add-SPOSiteScript -Title "Project Tracker" -Description "Keep track of all your projects" -Content $extractedPT
Add-SPOListDesign -Title "Project Tracker" -Description "Keep track of all your projects" -SiteScripts "<- Add the site script Id from the previous command ->" -ListColor Blue -ListIcon ClipboardList -Thumbnail "https://cdn.hubblecontent.osi.office.net/m365content/publish/24c89a19-30f0-4550-ad15-04f6d4a7dd67/thumbnails/large.jpg"

#Creating a new microsoft lists template
Add-SPOSiteScript -Title "Workshop Scheduler" -Description "Plan easily future workshops" -Content $extractedWS
Add-SPOListDesign -Title "Workshop Scheduler" -Description "Plan easily future workshops" -SiteScripts "<- Add the site script Id from the previous command ->" -ListColor Red -ListIcon Calendar -Thumbnail "https://cdn.hubblecontent.osi.office.net/m365content/publish/a948d414-9dec-416b-b586-f92b5317a01d/thumbnails/large.jpg"

#Creating a new modern microsoft lists template
$siteScriptId = Add-SPOSiteScript -Title "Modern View" -Description "List with modern components" -Content $extractModernView
Add-SPOListDesign -Title "Modern View" -Description "List with modern components" -SiteScripts $siteScriptId.Id -ListColor Red -ListIcon Calendar -Thumbnail "https://giulianodemo.sharepoint.com/SiteAssets/ModernListPreview.png"

#Limit access
Grant-SPOSiteDesignRights 
  -Identity $siteScriptId.Id 
  -Principals "nestorw@contoso.onmicrosoft.com" 
  -Rights View

#Remove an existing list design
Remove-SPOListDesign $siteScriptId.Id

#Remove an existing site script
Remove-SPOSiteScript $siteScriptId.Id
