# AzureStaticWebApp

```powershell
Usage:

New-AzSubscriptionDeployment -Verbose -name "staticwebapp" -Location "westeurope" -TemplateFile .\main.bicep -resourceLocation "westeurope" -resourceGroupName "staticwebapp" -webAppName "staticwebapp" -customDomainName "staticwebapp.nl" -dnsResourceGroup "dns"

```