//
//  CustomDrink+CoreDataProperties.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/16/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation
import CoreData


extension CustomDrink {

    @nonobjc open override class func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<CustomDrink>(entityName: "CustomDrink") as! NSFetchRequest<NSFetchRequestResult>;
    }

    @NSManaged public var imageName: String?
    @NSManaged public var mgCaffeinePerVolume: Double
    @NSManaged public var sourceDescription: String?
    @NSManaged public var sourceName: String?
    @NSManaged public var creation: Date?
    @NSManaged public var volume: Double

}
