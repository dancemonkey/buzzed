//
//  DrinkSelectDelegate.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/10/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation

protocol DrinkSelectDelegate { }

extension DrinkSelectDelegate where Self: CurrentDrinkVC {
  func setSelected(drink: CaffeineSource) {
    self.currentSource = drink
    self.mode = .drinking
  }
}
