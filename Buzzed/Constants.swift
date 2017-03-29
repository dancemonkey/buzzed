//
//  Constants.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/2/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

enum Constants {
  
  enum notificationKeys: String {
    case decay
  }
  
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
  
  enum Entity: String {
    case caffeineSourceEntity, customDrinkEntity
    
    func name() -> String {
      switch self {
      case .caffeineSourceEntity:
        return "CaffeineSourceCD"
      case .customDrinkEntity:
        return "CustomDrink"
      }
    }
  }
  
  enum Color {
    case doneBtn, cancelBtn, infoBtn
    
    func bground() -> UIColor {
      switch self {
      case .doneBtn:
        return UIColor.init(red: 139, green: 87, blue: 42)
      case .cancelBtn:
        return UIColor.init(red: 215, green: 146, blue: 87)
      case .infoBtn:
        return UIColor.init(red: 42, green: 122, blue: 139)
      }
    }
  }
  
}
