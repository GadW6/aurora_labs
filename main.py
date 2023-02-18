import json
import urllib2

# Define the URL to request
url = 'http://bapi:5000'

# Create a request object
request = urllib2.Request(url)

# Make the request and get the response
response = urllib2.urlopen(request)

# Read the response content
content = response.read()

# Json parsing the response
obj_content = json.loads(content)

# Print the output of the curl command
print(obj_content['response'])