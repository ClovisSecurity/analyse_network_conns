import requests
from endpoint_reqs import endpoint_info
import json

base_url = "https://www.virustotal.com/api/v3/"
object_name = "ip_addresses/"
ip_to_analyze = "1.1.1.1/"
relationship = "comments"

url = f"{base_url}{object_name}{ip_to_analyze}{relationship}?limit=20"

headers = {
    "accept": "application/json",
    "x-apikey": endpoint_info["api_key"]
}

response = requests.get(url, headers=headers).json()

print(json.dumps(response, indent=4))
