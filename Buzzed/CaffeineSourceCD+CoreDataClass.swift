//
//  CaffeineSourceCD+CoreDataClass.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/7/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation
import CoreData


public class CaffeineSourceCD: NSManagedObject {
  
  func getBaseClass() -> CaffeineSource {
    
    let type = CaffeineSourceType(rawValue: self.sourceType!)
    let volume: Double = self.volume
    let source = CaffeineSource(type: type!, volume: volume)
    
    return source.initSource(fromEntity: self)
  }
  
  func setValues(fromBase base: CaffeineSource) {
    self.creation = base.creation as NSDate?
    self.sourceType = base.sourceType.rawValue
    self.sourceName = base.sourceName
    self.sourceDescription = base.sourceDescription
    self.mgCaffeinePerVolume = base.mgCaffeinePerVolume
    self.volume = base.volume
    self.imageName = base.associatedImageName
    self.percentageConsumed = base.percentageConsumed
  }
  
}
