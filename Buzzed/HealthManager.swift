//
//  HealthManager.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/20/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation
import HealthKit

class HealthManager {
  
  var healthStore: HKHealthStore?
  
  init() {
    if HKHealthStore.isHealthDataAvailable() {
      healthStore = HKHealthStore()
    } else {
      healthStore = nil
    }
  }
  
  func authorizeHealthkit(completion: ((_ success: Bool, _ error: Error?) -> Void)!) {
    let healthKitTypesToRead: Set<HKObjectType> = [
      HKSampleType.quantityType(forIdentifier: .bodyMass)!,
      HKSampleType.quantityType(forIdentifier: .height)!,
      HKSampleType.quantityType(forIdentifier: .dietaryCaffeine)!,
      HKSampleType.characteristicType(forIdentifier: .dateOfBirth)!,
      HKSampleType.characteristicType(forIdentifier: .biologicalSex)!
    ]
    let healthKitTypesToWrite: Set<HKSampleType> = [
      HKObjectType.quantityType(forIdentifier: .dietaryCaffeine)!
    ]
    if !HKHealthStore.isHealthDataAvailable() {
      let error = NSError(domain: "com.drewlanning.Buzzed", code: 2, userInfo: [NSLocalizedDescriptionKey: "HealthKit is not available on this device."])
      if completion != nil {
        completion(false, error)
      }
      return
    }
    
    healthStore?.requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead, completion: completion)
    
  }
  
  func storeSample() {
    // TODO: throw errors
    guard let hs = healthStore else {
      // TODO: some more meaningful error throw or something here
      print("you have no HK on this device")
      return
    }
    
    if hs.authorizationStatus(for: HKSampleType.quantityType(forIdentifier: .dietaryCaffeine)!) == .sharingAuthorized {
      let sampleType = HKSampleType.quantityType(forIdentifier: .dietaryCaffeine)
      let sampleQuantity = HKQuantity(unit: HKUnit.gramUnit(with: .milli), doubleValue: 25.0)
      let sample = HKQuantitySample(type: sampleType!, quantity: sampleQuantity, start: Date(), end: Date())
      hs.save(sample, withCompletion: { (success, error) in
        if error != nil {
          print("Error saving sample")
        } else {
          print("Caffeine sample saved")
        }
      })
    } else {
      // TODO: here we trip a flag?
      // that tells the calling view to load some notification that you don't have authorization?
      print("you can't store caffeine intake sample")
    }
  }
  
  func getHeight() {
    // TODO: parameter for what units you want the height in (feet/meters), then switch returned result
    // TODO: handle return of empty array (lack of permission to read or no data)
    guard let hs = healthStore else {
      // TODO: some more meaningful error throw or something here
      print("you have no HK on this device")
      return
    }
    
    if hs.authorizationStatus(for: HKSampleType.quantityType(forIdentifier: .height)!) == .sharingDenied {
      // TODO: throw error so calling view can popup or show a banner
      print("not authorized for height")
    }
    
    let height = HKQuantityType.quantityType(forIdentifier: .height)!
    let heightQuery = HKSampleQuery(sampleType: height, predicate: nil, limit: 1, sortDescriptors: nil, resultsHandler: { (query, results, error) in
      if let results = results as? [HKQuantitySample] {
        let customaryUnits = HKUnit(from: LengthFormatter.Unit.inch)
        let queryResults = results.first!.quantity.doubleValue(for: customaryUnits)
        let heightInFeet =  (queryResults / 12).rounded(FloatingPointRoundingRule.down)
        let heightInInches = queryResults.truncatingRemainder(dividingBy: 12).roundTo(places: 0)
        print("height = \(heightInFeet) ft., \(heightInInches) in.")
      }
    })
    hs.execute(heightQuery)
  }
  
  func getTodaysCaffeineIntake() -> Double {
    return 126.0
  }
  
}
