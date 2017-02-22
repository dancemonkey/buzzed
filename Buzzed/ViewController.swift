//
//  ViewController.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/18/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var meter: Meter!
  @IBOutlet weak var angleField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // testing caffeineSource
    let source = CaffeineSource(type: .dripCoffee, volume: 16.0)
    let dM = DataManager()
    dM.saveFavorite(drink: nil)
    if let drink = dM.getFavoriteDrink() {
      print(drink.sourceName, drink.sourceType, drink.volume)
    } else {
      print("no favorite drink")
    }
    dM.saveDefaultMeasurement(unit: .milliliters)
    dM.saveDailyIntake(limit: 250.0)
    print(dM.getDefaultUnits().description)
    print(dM.getDailyIntake())
    
    // testing HM permissions
//    let hm = HealthManager()
//    hm.authorizeHealthkit { (complete, error) in
//      if complete {
//        print("Authorized")
//      } else {
//        print(error)
//      }
//    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func setMeterLevel() {
    if let text = angleField.text, let number = NumberFormatter().number(from: text) {
      meter.setLevel(to: CGFloat(number))
    }
  }

}

