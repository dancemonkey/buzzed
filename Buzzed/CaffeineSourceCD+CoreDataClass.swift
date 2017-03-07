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
  
}
