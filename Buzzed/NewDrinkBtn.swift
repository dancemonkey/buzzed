//
//  NewDrinkBtn.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/2/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit
import QuartzCore

class NewDrinkBtn: UIButton {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setShadow()
  }
  
  private func setShadow() {
    layer.shadowColor = (LargeDrink.Shadow.color.value() as! CGColor)
    layer.shadowRadius = LargeDrink.Shadow.radius.value() as! CGFloat
    layer.shadowOffset = LargeDrink.Shadow.offset.value() as! CGSize
    layer.shadowOpacity = LargeDrink.Shadow.opacity.value() as! Float
    layer.masksToBounds = false
  }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}