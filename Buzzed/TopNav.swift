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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  func configure(title: String) {
    let data = DataManager()
    
    self.title.text = title
    
    if let caffLbl = maxCaff {
      caffLbl.text = String(data.getDailyIntake()) + "mg max"
    }
    
    if meter != nil {
      setMeter()
    }
    // totalCaff.text from Core Data (total intake for current day)
  }
  
  func setMeter() {
//    set meter level to intake from current day
  }
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
}
