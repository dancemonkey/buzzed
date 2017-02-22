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
  
  var favoriteDrink: CaffeineSource?
  var favoriteDrinkVolume: Double!
  var dailyIntakeLimit: Double!
  var defaultUnits: UnitVolume!
  
  init() {
    readUserDefaults()
  }
  
  func readUserDefaults() {
    let defaults = UserDefaults.standard
    
    if let drinkValue = defaults.object(forKey: defaultKeys.favoriteDrinkType.rawValue) as? String, let drinkVolume = defaults.object(forKey: defaultKeys.favoriteDrinkVolume.rawValue) as? Double {
      let favoriteDrinkType = CaffeineSourceType(rawValue: drinkValue)!
      favoriteDrink = CaffeineSource(type: favoriteDrinkType, volume: drinkVolume)
      if let name = defaults.object(forKey: defaultKeys.favoriteDrinkName.rawValue) as? String {
        favoriteDrink?.changeName(to: name)
      }
    } else {
      favoriteDrink = nil
    }
    
    if let intake = defaults.object(forKey: defaultKeys.dailyIntakeLimit.rawValue) as? Double {
      dailyIntakeLimit = intake
    } else {
      dailyIntakeLimit = 300.0
    }
    
    if let units = defaults.object(forKey: defaultKeys.defaultUnits.rawValue) as? String {
      switch units {
      case defaultKeys.milliliters.rawValue:
        defaultUnits = .milliliters
      case defaultKeys.fluidOunces.rawValue:
        defaultUnits = .fluidOunces
      default:
        defaultUnits = .fluidOunces
      }
    } else {
      defaultUnits = .fluidOunces
    }
  }
  
  func writeAllUserDefaults() {
    let defaults = UserDefaults.standard
    defaults.set(favoriteDrink?.sourceType.rawValue, forKey: defaultKeys.favoriteDrinkType.rawValue)
    defaults.set(favoriteDrink?.sourceName, forKey: defaultKeys.favoriteDrinkName.rawValue)
    defaults.set(favoriteDrink?.sourceDescription, forKey: defaultKeys.favoriteDrinkDescription.rawValue)
    defaults.set(favoriteDrinkVolume, forKey: defaultKeys.favoriteDrinkVolume.rawValue)
    defaults.set(dailyIntakeLimit, forKey: defaultKeys.dailyIntakeLimit.rawValue)
    defaults.set(defaultUnits.description, forKey: defaultKeys.defaultUnits.rawValue)
  }
  
  func saveFavorite(drink: CaffeineSource) {
    let defaults = UserDefaults.standard
    defaults.set(drink.sourceType.rawValue, forKey: defaultKeys.favoriteDrinkType.rawValue)
    defaults.set(drink.sourceName, forKey: defaultKeys.favoriteDrinkName.rawValue)
    defaults.set(drink.sourceDescription, forKey: defaultKeys.favoriteDrinkDescription.rawValue)
    defaults.set(drink.volume, forKey: defaultKeys.favoriteDrinkVolume.rawValue)
  }
  
  func saveDailyIntake(limit: Double) {
    let defaults = UserDefaults.standard
    defaults.set(limit, forKey: defaultKeys.dailyIntakeLimit.rawValue)
  }
  
  func saveDefaultMeasurement(unit: UnitVolume) {
    let defaults = UserDefaults.standard
    defaults.set(unit.description, forKey: defaultKeys.defaultUnits.rawValue)
  }
  
}
