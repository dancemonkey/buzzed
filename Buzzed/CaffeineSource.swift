//
//  CaffeineSource.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/23/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation
import CoreData

class CaffeineSource {
  let ozToMl = 29.57
  let mlToOz = 1/29.57
  
  fileprivate var _creation: Date
  var creation: Date {
    return _creation
  }
  
  fileprivate var _hkUUID: String?
  var hkUUID: String? {
    return _hkUUID
  }
  
  fileprivate var _sourceType: CaffeineSourceType
  var sourceType: CaffeineSourceType {
    return _sourceType
  }
  
  fileprivate var _volume: Double
  var volume: Double {
    return _volume
  }
  
  fileprivate var _baseUnit: UnitVolume = UnitVolume.fluidOunces
  var baseUnit: UnitVolume {
    return _baseUnit
  }
  
  fileprivate var _mgCaffeinePerVolume: Double = 0.0
  var mgCaffeinePerVolume: Double {
    return _mgCaffeinePerVolume
  }
  
  fileprivate var _totalCaffeineContent: Double {
    return (_mgCaffeinePerVolume * _volume).roundTo(2)
  }
  var totalCaffeineContent: Double {
    return _totalCaffeineContent
  }
  
  fileprivate var _sourceName: String
  var sourceName: String {
    return _sourceName
  }
  
  fileprivate var _sourceDescription: String
  var sourceDescription: String {
    return _sourceDescription
  }
  
  fileprivate var _percentageConsumed: Double = 0.0
  var percentageConsumed: Double {
    return _percentageConsumed
  }
  
  fileprivate var _associatedImageName: String?
  var associatedImageName: String? {
    return _associatedImageName
  }
  
  fileprivate var _selectedCustomIcon: String?
  var selectedCustomIcon: String? {
    return _selectedCustomIcon
  }
  
  init(type: CaffeineSourceType, volume: Double) {
    let dm = DataManager()
    _baseUnit = dm.getDefaultUnits()
    self._sourceType = type
    self._volume = volume
    self._sourceName = _sourceType.getName()
    self._sourceDescription = _sourceType.getDescription()
    self._mgCaffeinePerVolume = _sourceType.getMgCaffeinePer(_baseUnit)
    self._associatedImageName = _sourceType.getAssociatedImageName()
    self._creation = Date()
    consume(_percentageConsumed)
  }
  
  func initSource(fromEntity entity: CaffeineSourceCD) -> CaffeineSource {
    let dm = DataManager()
    self._sourceName = entity.sourceName!
    self._sourceDescription = entity.sourceDescription!
    self._mgCaffeinePerVolume = entity.mgCaffeinePerVolume
    self._creation = entity.creation! as Date
    self._percentageConsumed = entity.percentageConsumed
    self._associatedImageName = entity.imageName
    self._baseUnit = dm.getDefaultUnits()
    self._sourceType = CaffeineSourceType(rawValue: entity.sourceType!)!
    self._hkUUID = entity.hkUUID
    return self 
  }
  
  func initFromCustom(_ drink: CustomDrink) {
    self._mgCaffeinePerVolume = drink.mgCaffeinePerVolume
    self._sourceName = drink.sourceName!
    self._sourceDescription = drink.sourceDescription!
    self._creation = Date()
    self.setCustomIcon(name: drink.imageName!)
  }
  
  func createEntity(fromSource source: CaffeineSource) -> CaffeineSourceCD {
    let dm = DataManager()
    let entity = NSEntityDescription.insertNewObject(forEntityName: Constants.Entity.caffeineSourceEntity.name(), into: dm.context)
    (entity as! CaffeineSourceCD).setValues(fromBase: source)
    return entity as! CaffeineSourceCD
  }
  
  func toggleMetricOrCustomary() {
    if _baseUnit == .fluidOunces {
      convertVolume(to: .milliliters)
      _baseUnit = .milliliters
    } else {
      convertVolume(to: .fluidOunces)
      _baseUnit = .fluidOunces
    }
  }
  
  func setCaffeinePerVolume(inMg caffeine: Double) {
    _mgCaffeinePerVolume = caffeine
  }
  
  func changeName(to name: String) {
    self._sourceName = name
  }
  
  func changeDescription(to description: String) {
    self._sourceDescription = description
  }
  
  fileprivate func convertVolume(to unit: UnitVolume) {
    let measurement = Measurement(value: _volume, unit: _baseUnit)
    if unit == .milliliters {
      _volume = measurement.converted(to: .milliliters).value.roundTo(2)
    } else {
      _volume = measurement.converted(to: .fluidOunces).value.roundTo(2)
    }
    setCaffeinePerVolume(inMg: _sourceType.getMgCaffeinePer(unit))
  }
  
  func consume(_ percentage: Double) {
    _percentageConsumed = percentage / 100
  }
  
  func totalCaffeineConsumed() -> Double {
    return (totalCaffeineContent * percentageConsumed).roundTo(2)
  }
  
  func setUUID(to uuid: String) {
    self._hkUUID = uuid
  }
  
  func setCustomIcon(name: String) {
    self._selectedCustomIcon = name
  }

}
