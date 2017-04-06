//
//  DataManager.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/22/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit
import CoreData

class DataManager {
  
  lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  var currentCaff: Double {
    return getCurrentCaff()
  }
  
  var dailyIntake: Double {
    return getDailyIntake()
  }
  
  func save() {
    do {
      try context.save()
    } catch {
      print("error saving to core data")
    }
  }
  
  func fetchLastDrink() -> CaffeineSource? {
    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.caffeineSourceEntity.name())
    let sorter = NSSortDescriptor(key: "creation", ascending: false)
    fetch.sortDescriptors = [sorter]
    fetch.fetchLimit = 1
    do {
      let results = try context.fetch(fetch)
      if results.count > 0 {
        for drink in results {
          return (drink as? CaffeineSourceCD)?.getBaseClass()
        }
      }
    } catch {
      print("error fetching")
    }
    return nil
  }
  
  func fetchAllDrinks() -> [CaffeineSource]? {
    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.caffeineSourceEntity.name())
    do {
      let results = try context.fetch(fetch)
      var drinksToReturn = [CaffeineSource]()
      for result in results {
        drinksToReturn.append((result as! CaffeineSourceCD).getBaseClass())
      }
      return drinksToReturn
    } catch {
      print("error fetching all drinks")
      return nil
    }
  }
  
  func fetchDrinkTypes() -> [CaffeineSourceType] {
    return [.dripCoffee, .espresso, .soda, .energyDrink, .blackTea, .greenTea]
  }
  
  func clearAllHistory() -> Bool {
    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.caffeineSourceEntity.name())
    let request = NSBatchDeleteRequest(fetchRequest: fetch)
    do {
      try context.execute(request)
      save()
      return true
    } catch {
      print("error deleting everything")
      return false
    }
  }
  
  func saveCustom(_ drink: CaffeineSource) {
    let entity = NSEntityDescription.insertNewObject(forEntityName: Constants.Entity.customDrinkEntity.name(), into: self.context) as! CustomDrink
    entity.sourceName = drink.sourceName
    entity.sourceDescription = drink.sourceDescription
    entity.imageName = CaffeineSourceType.custom.getAssociatedImageName()
    entity.mgCaffeinePerVolume = drink.mgCaffeinePerVolume
    entity.volume = drink.volume
    entity.creation = Date()// as NSDate?
    self.save()
  }
  
  func saveFavorite(_ drink: CaffeineSource?) {
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
  
  fileprivate func getLastDecay() -> Date? {
    let defaults = UserDefaults.standard
    if let lastOpen = defaults.object(forKey: defaultKeys.lastOpen.rawValue) {
      let formatter = DateFormatter()
      formatter.dateFormat = Constants.Globals.dateFormat.value()
      return formatter.date(from: lastOpen as! String)!
    }
    return nil
  }
  
  fileprivate func setLastDecay() {
    let defaults = UserDefaults.standard
    let formatter = DateFormatter()
    formatter.dateFormat = Constants.Globals.dateFormat.value()
    defaults.set(formatter.string(from: Date()), forKey: defaultKeys.lastOpen.rawValue)
  }
  
  func reduceCaffeineBy(caffReduction: Double) {
    let current = getCurrentCaff()
    let reduced = current - caffReduction
    let final = reduced > 0 ? reduced : 0
    setCurrentCaff(to: final)
  }
  
  func setDailyIntake(_ limit: Double) {
    let defaults = UserDefaults.standard
    defaults.set(limit, forKey: defaultKeys.dailyIntakeLimit.rawValue)
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.notificationKeys.dailyIntake.rawValue), object: self.dailyIntake)
  }
  
  func setDefaultMeasurement(_ unit: UnitVolume) {
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
      return intake.roundTo(0)
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
  
  func setCurrentCaff(to level: Double) {
    
    if getCurrentCaff() <= 0 {
      UserDefaults.standard.removeObject(forKey: defaultKeys.lastOpen.rawValue)
    }
    
    let defaults = UserDefaults.standard
    defaults.set(level, forKey: defaultKeys.currentCaffLevel.rawValue)
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.notificationKeys.decay.rawValue), object: self.currentCaff)
  }
  
  func getCurrentCaff() -> Double {
    let defaults = UserDefaults.standard
    if let currentCaff = defaults.object(forKey: defaultKeys.currentCaffLevel.rawValue) as? Double {
      return currentCaff
    }
    return 0
  }
  
  func getTotalCaff() -> Double {
    let cal = Calendar(identifier: .gregorian)
    let drinks = fetchAllDrinks()?.filter({ (drink) -> Bool in
      let drinkDate = cal.date(bySetting: .hour, value: 0, of: drink.creation)
      return drinkDate == cal.date(bySetting: .hour, value: 0, of: Date())
    })
    return drinks?.reduce(0, { (results, drink) -> Double in
      return (results + drink.totalCaffeineConsumed()).roundTo(0)
    }) ?? 0
  }
  
  func decay() {
    
    guard getCurrentCaff() > 0 else {
      return
    }
    
    let decayPerMin: Double = (getCurrentCaff() * 0.10) / 60
    if getLastDecay() == nil {
      setLastDecay()
    }
    let minutesToLastDecay = minutesBetween(earlierDate: getLastDecay()!, andLaterDate: Date())
    
    let sl = SimpleLogger()
    sl.log(data: "\(Date()) - starting caff @: \(getCurrentCaff())\n")
    sl.log(data: "minutesToLastDecay: \(minutesToLastDecay)\n")
    sl.log(data: "decayPerMin: \(decayPerMin)\n")
    
    if minutesToLastDecay > 15 {
      let totalDecay = Double(minutesToLastDecay) * decayPerMin
//      totalDecay >= getCurrentCaff() ? setCurrentCaff(to: 0.0) : setCurrentCaff(to: getCurrentCaff() - totalDecay)
      if totalDecay >= getCurrentCaff() {
        setCurrentCaff(to: 0.0)
        UserDefaults.standard.removeObject(forKey: defaultKeys.lastOpen.rawValue)
        sl.clearLog()
      } else {
        setCurrentCaff(to: getCurrentCaff() - totalDecay)
        setLastDecay()
      }
      
      sl.log(data: "totalDecay: \(Double(minutesToLastDecay) * decayPerMin)\n")
      sl.log(data: "ending caff: \(getCurrentCaff())\n\n\n")
    }
    
  }
  
  private func minutesBetween(earlierDate earlier: Date, andLaterDate later: Date) -> Int {
    let currentCalendar = Calendar.current
    guard let start = currentCalendar.ordinality(of: .minute, in: .era, for: earlier) else { return 0 }
    guard let end = currentCalendar.ordinality(of: .minute, in: .era, for: later) else { return 0 }
    return end - start
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
    defaults.removeObject(forKey: defaultKeys.currentCaffLevel.rawValue)
  }
  
}
