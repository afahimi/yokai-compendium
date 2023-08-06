import requests
import json

response = requests.get("https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0")

# convert response to json
data = response.json()
# print(data.get("results"))

names = list(map(lambda x : x.get("name"), data.get("results")))

json_string = json.dumps(names)

with open("./pokemon.json", "w") as f:
    f.write(json_string)

print(names)

# print(names)