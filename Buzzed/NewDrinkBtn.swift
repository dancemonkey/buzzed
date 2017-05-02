//
//  NewDrinkBtn.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/2/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit
import QuartzCore

class NewDrinkBtn: UIButton, Hideable {
  
  override func awakeFromNib() {
    super.awakeFromNib()
//    setShadow()
  }
  
  fileprivate func setShadow() {
    layer.shadowColor = (LargeDrink.Shadow.color.value() as! CGColor)
    layer.shadowRadius = LargeDrink.Shadow.radius.value() as! CGFloat
    layer.shadowOffset = LargeDrink.Shadow.offset.value() as! CGSize
    layer.shadowOpacity = LargeDrink.Shadow.opacity.value() as! Float
    layer.masksToBounds = false
  }

}
