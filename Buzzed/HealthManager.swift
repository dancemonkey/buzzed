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
      
      // request permission to read and write data, if not already granted
    }
  }
  
  func authorizeHealthkit(completion: ((_ success: Bool, _ error: Error) -> Void)!) {
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
    
    healthStore?.requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead, completion: { (success: Bool, error: Error?) in
      if success {
        print("success")
      } else {
        print(error!)
      }
    })
  }
  
  func storeSample() {
    
  }
  
}