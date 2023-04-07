# This program almost works. 
# I feel like I spent too much time on it 

# $currentDate = Get-Date -Format "yyyymmdd_hhmm"

# $outputFileName = "C:\Users\xanmo\Documents\conn_script_output\results_$currentDate.txt"

$headers = @{
    'x-apikey' = '2dcb229f1a42558875523b7556e7737e3937de74e2450fa3fc9d7ffb3bd4065b'
    'accept' = 'application/json'
}

$baseUrl = "https://www.virustotal.com/api/v3/"
$objectName = "ip_addresses/"


$uri = "{base_url}{object_name}"


$ipInfo = Get-NetIPAddress | ConvertTo-Json 

$ipArr = @()

foreach ($item in $ipInfo){
    $converted = ConvertedFrom-Json $item
    $ipArr += $converted.IPv4Address
    foreach ($innerItem in $item){
        # Write-Output $innerItem
        # $converted = ConvertFrom-Json $item
        # $ipArr += $converted.IPv4Address
    }
}
restArr = @()
foreach ($item in $ipArr){
    # Write-Output $item
    $uri = $baseUrl + $objectName + $item + "/historical_whois"
    $restResponse = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers | ConvertTo-Json
    $parsedJson = $restResponse | ConvertFrom-Json -AsHashtable
    # $parsed = $parsedJson.data.attributes

    $restArr = $parsedJson.data.attributes.first_seen_date

    $test = $restArr | ConvertFrom-Json -AsHashtable

    #  $restResponse.GetType()

    # Write-Output $restResponse
    Write-Output $test
}

foreach ($item in $restArr){
    $item.first_seen_date
   # Write-Output $item.first_seen_date

}
