# Retrieving data from the internet
import urllib.request

# Open connection
response = urllib.request.urlopen("https://api.github.com")

# Print status code and data
print("Status code:", str(response.getcode()))
print(response.read())
