//
//  ShadowBtn.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/2/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class ShadowBtn: UIButton {

  override func awakeFromNib() {
    super.awakeFromNib()
    setShadow()
  }
  
  private func setShadow() {
    layer.shadowColor = (Button.Shadow.color.value() as! CGColor)
    layer.shadowRadius = Button.Shadow.radius.value() as! CGFloat
    layer.shadowOffset = Button.Shadow.offset.value() as! CGSize
    layer.shadowOpacity = Button.Shadow.opacity.value() as! Float
  }
  
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
