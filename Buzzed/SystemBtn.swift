//
//  DoneBtn.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/7/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

enum ButtonStyle: String {
  case done, cancel, info, disabled, destructive
}

class SystemBtn: UIButton {
  
  fileprivate var _style: ButtonStyle = .done
  
  @IBInspectable var style: String {
    get {
      return _style.rawValue
    }
    set {
      self._style = ButtonStyle(rawValue: newValue)!
    }
  }
  
  override func awakeFromNib() {
    setShadow()
    self.setTitleColor(.white, for: .normal)
    setStyle(to: _style)
  }
  
  func setStyle(to style: ButtonStyle) {
    switch style {
    case .done:
      titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
      backgroundColor = Constants.Color.doneBtn.bground()
    case .cancel:
      titleLabel?.font = UIFont.italicSystemFont(ofSize: 18)
      backgroundColor = Constants.Color.cancelBtn.bground()
    case .info:
      titleLabel?.font = UIFont.italicSystemFont(ofSize: 18)
      backgroundColor = Constants.Color.infoBtn.bground()
    case .disabled:
      titleLabel?.font = UIFont.italicSystemFont(ofSize: 18)
      backgroundColor = UIColor.gray
      removeShadow()
    case .destructive:
      backgroundColor = Constants.Color.accentError.bground()
    }
    self._style = style
  }
  
  fileprivate func setShadow() {
    self.layer.shadowColor = (Button.Shadow.color.value() as! CGColor)
    self.layer.shadowRadius = Button.Shadow.radius.value() as! CGFloat
    self.layer.shadowOffset = Button.Shadow.offset.value() as! CGSize
    self.layer.shadowOpacity = Button.Shadow.opacity.value() as! Float
  }
  
  fileprivate func removeShadow() {
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

}
