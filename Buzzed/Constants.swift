//
//  Constants.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/2/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation

enum Constants {
  
  enum StoryBoardID: String {
    case drinkSelect, sizeSelect, history, settings, customDrink, main
  }
  
  enum Globals: String {
    case dateFormat
    
    func value() -> String {
      switch self {
      case .dateFormat:
        return "yyyy-MM-dd HH:mm:ss"
      }
    }
  }
  
}
