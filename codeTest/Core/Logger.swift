//
//  Logger.swift
//  codeTest
//
//  Created by Rex Du on 30/9/2024.
//

import Foundation
import OSLog

extension Logger {
    
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Logs related to the networking.
    static let networking = Logger(subsystem: subsystem, category: "networking")
    
    static let debug = Logger(subsystem: subsystem, category: "debug")
}
