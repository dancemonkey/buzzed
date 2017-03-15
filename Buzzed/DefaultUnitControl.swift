//
//  DefaultUnitControl.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/15/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class DefaultUnitControl: UISegmentedControl {

  func getDefaultUnit() -> UnitVolume {
    switch self.selectedSegmentIndex {
    case 0:
      return .fluidOunces
    case 1:
      return .milliliters
    default:
      return .fluidOunces
    }
  }

}
