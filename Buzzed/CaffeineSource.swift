//
//  CaffeineSource.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/20/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation

class CaffeineSource {
  
  let ozToMl = 29.57
  let mlToOz = 1/29.57
  
  private var _sourceType: CaffeineSourceType
  var sourceType: CaffeineSourceType {
    return _sourceType
  }
  
  private var _volume: Double
  var volume: Double {
    return _volume
  }
  
  // eventually pull this as a default from the userSettings
  private var _baseUnit: UnitVolume = UnitVolume.fluidOunces
  var baseUnit: UnitVolume {
    return _baseUnit
  }
  
  // pull this from a local store, json file
  private var _mgCaffeinePerVolume: Double = 0 {
    didSet {
      self._totalCaffeineContent = (_mgCaffeinePerVolume * _volume).roundTo(places: 2)
    }
  }
  var mgCaffeinePerVolume: Double {
    return _mgCaffeinePerVolume
  }
  
  private var _totalCaffeineContent: Double
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
  
  init(type: CaffeineSourceType, volume: Double) {
    self._sourceType = type
    self._volume = volume
    self._sourceName = _sourceType.getName()
    self._sourceDescription = _sourceType.getDescription()
    self._mgCaffeinePerVolume = _sourceType.getMgCaffeinePer(volumeUnit: _baseUnit)
    self._totalCaffeineContent = _mgCaffeinePerVolume * _volume
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
  
}
