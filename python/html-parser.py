# Parsing and procesing HTML
from html.parser import HTMLParser

metacount = 0

# Extend HTMLParser class and override handler methods
class MyHTMLParser(HTMLParser):
    # Function to handle an opening tag in the doc
    # This will be called when the closing ">" of the tag is reached
    def handle_starttag(self, tag, attrs):
        global metacount
        if tag == "meta":
            metacount += 1

        print("Encountered a start tag:", tag)

        # Returns a tuple indication line and a character
        pos = self.getpos()
        print("\tAt line:", pos[0], "position:", pos[1])

        if attrs.__len__() > 0:
            print("\tAttributes:")
            for attr in attrs:
                print("\t\t", attr[0], "=", attr[1])

    # Function to handle the ending tag
    def handle_endtag(self, tag):
        print("Encountered end tag:", tag)
        pos = self.getpos()
        print("\tAt line:", pos[0], "position: ", pos[1])

    # Function to handle the processing of HTML comments
    def handle_comment(self, data):
        print("Encounterd comment:", data)
        pos = self.getpos()
        print("\tAt line:", pos[0], "position:", pos[1])


# Instantiate the parser and feed it some HTML
parser = MyHTMLParser()

# Open and read sample HTML file
with file1 = open("sample.html"):
    if file1.mode == "r":
        # Read entire file
        parser.feed(file1.read())

print("Found:", metacount, "meta tags.")


"""
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width; initial-scale=1.0" />
  <meta name="description" content="This is a sample HTML file" />
  <meta name="author" content="Administrator" />
  <!-- favicon.ico & apple-touch-icon.png -->
  <link rel="shortcut icon" href="/favicon.ico" />
  <link rel="apple-touch-icon" href="/apple-touch-icon.png" />
  <title>Sample HTML Document</title>
</head>

<body>
  <main>
    <article>
      <section>
        <header>
          <h1>HTML Sample File</h1>
        </header>
        <nav>
          <p><a href="#">Home</a></p>
          <p><a href="contact.html">Contact</a></p>
        </nav>
      </section>
    </article>
    <footer>
      <p>&copy; Copyright by Administrator</p>
    </footer>
  </main>
</body>

</html>
"""
