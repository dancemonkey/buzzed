//
//  DefaultValueEnums.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/1/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

enum defaultKeys: String {
  case favoriteDrinkType, favoriteDrinkVolume, favoriteDrinkName, favoriteDrinkDescription, dailyIntakeLimit, defaultUnits, mL, flOz, lastOpen
  
  func getUnits() -> String {
    switch self {
    case .mL:
      return rawValue
    case .flOz:
      return "fl oz"
    default:
      return "oops"
    }
  }
}

enum LargeDrink {
  enum Shadow {
    case color, radius, offset, opacity
    func value() -> Any {
      switch(self) {
      case .color:
        return UIColor.black.cgColor
      case .radius:
        return CGFloat(4.0)
      case .offset:
        return CGSize(width: 0, height: 4.0)
      case .opacity:
        return Float(1.0)
      }

    }
  }
}

enum Button {
  enum Shadow {
    case color, radius, offset, opacity
    func value() -> Any {
      switch(self) {
      case .color:
        return UIColor.black.cgColor
      case .radius:
        return CGFloat(2.0)
      case .offset:
        return CGSize(width: 0, height: 2.0)
      case .opacity:
        return Float(1.0)
      }
    }
  }
}
