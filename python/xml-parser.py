# Parsing and processing XML
import xml.dom.minidom as dom

ROOT = "person"
TAG_FNAME = "firstname"
TAG_LNAME = "lastname"
TAG_HOME = "home"
TAG_SKILL = "skill"
ATTR_NAME = "name"

# Load and parse an XML file
doc = dom.parse("sample.xml")

# Print out the document node and the name of the first child tag
print("Node:", doc.nodeName, "First child:", doc.firstChild.tagName)

# Get a list of XML tags from the document and print
skills = doc.getElementsByTagName(TAG_SKILL)
print("Found:", skills.length, "skills")
for item in skills:
    print(item.getAttribute(ATTR_NAME))

# Create a new XML tag and add it into the document
item = doc.createElement(TAG_SKILL)
item.setAttribute(ATTR_NAME, "jQuery")
doc.firstChild.appendChild(item)

"""
<?xml version="1.0" encoding="UTF-8" ?>
<person>
  <firstname>Joe</firstname>
  <lastname>Marini</lastname>
  <home>Seattle</home>
  <skill name="JavaScript"/>
  <skill name="Python"/>
  <skill name="C#"/>
  <skill name="HTML"/>
</person>
"""
