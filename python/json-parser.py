# Prsing and processing JSON
import json
import urllib.request

# Using free data feed from the USGS, all earthquakes for the last day larger than Mag 2.5
jsonUrl = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson"

# Open the URL and read the data
response = urllib.request.urlopen(jsonUrl)
statusCode = response.getcode()
if statusCode != 200:
    print("[Error]: cannot retrive results, Status:", str(statusCode))
    exit(1)

# Use the json module to load the string data into a dictionary
jsonData = json.loads(response.read())

# Access the contents of the JSON object
if "title" in jsonData["metadata"]:
    print("______________________________________________")
    print(jsonData["metadata"]["title"])
    print("----------------------------------------------")

# Output the number of events, magnitude, and event name
print(str(jsonData["metadata"]["count"]), "events recorded")

# Print the place of every events
for feature in jsonData["features"]:
    print(feature["properties"]["place"])

print("-------------------------------------\n")

# Print events having magnitude >=4
for feature in jsonData["features"]:
    if feature["properties"]["mag"] >= 4.0:
        print("%2.1f" % feature["properties"]["mag"], feature["properties"]["place"])

print("-------------------------------------\n")

# Print events where at least 1 person reported feeling something
print("\nEvents that were felt:")
for feature in jsonData["features"]:
    feltReports = feature["properties"]["felt"]
    if feltReports != None:
        if feltReports > 0:
            print("%2.1f" % feature["properties"]["mag"], feature["properties"]["place"], "reported", str(feltReports), "times")
