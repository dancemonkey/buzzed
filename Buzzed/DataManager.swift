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
  
  //  static let instance = DataManager()
  
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
  
  func getLastOpen() -> Date {
    let defaults = UserDefaults.standard
    if let lastOpen = defaults.object(forKey: defaultKeys.lastOpen.rawValue) {
      let formatter = DateFormatter()
      formatter.dateFormat = Constants.Globals.dateFormat.value()
      return formatter.date(from: lastOpen as! String)!
    }
    
    return Date()
  }
  
  func setLastOpen() {
    let defaults = UserDefaults.standard
    let formatter = DateFormatter()
    formatter.dateFormat = Constants.Globals.dateFormat.value()
    defaults.set(formatter.string(from: Date()), forKey: defaultKeys.lastOpen.rawValue)
  }
  
  func setDailyIntake(limit: Double) {
    let defaults = UserDefaults.standard
    defaults.set(limit, forKey: defaultKeys.dailyIntakeLimit.rawValue)
  }
  
  func setDefaultMeasurement(unit: UnitVolume) {
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
      return intake.roundTo(places: 0)
    } else {
      return 400
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
  
  func clearUserDefaults() {
    let defaults = UserDefaults.standard
    defaults.removeObject(forKey: defaultKeys.favoriteDrinkType.rawValue)
    defaults.removeObject(forKey: defaultKeys.favoriteDrinkName.rawValue)
    defaults.removeObject(forKey: defaultKeys.favoriteDrinkDescription.rawValue)
    defaults.removeObject(forKey: defaultKeys.favoriteDrinkVolume.rawValue)
    defaults.removeObject(forKey: defaultKeys.defaultUnits.rawValue)
    defaults.removeObject(forKey: defaultKeys.dailyIntakeLimit.rawValue)
    defaults.removeObject(forKey: defaultKeys.lastOpen.rawValue)
  }
  
}
