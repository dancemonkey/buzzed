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

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomDrink> {
        return NSFetchRequest<CustomDrink>(entityName: "CustomDrink");
    }

    @NSManaged public var imageName: String?
    @NSManaged public var mgCaffeinePerVolume: Double
    @NSManaged public var sourceDescription: String?
    @NSManaged public var sourceName: String?
    @NSManaged public var creation: NSDate?
    @NSManaged public var volume: Double

}
