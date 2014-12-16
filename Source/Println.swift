//
//  Println.swift
//  Journal
//
//  Created by Matthias Hochgatterer on 03/12/14.
//  Copyright (c) 2014 Matthias Hochgatterer. All rights reserved.
//

import Foundation

/// Send all messages to the shared logger instance.
/// The prefix is the current timestamp.
func println(string: String) {
    Logger.sharedInstance.log(prefix() + ": " + string)
}

// MARK: -

var DateFormatter: NSDateFormatter?
func dateFormatter() -> NSDateFormatter {
    if DateFormatter == nil {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS Z"
        DateFormatter = dateFormatter
    }
    return DateFormatter!
}

func prefix() -> String {
    return dateFormatter().stringFromDate(NSDate())
}