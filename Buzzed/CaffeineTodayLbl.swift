//
//  CaffeineTodayLbl.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/1/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class CaffeineTodayLbl: UILabel {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  func setCaffeineInput(to level: Double) {
    self.text = String(level) + "mg"
  }
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
}
