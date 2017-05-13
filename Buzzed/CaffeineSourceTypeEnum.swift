//
//  Enums.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/21/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation

enum CaffeineSourceType: String {
  
  case dripCoffee, espresso, soda, energyDrink, blackTea, greenTea, custom
  
  func getSize(inVolumeUnit volumeUnit: UnitVolume) -> [Double] {
    if volumeUnit == .milliliters {
      return getSizeInMilliliters()
    } else {
      return getSizeInOunces()
    }
  }
  
  fileprivate func getSizeInOunces() -> [Double] {
    switch self {
    case .dripCoffee:
      return [8, 12, 16, 20]
    case .espresso:
      return [1, 2]
    case .soda:
      return [12, 20]
    case .energyDrink:
      return [8.4, 12, 20, 24]
    case .blackTea:
      return [8, 12, 16, 20]
    case .greenTea:
      return [8, 12, 16, 20]
    case .custom:
      return [8, 12, 16, 20]
    }
  }
  
  fileprivate func getSizeInMilliliters() -> [Double] {
    switch self {
    case .dripCoffee:
      return [240, 350, 470, 590]
    case .espresso:
      return [30, 60]
    case .soda:
      return [350, 590]
    case .energyDrink:
      return [250, 350, 590, 700]
    case .blackTea:
      return [240, 350, 470, 590]
    case .greenTea:
      return [240, 350, 470, 590]
    case .custom:
      return [240, 350, 470, 590]
    }
  }
  
  func getName() -> String {
    switch self {
    case .dripCoffee:
      return "Drip Coffee"
    case .espresso:
      return "Espresso Drink"
    case.soda:
      return "Soda"
    case .energyDrink:
      return "Energy Drink"
    case .blackTea:
      return "Black Tea"
    case .greenTea:
      return "Green Tea"
    case .custom:
      return "Custom Drink"
    }
  }
  
  func getDescription() -> String {
    switch self {
    case .dripCoffee:
      return "Standard coffee from a coffee machine, coffee press, or your favorite coffee shop."
    case .espresso:
      return "Espresso, cappuchino, latte, mocha, etc."
    case.soda:
      return "Any caffeinated soft drink."
    case .energyDrink:
      return "Monster, Red Bull, you know the stuff."
    case .blackTea:
      return "Black teas have higher caffeine content than others. Early Grey, English Breakfast, Lipton, and even Chai."
    case .greenTea:
      return "Green Tea is lighter in caffeine than the standard variety of tea."
    case .custom:
      return "Source description."
    }
  }
  
  func getAssociatedImageName() -> String {
    switch self {
    case .dripCoffee:
      return "16oz Cup - Brown"
    case .espresso:
      return "Cappuchino Brown"
    case .soda:
      return "Soda Brown"
    case .energyDrink:
      return ""
    case .blackTea:
      return "12oz Mug"
    case .greenTea:
      return "12oz Mug"
    case .custom:
      return ""
    }
  }
  
  func getLiquidWhiteName() -> String {
    switch self {
    case .dripCoffee:
      return "LiquidWhite"
    case .espresso:
      return "Cappuchino Liquid White"
    case .soda:
      return "Soda Liquid White"
    case .energyDrink:
      return ""
    case .blackTea:
      return "12oz Liquid White"
    case .greenTea:
      return "12oz Liquid White"
    case .custom:
      return ""
    }
  }
  
  func getMgCaffeinePer(_ volumeUnit: UnitVolume) -> Double {
    if volumeUnit == .milliliters {
      return getMgCaffeinePerMl()
    } else {
      return getMgCaffeinePerOunce()
    }
  }
  
  fileprivate func getMgCaffeinePerOunce() -> Double {
    switch self {
    case .dripCoffee:
      return 15.0
    case .espresso:
      return 45.0
    case .soda:
      return 2.8
    case .energyDrink:
      return 9.5
    case .blackTea:
      return 6.0
    case .greenTea:
      return 3.2
    case .custom:
      return 0.0
    }
  }
  
  fileprivate func getMgCaffeinePerMl() -> Double {
    switch self {
    case .dripCoffee:
      return 0.51
    case .espresso:
      return 1.52
    case .soda:
      return 2.8
    case .energyDrink:
      return 0.09
    case .blackTea:
      return 0.20
    case .greenTea:
      return 0.11
    case .custom:
      return 0.0
    }
  }
}
