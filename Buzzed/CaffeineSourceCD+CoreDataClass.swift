//
//  CaffeineSourceCD+CoreDataClass.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/7/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation
import CoreData


open class CaffeineSourceCD: NSManagedObject {
  
  func getBaseClass(withImage image: String?) -> CaffeineSource {
    
    let type = CaffeineSourceType(rawValue: self.sourceType!)
    let volume: Double = self.volume
    let source = CaffeineSource(type: type!, volume: volume)
    
    return source.initSource(fromEntity: self)
  }
  
  var sectionNameFromDate: String {
    get {
      let formatter = DateFormatter()
      formatter.dateFormat = "MM-dd-yyyy"
      return formatter.string(from: self.creation!)
    }
  }
  
  func setUUID(to uuid: String) {
    self.hkUUID = uuid
  }
  
  func setValues(fromBase base: CaffeineSource) {
    self.creation = base.creation as Date?
    self.sourceType = base.sourceType.rawValue
    print(self.sourceType)
    self.sourceName = base.sourceName
    self.sourceDescription = base.sourceDescription
    self.mgCaffeinePerVolume = base.mgCaffeinePerVolume
    self.volume = base.volume
//    if self.sourceType == "custom" {
//      self.imageName = base.selectedCustomIcon
//    } else {
      self.imageName = base.associatedImageName
//    }
    self.percentageConsumed = base.percentageConsumed
    self.hkUUID = base.hkUUID
    print("entity uuid set as \(String(describing: self.hkUUID))")
  }
  
  func totalMgConsumed() -> Double {
    return ((mgCaffeinePerVolume * volume) * percentageConsumed).roundTo(2)
  }
  
}
