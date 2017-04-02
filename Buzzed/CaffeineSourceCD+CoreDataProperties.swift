//
//  CaffeineSourceCD+CoreDataProperties.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/25/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation
import CoreData


extension CaffeineSourceCD {

    @nonobjc open override class func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<CaffeineSourceCD>(entityName: "CaffeineSourceCD") as! NSFetchRequest<NSFetchRequestResult>;
    }

    @NSManaged public var creation: Date?
    @NSManaged public var imageName: String?
    @NSManaged public var mgCaffeinePerVolume: Double
    @NSManaged public var percentageConsumed: Double
    @NSManaged public var sourceDescription: String?
    @NSManaged public var sourceName: String?
    @NSManaged public var sourceType: String?
    @NSManaged public var volume: Double
    @NSManaged public var hkUUID: String?

}
