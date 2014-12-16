//
//  Logger.swift
//  Journal
//
//  Created by Matthias Hochgatterer on 03/12/14.
//  Copyright (c) 2014 Matthias Hochgatterer. All rights reserved.
//

import Foundation
import Swift

/// Protocol to process a string
protocol Output {
    func process(string: String)
}

/// Logs to the console using Swift.println()
struct ConsoleOutput: Output {
    private var queue: dispatch_queue_t
    
    init() {
        self.queue = dispatch_queue_create("Console output", DISPATCH_QUEUE_SERIAL)
    }
    
    func process(string: String) {
        dispatch_sync(queue) {
            Swift.println(string)
        }
    }
}

/// Logs to a file
class FileOutput: Output {
    private var filePath: String
    private var fileHandle: NSFileHandle?
    private var queue: dispatch_queue_t
    
    init(filePath: String) {
        self.filePath = filePath
        self.queue = dispatch_queue_create("File output", DISPATCH_QUEUE_SERIAL)
    }
    
    deinit {
        fileHandle?.closeFile()
    }
    
    func process(string: String) {
        dispatch_sync(queue, {
            [weak self] in
            if let file = self?.getFileHandle() {
                let printed = string + "\n"
                if let data = printed.dataUsingEncoding(NSUTF8StringEncoding) {
                    file.seekToEndOfFile()
                    file.writeData(data)
                }
            }
        })
    }
    
    /// :returns: A file handle to filePath. The file is created if it does not exist yet.
    private func getFileHandle() -> NSFileHandle? {
        if fileHandle == nil {
            let fileManager = NSFileManager.defaultManager()
            if !fileManager.fileExistsAtPath(filePath) {
                fileManager.createFileAtPath(filePath, contents: nil, attributes: nil)
            }
            
            fileHandle = NSFileHandle(forWritingAtPath: filePath)
        }
        
        return fileHandle
    }
}

// Shared logger instance
private let SharedInstance = Logger()

/// Logs text to different outputs
/// 
/// By default the logger logs text to the console
class Logger {
    class var sharedInstance: Logger {
        return SharedInstance
    }
    
    private var outputs: [Output]
    
    init() {
        outputs = [Output]()
        outputs.append(ConsoleOutput())
    }
    
    /// Adds an output to the list of outputs
    ///
    /// :param: output The output added to the list of outputs
    func addOutput(output: Output) {
        outputs.append(output)
    }
    
    /// Sends a text to the outputs
    ///
    /// :param: string Text which is sent to the outputs
    func log(string: String) {
        for out in outputs {
            out.process(string)
        }
    }
}