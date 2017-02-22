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
    print("volume \(source.volume)")
    print("mg caff per vol \(source.mgCaffeinePerVolume)")
    print("total caff \(source.totalCaffeineContent)")
    
    source.toggleMetricOrCustomary()
    print("volume \(source.volume)")
    print("mg caff per vol \(source.mgCaffeinePerVolume)")
    print("total caff \(source.totalCaffeineContent)")
    
    // testing HM permissions
    let hm = HealthManager()
    hm.authorizeHealthkit { (complete, error) in
      if complete {
        print("Authorized")
      } else {
        print(error)
      }
    }
    // Do any additional setup after loading the view, typically from a nib.
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
