import requests
from endpoint_reqs import endpoint_info
import json

base_url = "https://www.virustotal.com/api/v3/"
object_name = "ip_addresses/"
domain_to_analyze = "104.244.42.198"

url = f"{base_url}{object_name}{domain_to_analyze}"

headers = {
    "accept": "application/json",
    "x-apikey": endpoint_info["api_key"]
}

response = requests.get(url, headers=headers).json()

print(json.dumps(response, indent=4))
