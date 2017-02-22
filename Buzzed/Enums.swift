//
//  Enums.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/21/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation

enum CaffeineSourceType: String {
  
  // eventually add custom case to this with empty strings and values, user will have to fill it all in
  case dripCoffee, espresso, soda, energyDrink, blackTea, greenTea
  
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
    }
  }
  
  func getMgCaffeinePer(volumeUnit: UnitVolume) -> Double {
    if volumeUnit == .milliliters {
      return getMgCaffeinePerMl()
    } else {
      return getMgCaffeinePerOunce()
    }
  }
  
  private func getMgCaffeinePerOunce() -> Double {
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
    }
  }
  
  private func getMgCaffeinePerMl() -> Double {
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
    }
  }
}

enum defaultKeys: String {
  case favoriteDrinkType, favoriteDrinkVolume, favoriteDrinkName, favoriteDrinkDescription, dailyIntakeLimit, defaultUnits, mL, flOz
  
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
