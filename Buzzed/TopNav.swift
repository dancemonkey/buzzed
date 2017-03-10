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
  
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var maxCaff: UILabel?
  @IBOutlet weak var totalCaff: UILabel!
  @IBOutlet weak var meter: Meter?
  
  var data: DataManager!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    data = DataManager()
  }
  
  func configure(title: String) {
    self.title.text = title
    
    if let caffLbl = maxCaff {
      caffLbl.text = String(describing: data.getDailyIntake()) + "mg max"
    }
    if let totalLbl = totalCaff {
      totalLbl.text = "\(data.getCurrentCaff()) mg"
    }
    
    if meter != nil {
      setMeter()
    }
  }
  
  func setMeter() {
    meter?.setLevel(to: data.getCurrentCaff())
  }
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
}
