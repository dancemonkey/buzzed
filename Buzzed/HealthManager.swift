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
//    let healthKitTypesToRead: Set<HKObjectType> = [
//      HKSampleType.quantityType(forIdentifier: .bodyMass)!,
//      HKSampleType.quantityType(forIdentifier: .height)!,
//      HKSampleType.quantityType(forIdentifier: .dietaryCaffeine)!,
//      HKSampleType.characteristicType(forIdentifier: .dateOfBirth)!,
//      HKSampleType.characteristicType(forIdentifier: .biologicalSex)!
//    ]
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
    
    healthStore?.requestAuthorization(toShare: healthKitTypesToWrite, read: nil, completion: completion)
  }
  
  func deleteSample(withUUID uuidToFind: String?) {
    guard let hs = healthStore else {
      print("no healthkit on this device son")
      return
    }
    
    guard uuidToFind != nil else {
      print("did not pass a valid uuid to healthStore")
      return
    }
    
    if hs.authorizationStatus(for: HKSampleType.quantityType(forIdentifier: .dietaryCaffeine)!) == .sharingAuthorized {
      let sampleType = HKSampleType.quantityType(forIdentifier: .dietaryCaffeine)
      let uuid = UUID(uuidString: uuidToFind!)
      let predicate = HKQuery.predicateForObject(with: uuid!)
      let query = HKSampleQuery(sampleType: sampleType!, predicate: predicate, limit: 1, sortDescriptors: nil, resultsHandler: { (query, samples, error) in
        if let samples = samples {
          for sample in samples {
            hs.delete(sample, withCompletion: { (success, error) in
              
            })
          }
        }
      })
      hs.execute(query)
    }
  }
  
  func storeSample(fromDrink drink: CaffeineSourceCD) {
    // TODO: throw errors
    guard let hs = healthStore else {
      // TODO: some more meaningful error throw or something here
      print("you have no HK on this device")
      return
    }
    
    if hs.authorizationStatus(for: HKSampleType.quantityType(forIdentifier: .dietaryCaffeine)!) == .sharingAuthorized {
      let totalCaff = (drink.volume * drink.mgCaffeinePerVolume) * drink.percentageConsumed
      let sampleType = HKSampleType.quantityType(forIdentifier: .dietaryCaffeine)
      let sampleQuantity = HKQuantity(unit: HKUnit.gramUnit(with: .milli), doubleValue: totalCaff)
      let sample = HKQuantitySample(type: sampleType!, quantity: sampleQuantity, start: Date(), end: Date())
      hs.save(sample, withCompletion: { (success, error) in
        if error != nil {
          print("Error saving sample")
        } else {
          drink.setUUID(to: sample.uuid.uuidString)
          print("Caffeine sample saved with uuid \(drink.hkUUID)")
        }
      })
    } else {
      // TODO: here we trip a flag?
      // that tells the calling view to load some notification that you don't have authorization?
      print("you can't store caffeine intake sample")
    }
  }
  
}
