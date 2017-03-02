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
  
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var maxCaff: UILabel!
  @IBOutlet weak var totalCaff: UILabel!
  @IBOutlet weak var meter: Meter!
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
}
