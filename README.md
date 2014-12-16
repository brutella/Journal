# Journal

Journal overrides Swift's `println()` method to log text to a file. No code changes required if you are using `println()` already.


# Files

- `Logger.swift` Class to log text using `log(string: String)` method
- `Println.swift` Provides a `println()` similar to `Swift.println()`


# Features

- No code changes required if you are using `println()` already
- Minimal design
- Unit tested

# Usage

```swift
import Swift
    
```

## Examples

### Not well-formed

Parsing this not well-formed HTML

    <html>
        <head></head>
        <body>
            <h1>Axt</h1>
            <p>A forgiving HTML SAX Parser for iOS<br></p>
        </body>
    </html>

will result in the following delegate calls

    parserDidStartDocument:
    parser:didStartElement:attributes: html
    parser:didStartElement:attributes: head
    parser:didEndElement: head
    parser:didStartElement:attributes: body
    parser:didStartElement:attributes: h1
    parser:foundCharacters: Axt
    parser:didEndElement: h1
    parser:didStartElement:attributes: p
    parser:foundCharacters: A forgiving HTML SAX Parser for iOS
    parser:didStartElement:attributes: br
    parser:didEndElement: br
    parser:didEndElement: p
    parser:didEndElement: body
    parser:didEndElement: html
    

### Partial HTML

The following html is not only-well formed but also misses the `html` and `body` tags.

    <h1>header
        <p>paragraph<br></p>

However the parser handles the HTML and calls the delegate methods correctly.

    parserDidStartDocument:
    parser:didStartElement:attributes: html
    parser:didStartElement:attributes: body
    parser:didStartElement:attributes: h1
    parser:foundCharacters: header
    parser:didEndElement: h1
    parser:didStartElement:attributes: p
    parser:foundCharacters: paragraph
    parser:didStartElement:attributes: br
    parser:didEndElement: br
    parser:didEndElement: p
    parser:didEndElement: body
    parser:didEndElement: html
    parserDidEndDocument:
    
## Unit Test

Run the unit test with [xctool](https://github.com/facebook/xctool)

    xctool -find-target AxtTests -sdk iphonesimulator test
    
# Contact

Matthias Hochgatterer

Github: [https://github.com/brutella/](https://github.com/brutella/)

Twitter: [https://twitter.com/brutella](https://twitter.com/brutella)


# License

Axt is available under the MIT license. See the LICENSE file for more info.

[Ono]: https://github.com/mattt/Ono