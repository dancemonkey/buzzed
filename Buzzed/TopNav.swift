//
//  TopNav.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/2/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class TopNav: UIView {
  
  // methods for configuring self with title, meter data (if present), etc.
  // needs to know:
  // - TITLE: current state of screen (pick a drink or working on current drink)
  // - MAX Caff: max caffeine goal from defaults
  // - CURRENT Caff: total current caff from CD
  // - METER: total current caff from CD
  
  @IBOutlet weak var title: UILabel?
  @IBOutlet weak var meterCaffLbl: UILabel?
  @IBOutlet weak var totalCaff: UILabel!
  @IBOutlet weak var meter: Meter?
  
  var data: DataManager!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    data = DataManager()
    NotificationCenter.default.addObserver(self, selector: #selector(self.setMeter), name: NSNotification.Name(rawValue: Constants.notificationKeys.decay.rawValue), object: nil)
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "data.currentCaff" {
      setMeter()
    }
  }
  
  func configure(title: String) {
    
    if let currentTitle = self.title {
      currentTitle.text = title
    }
    
    if let caffLbl = meterCaffLbl {
      caffLbl.text = String(describing: data.getCurrentCaff().roundTo(places: 0)) + "mg currently"
    }
    if let totalLbl = totalCaff {
      totalLbl.text = "\(data.getTotalCaff())/\(data.getDailyIntake())mg"
    }
    
    if meter != nil {
      setMeter()
    }
  }
  
  func setMeter() {
    meter?.setLevel(to: data.getCurrentCaff())
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
}
