//
//  Extensions.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/21/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

public extension Double {
  func roundTo(_ places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
  
  var cleanValue: String {
    return self.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(self)) : String(self)
  }
}

extension Comparable {
  func clamped(to limits: ClosedRange<Self>) -> Self {
    return min(max(self, limits.lowerBound), limits.upperBound)
  }
}

extension UIColor {
  convenience init(red: Int, green: Int, blue: Int) {
    let newRed = CGFloat(red)/255
    let newGreen = CGFloat(green)/255
    let newBlue = CGFloat(blue)/255
    
    self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
  }
}

extension UITextField {
  
  func numbersOnly() -> Bool {
    guard let text = self.text, text != "" else {
      return false
    }
    let allowed = CharacterSet.decimalDigits
    let textSet = CharacterSet(charactersIn: text)
    return allowed.isSuperset(of: textSet)
  }
  
  func invalidEntryDisplay() {
    self.backgroundColor = Constants.Color.accentError.bground().withAlphaComponent(0.75)
    self.textColor = .white
  }
  
  func validEntryDisplay() {
    self.backgroundColor = UIColor.white.withAlphaComponent(0.75)
    self.textColor = Constants.Color.doneBtn.bground()
  }
  
  func clearBorder() {
    self.borderColor = UIColor.clear
  }
}

extension UIView {
  
  @IBInspectable var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
      layer.masksToBounds = newValue > 0
    }
  }
  
  @IBInspectable var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable var borderColor: UIColor? {
    get {
      return UIColor(cgColor: layer.borderColor!)
    }
    set {
      layer.borderColor = newValue?.cgColor
    }
  }
  
}
