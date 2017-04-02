//
//  SimpleLogger.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/27/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation

class SimpleLogger {
  
  init() {
    
  }
  
  func log(data: String) {
    print(data)
    let fileName = "decayLog.txt"
    if let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last {
      let fileURL = dir.appendingPathComponent(fileName)
      let data = data.data(using: String.Encoding.utf8, allowLossyConversion: false)!
      if FileManager.default.fileExists(atPath: fileURL.path) {
        do {
          let fileHandle = try FileHandle(forWritingTo: fileURL)
          fileHandle.seekToEndOfFile()
          fileHandle.write(data)
          fileHandle.closeFile()
        } catch {
          print("can't open fileHandle \(error)")
        }
      } else {
        do {
          try data.write(to: fileURL, options: .atomic)
        } catch {
          print("can't write \(error)")
        }
      }
    }
  }
  
  func readLog() -> String? {
    let fileName = "decayLog.txt"
    if let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last {
      let path = dir.appendingPathComponent(fileName)
      do {
        let textRead = try String(contentsOf: path, encoding: String.Encoding.utf8)
        return textRead
      } catch {
        print("couldn't read the log file")
        return nil
      }
    } else {
      return nil
    }
  }
  
  func clearLog() {
    let fileName = "decayLog.txt"
    if let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last {
      let path = dir.appendingPathComponent(fileName)
      do {
        try "".write(to: path, atomically: false, encoding: String.Encoding.utf8)
      } catch {
        print("couldn't find the file")
      }
    }
  }
  
}
