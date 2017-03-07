//
//  DoneBtn.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/7/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

enum ButtonStyle: String {
  case done, cancel, info
}

class SystemBtn: UIButton {
  
  private var _style: ButtonStyle = .done
  
  @IBInspectable var style: String {
    get {
      return _style.rawValue
    }
    set {
      self._style = ButtonStyle(rawValue: newValue)!
    }
  }
  
  override func awakeFromNib() {
    switch _style {
    case .done:
      titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
      backgroundColor = Constants.Color.doneBtn.bground()
    case .cancel:
      titleLabel?.font = UIFont.italicSystemFont(ofSize: 18)
      backgroundColor = Constants.Color.cancelBtn.bground()
    case .info:
      titleLabel?.font = UIFont.italicSystemFont(ofSize: 18)
      backgroundColor = Constants.Color.infoBtn.bground()
    }
    self.setTitleColor(.white, for: .normal)
    setShadow()
  }
  
  private func setShadow() {
    self.layer.shadowColor = (Button.Shadow.color.value() as! CGColor)
    self.layer.shadowRadius = Button.Shadow.radius.value() as! CGFloat
    self.layer.shadowOffset = Button.Shadow.offset.value() as! CGSize
    self.layer.shadowOpacity = Button.Shadow.opacity.value() as! Float
  }
  
  private func removeShadow() {
    self.layer.shadowOpacity = 0.0
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    removeShadow()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    setShadow()
  }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
