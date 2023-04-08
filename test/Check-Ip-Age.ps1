$currentDate = Get-Date -Format "yyyymmdd_hhmm"

$outputFileName = "C:\Users\xanmo\Documents\conn_script_output\results_$currentDate.txt"

$headers = @{
    'x-apikey' = '2dcb229f1a42558875523b7556e7737e3937de74e2450fa3fc9d7ffb3bd4065b'
    'accept' = 'application/json'
}

    $baseUrl = "https://www.virustotal.com/api/v3/"
    $objectName = "ip_addresses/"

$ipInfo = Get-NetIPAddress | ConvertTo-Json 

$ipArr = @()

foreach ($item in $ipInfo){
    $converted = ConvertFrom-Json $item
    $convertedStr = $converted.IPv4Address | Out-String
    $ipArr = $convertedStr -split "`n"
    # Write-Output $convertedStr
    # Write-Output $converted.IPv4Address

    # Write-Output $ipArr
    # Write-Output $ipArr.Length
}
$globalIpArr = @()

foreach ($item in $ipArr){
    if(-not $item.StartsWith("192.168") -and -not $item.StartsWith("172") -and -not $item.StartsWith("127") -and -not $item.StartsWith("10.")){
        Write-Output $item
        # Write-Output $ipArr.Length
        $globalIpArr += $item
    }
}

$restArr = @()
foreach ($item in $globalIpArr){
    # Write-Output $item
    # Write-Output $item
    

    # $category = "historical_whois"
    
    $uri = $baseUrl + $objectName + $item + 'historical_whois'

    $restResponse = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers | ConvertTo-Json
    
    Write-Output $restResponse
    Write-Output $uri

    $parsedJson = ConvertFrom-Json $restResponse
    # $parsed = $parsedJson.data.attributes

    $restArr += $parsedJson.data.attributes
}
foreach ($item in $restArr){
    Write-Output $item

    # $item
   # Write-Output $item.first_seen_date

}