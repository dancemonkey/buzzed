//
//  TopNav.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/2/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class TopNav: UIView {
  
  @IBOutlet weak var title: UILabel?
  @IBOutlet weak var meterCaffLbl: UILabel?
  @IBOutlet weak var totalCaff: UILabel!
  @IBOutlet weak var meter: Meter?
  
  var data: DataManager!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    data = DataManager()
    NotificationCenter.default.addObserver(self, selector: #selector(self.setMeter), name: NSNotification.Name(rawValue: Constants.notificationKeys.decay.rawValue), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.setLabel), name: NSNotification.Name(rawValue: Constants.notificationKeys.dailyIntake.rawValue), object: nil)
  }
  
  func configure(title: String) {
    
    if let currentTitle = self.title {
      currentTitle.text = title
    }
    
    setLabel()
    
    if meter != nil {
      setMeter()
    }
  }
  
  func setLabel() {
    if let totalLbl = totalCaff {
      totalLbl.text = "\(data.getTotalCaff())/\(data.getDailyIntake())mg"
    }
  }
  
  func setMeter() {
    if meter != nil {
      meter?.setLevel(to: data.getCurrentCaff())
      if let caffLbl = meterCaffLbl {
        caffLbl.text = String(describing: data.getCurrentCaff().roundTo(0)) + "mg currently"
      }
      setLabel()
    }
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
}
