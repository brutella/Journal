# Journal

Journal "overrides" Swift's `println()` method to log text to a file.

No code changes in your project are needed if you are using `println()` already.

# How does it work?
Calling `println()` normally resolves to `Swift.println()` because the method in only defined in the Swift framework.

But because namespacing is implicit in Swift ([Source](https://twitter.com/clattner_llvm/status/474730716941385729)) the file *Println.swift* "overrides" the method with a custom implementation using a shared `Logger` instance.

# Features

- No code changes required if you are using `println()` already
- Logging to a file
- Extensible
- Unit tested

# Installation

- Include *Logger.swift* and *Println.swift* into your project


# Usage

    // Logs to the console similar to Swift.println()
    println("Using Journal")

## File Output

    let filePath = ...
    let fileOutput = FileOutput(filePath: filePath)
    Logger.sharedInstance.addOutput(fileLogger)
    
    // Logs to the console AND to the file
    println("Using Journal to log to a file")
    
# Contact

Matthias Hochgatterer

Github: [https://github.com/brutella/](https://github.com/brutella/)

Twitter: [https://twitter.com/brutella](https://twitter.com/brutella)


# License

Journal is available under the MIT license. See the LICENSE file for more info.