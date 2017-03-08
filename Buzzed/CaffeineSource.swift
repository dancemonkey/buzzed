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
  
  private var _creation: Date
  var creation: Date {
    return _creation
  }
  
  private var _sourceType: CaffeineSourceType
  var sourceType: CaffeineSourceType {
    return _sourceType
  }
  
  private var _volume: Double
  var volume: Double {
    return _volume
  }
  
  private var _baseUnit: UnitVolume = UnitVolume.fluidOunces
  var baseUnit: UnitVolume {
    return _baseUnit
  }
  
  private var _mgCaffeinePerVolume: Double = 0.0
  var mgCaffeinePerVolume: Double {
    return _mgCaffeinePerVolume
  }
  
  private var _totalCaffeineContent: Double {
    return (_mgCaffeinePerVolume * _volume).roundTo(places: 2)
  }
  var totalCaffeineContent: Double {
    return _totalCaffeineContent
  }
  
  private var _sourceName: String
  var sourceName: String {
    return _sourceName
  }
  
  private var _sourceDescription: String
  var sourceDescription: String {
    return _sourceDescription
  }
  
  private var _percentageConsumed: Double = 0.0
  var percentageConsumed: Double {
    return _percentageConsumed
  }
  
  private var _associatedImageName: String?
  var associatedImageName: String? {
    return _associatedImageName
  }
  
  init(type: CaffeineSourceType, volume: Double) {
    let dm = DataManager()
    _baseUnit = dm.getDefaultUnits()
    self._sourceType = type
    self._volume = volume
    self._sourceName = _sourceType.getName()
    self._sourceDescription = _sourceType.getDescription()
    self._mgCaffeinePerVolume = _sourceType.getMgCaffeinePer(volumeUnit: _baseUnit)
    self._associatedImageName = _sourceType.getAssociatedImageName()
    self._creation = Date()
    consume(percentage: _percentageConsumed)
  }
  
  func initSource(fromEntity entity: CaffeineSourceCD) -> CaffeineSource {
    
    self._sourceName = entity.sourceName!
    self._sourceDescription = entity.sourceDescription!
    self._mgCaffeinePerVolume = entity.mgCaffeinePerVolume
    self._creation = entity.creation! as Date
    
    return self
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
  
  private func convertVolume(to unit: UnitVolume) {
    let measurement = Measurement(value: _volume, unit: _baseUnit)
    if unit == .milliliters {
      _volume = measurement.converted(to: .milliliters).value.roundTo(places: 2)
    } else {
      _volume = measurement.converted(to: .fluidOunces).value.roundTo(places: 2)
    }
    setCaffeinePerVolume(inMg: _sourceType.getMgCaffeinePer(volumeUnit: unit))
  }
  
  func consume(percentage: Double) {
    _percentageConsumed = percentage / 100
  }
  
  func totalCaffeineConsumed() -> Double {
    return (totalCaffeineContent * percentageConsumed).roundTo(places: 2)
  }

}
