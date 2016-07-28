//
//  QLSLogger.swift
//  QLSLogger
//
//  Created by Pavlo Cretsu on 5/5/16.
//  Copyright © 2016 MT. All rights reserved.
//

import Foundation
import CocoaLumberjack
import SwiftHEXColors


public enum LogModule: Int, CustomStringConvertible {
    case Http
    case CoreData
    case JSON
    case UI
    case None
    
    public var description: String {
        switch self {
        case .Http:
            return "HTTP     "
        case .CoreData:
            return "CORE-DATA"
        case .JSON:
            return "JSON     "
        case .UI:
            return "UI       "
        case .None:
            return "None     "
        }
    }
}




/**
 * QLSLogger is designet for displaying logs with different levels,
 * modules, colors and system information such as thread type, file, method
 * and line number information.
 */
public class QLSLogger {
    
    public static let log = QLSLogger()
    
    /**
     Console text colors for all log levels. For defining colors was used extension of UIColor: init?(hexString: String)
     */
    private struct ConsoleColor {
        let verbose  =  UIColor(hexString: "#a9a9a9")
        let debug    =  UIColor(hexString: "#808283")
        let info     =  UIColor(hexString: "#0c35d3")
        let warning  =  UIColor(hexString: "#e38b38")
        let error    =  UIColor(hexString: "#d83534")
    }
    
    
    /**
     Default initialiser for logger.
     
     @see: https://github.com/CocoaLumberjack/CocoaLumberjack
     */
    public func setupSharedLogInstance() {
        
        DDLog.addLogger(DDTTYLogger.sharedInstance()) // TTY = Xcode console
        DDLog.addLogger(DDASLLogger.sharedInstance()) // ASL = Apple System Logs
        
        self.setUpConsoleColors()
    }
    
    
    /**
     Console color works based on XcodeColors.
     
     - @see: https://github.com/robbiehanson/XcodeColors
     */
    private func setUpConsoleColors () {
        
        DDTTYLogger.sharedInstance().colorsEnabled = true
        
        //Check if XcodeColors target environment variable is defined
        let xcode_colors = getenv("XcodeColors")
        
        //Check if XcodeColors plugin is activated
        if (xcode_colors != nil && strcmp(xcode_colors, "YES") == 0) {
            DDTTYLogger.sharedInstance().setForegroundColor(ConsoleColor().verbose, backgroundColor: UIColor.whiteColor(), forFlag: .Verbose)
            DDTTYLogger.sharedInstance().setForegroundColor(ConsoleColor().debug,   backgroundColor: UIColor.whiteColor(), forFlag: .Debug)
            DDTTYLogger.sharedInstance().setForegroundColor(ConsoleColor().info,    backgroundColor: UIColor.whiteColor(), forFlag: .Info)
            DDTTYLogger.sharedInstance().setForegroundColor(ConsoleColor().warning, backgroundColor: UIColor.whiteColor(), forFlag: .Warning)
            DDTTYLogger.sharedInstance().setForegroundColor(ConsoleColor().error,   backgroundColor: UIColor.whiteColor(), forFlag: .Error)
        }
    }
    
    
    /**
     Log content representation. Logger representation works only with String and NSError types
     
     - parameter logObject: Object for representation
     - returns: String representation of sended sended params
     */
    private func generateLogRepresentation(logObject: Any) -> String {
        
        let stringRepresentation: String
        
        if let stringObject = logObject as? String {
            stringRepresentation = "String: \(stringObject)"
        } else if let errorObject = logObject as? NSError {
            stringRepresentation = "Error: \(errorObject.code). \(errorObject.localizedDescription)"
        } else {
            fatalError("QLSLogger only works for values that conform to String or NSError")
        }
        
        return stringRepresentation
    }
    
    
    /**
     Generate final log representation
     
     - parameter logObject:    Input log data parameter. QLSLogger works only with String and NSError types
     - parameter levelLabel:   Level description. Preferable uppercase string with 5 characters
     - parameter module:       Representation module is enum item from LogModule. Describe logistics for displayed log
     - parameter fileName:     File name, where log method was called from
     - parameter lineNumber:   Line number, where log method was called from
     - parameter functionName: Function name, where log method was called from
     
     - returns: Final log representation string
     */
    private func generateLogDescription(logObject: Any, levelLabel: String, module: LogModule, fileName: String, lineNumber: Int, functionName: String) -> String? {
        
        let stringRepresentation: String = self.generateLogRepresentation(logObject)
        
        let fileURL = NSURL(fileURLWithPath: fileName).URLByStandardizingPath?.lastPathComponent ?? "Unknown file"
        
        let threadLevel = NSThread.isMainThread() ? "UI" : "BG"
        
        return "\(levelLabel) | \(threadLevel) | \(module.description) | \(fileURL):\(lineNumber) [\(functionName)] \(stringRepresentation)"
    }
    
    
    /**
     Display String object in console log with VERBOSE log-level. This level is displayed in DEBUG mode only
     
     - parameter object:       Input string parameter. QLSLogger().verbose display only String log data
     - parameter module:       Representation module is enum item from LogModule. Describe logistics for displayed log
     - parameter fileName:     File name, where log method was called from
     - parameter lineNumber:   Line number, where log method was called from
     - parameter functionName: Function name, where log method was called from
     */
    public func verbose(object: String, LogModule module: LogModule = .None, fileName: String = #file, lineNumber: Int = #line, functionName: String = #function) {
        #if DEBUG
            if let verboseLogStack = self.generateLogDescription(object, levelLabel: "VERBOSE", module: module, fileName: fileName, lineNumber: lineNumber, functionName: functionName) {
                
                DDLogError(verboseLogStack)
                
            }
        #endif
    }
    
    
    /**
     Display String object in console log with DEBUG log-level. This level is displayed in DEBUG mode only
     
     - parameter object:       Input string parameter. QLSLogger().debug display only String log data
     - parameter module:       Representation module is enum item from LogModule. Describe logistics for displayed log
     - parameter fileName:     File name, where log method was called from
     - parameter lineNumber:   Line number, where log method was called from
     - parameter functionName: Function name, where log method was called from
     */
    public func debug(object: String, LogModule module: LogModule = .None, fileName: String = #file, lineNumber: Int = #line, functionName: String = #function) {
        #if DEBUG
            if let debugLogStack = self.generateLogDescription(object, levelLabel: "DEBUG", module: module, fileName: fileName, lineNumber: lineNumber, functionName: functionName) {
                
                DDLogDebug(debugLogStack)
                
            }
        #endif
    }
    
    
    /**
     Display String object in console log with INFO log-level. This level is displayed in DEBUG mode only
     
     - parameter object:       Input string parameter. QLSLogger().info display only String log data
     - parameter module:       Representation module is enum item from LogModule. Describe logistics for displayed log
     - parameter fileName:     File name, where log method was called from
     - parameter lineNumber:   Line number, where log method was called from
     - parameter functionName: Function name, where log method was called from
     */
    public func info(object: String, LogModule module: LogModule = .None, fileName: String = #file, lineNumber: Int = #line, functionName: String = #function) {
        #if DEBUG
            if let infoLogStack = self.generateLogDescription(object, levelLabel: "INFO ", module: module, fileName: fileName, lineNumber: lineNumber, functionName: functionName) {
                
                DDLogInfo(infoLogStack)
                
            }
        #endif
    }
    
    
    /**
     Display String object in console log with ERROR log-level.
     
     - parameter object:       Input error data. QLSLogger().error display String or NSError objects as well
     - parameter module:       Representation module is enum item from LogModule. Describe logistics for displayed log
     - parameter fileName:     File name, where log method was called from
     - parameter lineNumber:   Line number, where log method was called from
     - parameter functionName: Function name, where log method was called from
     */
    public func error(object: Any, LogModule module: LogModule = .None, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        if let errorLogStack = self.generateLogDescription(object, levelLabel: "ERROR", module: module, fileName: fileName, lineNumber: lineNumber, functionName: functionName) {
            
            DDLogError(errorLogStack)
            
        }
    }
    
    
    /**
     Display String object in console log with WARNING log-level. This level is displayed in DEBUG mode only
     
     - parameter object:       Input string parameter. QLSLogger().warning display only String log data
     - parameter module:       Representation module is enum item from LogModule. Describe logistics for displayed log
     - parameter fileName:     File name, where log method was called from
     - parameter lineNumber:   Line number, where log method was called from
     - parameter functionName: Function name, where log method was called from
     */
    public func warning(object: String, LogModule module: LogModule = .None, fileName: String = #file, lineNumber: Int = #line, functionName: String = #function) {
        #if DEBUG
            if let warningLogStack = self.generateLogDescription(object, levelLabel: "WARNING", module: module, fileName: fileName, lineNumber: lineNumber, functionName: functionName) {
                
                DDLogWarn(warningLogStack)
                
            }
        #endif
    }
    
}


