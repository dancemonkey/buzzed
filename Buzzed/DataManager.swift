//
//  DataManager.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/22/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation

class DataManager {
  
  // read userDefaults for settings like measurement units, max caffeine target/day, favorite drink
  // if nothing in userSettings, offer up defaults
  
  static let instance = DataManager()
  
//  var favoriteDrink: CaffeineSource?
//  var favoriteDrinkVolume: Double!
//  var dailyIntakeLimit: Double!
//  var defaultUnits: UnitVolume!

  
//  func writeAllUserDefaults() {
//    let defaults = UserDefaults.standard
//    defaults.set(favoriteDrink?.sourceType.rawValue, forKey: defaultKeys.favoriteDrinkType.rawValue)
//    defaults.set(favoriteDrink?.sourceName, forKey: defaultKeys.favoriteDrinkName.rawValue)
//    defaults.set(favoriteDrink?.sourceDescription, forKey: defaultKeys.favoriteDrinkDescription.rawValue)
//    defaults.set(favoriteDrinkVolume, forKey: defaultKeys.favoriteDrinkVolume.rawValue)
//    defaults.set(dailyIntakeLimit, forKey: defaultKeys.dailyIntakeLimit.rawValue)
//    defaults.set(defaultUnits.description, forKey: defaultKeys.defaultUnits.rawValue)
//  }
  
  func saveFavorite(drink: CaffeineSource?) {
    let defaults = UserDefaults.standard
    guard let source = drink else {
      defaults.removeObject(forKey: defaultKeys.favoriteDrinkType.rawValue)
      defaults.removeObject(forKey: defaultKeys.favoriteDrinkName.rawValue)
      defaults.removeObject(forKey: defaultKeys.favoriteDrinkDescription.rawValue)
      defaults.removeObject(forKey: defaultKeys.favoriteDrinkVolume.rawValue)
      return
    }
    defaults.set(source.sourceType.rawValue, forKey: defaultKeys.favoriteDrinkType.rawValue)
    defaults.set(source.sourceName, forKey: defaultKeys.favoriteDrinkName.rawValue)
    defaults.set(source.sourceDescription, forKey: defaultKeys.favoriteDrinkDescription.rawValue)
    defaults.set(source.volume, forKey: defaultKeys.favoriteDrinkVolume.rawValue)
  }
  
  func saveDailyIntake(limit: Double) {
    let defaults = UserDefaults.standard
    defaults.set(limit, forKey: defaultKeys.dailyIntakeLimit.rawValue)
  }
  
  func saveDefaultMeasurement(unit: UnitVolume) {
    let defaults = UserDefaults.standard
    defaults.set(unit.symbol, forKey: defaultKeys.defaultUnits.rawValue)
  }
  
  func getFavoriteDrink() -> CaffeineSource? {
    let defaults = UserDefaults.standard
    var drink: CaffeineSource?
    
    if let drinkValue = defaults.object(forKey: defaultKeys.favoriteDrinkType.rawValue) as? String, let drinkVolume = defaults.object(forKey: defaultKeys.favoriteDrinkVolume.rawValue) as? Double {
      let favoriteDrinkType = CaffeineSourceType(rawValue: drinkValue)!
      drink = CaffeineSource(type: favoriteDrinkType, volume: drinkVolume)
      if let name = defaults.object(forKey: defaultKeys.favoriteDrinkName.rawValue) as? String {
        drink?.changeName(to: name)
      }
    } else {
      drink = nil
    }
    return drink
  }
  
  func getDailyIntake() -> Double {
    let defaults = UserDefaults.standard
    if let intake = defaults.object(forKey: defaultKeys.dailyIntakeLimit.rawValue) as? Double {
      return intake
    } else {
      return 300.0
    }
  }
  
  func getDefaultUnits() -> UnitVolume {
    let defaults = UserDefaults.standard
    if let units = defaults.object(forKey: defaultKeys.defaultUnits.rawValue) as? String {
      switch units {
      case defaultKeys.mL.getUnits():
        return .milliliters
      case defaultKeys.flOz.getUnits():
        return .fluidOunces
      default:
        return .fluidOunces
      }
    } else {
      return .fluidOunces
    }
  }
  
}
