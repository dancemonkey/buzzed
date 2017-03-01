//
//  ViewController.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/18/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var sourceLevelDisplay: ConsumptionSetView!
  @IBOutlet weak var meter: Meter!
  @IBOutlet weak var doneBtn: UIButton!
  @IBOutlet weak var maxCaffLbl: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // testing caffeineSource
    //    let source = CaffeineSource(type: .dripCoffee, volume: 16.0)
    let dM = DataManager()
    dM.saveFavorite(drink: nil)
    if let drink = dM.getFavoriteDrink() {
      print(drink.sourceName, drink.sourceType, drink.volume)
    } else {
      print("no favorite drink")
    }
    dM.setDefaultMeasurement(unit: .fluidOunces)
    dM.setDailyIntake(limit: 250.0)
    
    maxCaffLbl.text = String(meter.maxLevel) + "mg per day max"
    
//    // testing HM permissions
//    let hm = HealthManager()
//    hm.authorizeHealthkit { (complete, error) in
//      if complete {
//        print("complete from VC")
//        hm.getHeight()
//      } else {
//        print("did not authorize healthkit")
//      }
//    }
    
  }
  
  @IBAction func donePressed(sender: UIButton) {
    meter.setLevel(to: sourceLevelDisplay.source!.totalCaffeineConsumed())
  }
  
}

