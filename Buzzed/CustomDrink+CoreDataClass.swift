//
//  CustomDrink+CoreDataClass.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/16/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation
import CoreData


open class CustomDrink: NSManagedObject {
  
  func getConsumptionImageName(for imageName: String) -> (String, String) {
    switch imageName {
    case CaffeineSourceType.dripCoffee.getBlankImageName():
      return (CaffeineSourceType.dripCoffee.getAssociatedImageName(), CaffeineSourceType.dripCoffee.getLiquidWhiteName())
    case CaffeineSourceType.soda.getBlankImageName():
      return (CaffeineSourceType.soda.getAssociatedImageName(), CaffeineSourceType.soda.getLiquidWhiteName())
    case CaffeineSourceType.blackTea.getBlankImageName():
      return (CaffeineSourceType.blackTea.getAssociatedImageName(), CaffeineSourceType.blackTea.getLiquidWhiteName())
    case CaffeineSourceType.energyDrink.getBlankImageName():
      return (CaffeineSourceType.energyDrink.getAssociatedImageName(), CaffeineSourceType.energyDrink.getLiquidWhiteName())
    case CaffeineSourceType.icedTea.getBlankImageName():
      return (CaffeineSourceType.icedTea.getAssociatedImageName(), CaffeineSourceType.icedTea.getLiquidWhiteName())
    default:
      return (CaffeineSourceType.dripCoffee.getAssociatedImageName(), CaffeineSourceType.dripCoffee.getLiquidWhiteName())
    }
  }
}
