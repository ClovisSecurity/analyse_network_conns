$currentDate = Get-Date -Format "yyyymmdd_hhmm"

$outputFileName = "C:\Users\xanmo\Documents\conn_script_output\results_$currentDate.txt"

$headers = @{
    'x-apikey' = '2dcb229f1a42558875523b7556e7737e3937de74e2450fa3fc9d7ffb3bd4065b'
    'accept' = 'application/json'
}

$baseUrl = "https://www.virustotal.com/api/v3/"
$objectName = "ip_addresses/"


$uri = $baseUrl + $objectName + $item + "/historical_whois"


$ipInfo = Get-NetIPAddress | ConvertTo-Json 

$ipArr = @()

foreach ($item in $ipInfo){
    $converted = ConvertedFrom-Json $item
    $ipArr += $converted.IPv4Address
}
restArr = @()
foreach ($item in $ipArr){
    # Write-Output $item

    $restResponse = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers | ConvertTo-Json
    $parsedJson = $restResponse | ConvertFrom-Json -AsHashtable
    # $parsed = $parsedJson.data.attributes

    $restArr += $parsedJson.data.attributes
}
foreach ($item in $restArr){
    Write-Output $item

    # $item
   # Write-Output $item.first_seen_date

}
