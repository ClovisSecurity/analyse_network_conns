import requests
from endpoint_reqs import endpoint_info

base_url = "https://www.virustotal.com/api/v3/"
object_name = "domains/"
domain_to_analyze = "www.victimsofcrime.org"

url = f"{base_url}{object_name}{domain_to_analyze}"

payload={}
headers = {
  'x-apikey': endpoint_info["api_key"],
  'accept': 'application/json'
}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)
