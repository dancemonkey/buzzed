//
//  CaffeineSource.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/20/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation

enum CaffeineSourceType {
  case dripCoffee, espresso, soda, energyDrink, blackTea, greenTea
  // subclass each different type 
  // so they can each have different pre-built sizes, mgCaffPerUnit, names, etc.
}

class CaffeineSource {
  
  var sourceType: CaffeineSourceType
  var size: Double
  var baseUnit: UnitVolume!
  var mgCaffeinePerUnit: Double!
  var sourceName: String!
  var sourceDescription: String!
  
  init(type: CaffeineSourceType, size: Double) {
    self.sourceType = type
    self.size = size
  }
  
}
