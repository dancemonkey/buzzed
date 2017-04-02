//
//  DrinkSelectDelegate.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/10/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import Foundation

protocol DrinkSelectDelegate: class { }

extension DrinkSelectDelegate where Self: CurrentDrinkVC {
  func setSelected(_ drink: CaffeineSource) {
    self.currentSource = drink
    self.mode = .drinking
    self.consumptionControls.setSource(to: drink)
    topNav.configure(title: "\(drink.sourceName)")
  }
}

extension DrinkSelectDelegate where Self: SettingsTableVC {
  func setFavorite(_ drink: CaffeineSource) {
    let dm = DataManager()
    dm.saveFavorite(drink)
    self.setupViews()
  }
}
