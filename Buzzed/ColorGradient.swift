//
//  ColorGradient.swift
//  Swapr
//
//  Created by Drew Lanning on 12/28/16.
//  Copyright © 2016 Drew Lanning. All rights reserved.
//

import Foundation
import UIKit

class ColorGradient {
  
  let colorTop = UIColor(red: 207.0/255.0, green: 149.0/255.0, blue: 95.0/255.0, alpha: 1.0).cgColor // 8B572A
  let colorBottom = UIColor(red: 134.0/255.0, green: 90.0/255.0, blue: 50.0/255.0, alpha: 1.0).cgColor // D79257
  
  var gl: CAGradientLayer!
  
  init(withView view: UIView) {
    setGradient(withView: view)
  }
  
  private func setGradient(withView view: UIView) {
    gl = CAGradientLayer()
    gl.colors = [colorBottom, colorTop]
    gl.locations = [0.0, 1.0]
    view.backgroundColor = UIColor.clear
    gl.frame = view.frame
    view.layer.insertSublayer(gl, at: 0)
  }
  
  func setBottomLocation(forValue value: Float) {
    self.gl.locations![1] = NSNumber(value: value)
  }
  
  func setTopLocation(forValue value: Float) {
    self.gl.locations![0] = NSNumber(value: value)
  }
  
  func setColor(top: UIColor?, bottom: UIColor?) {
    if let color = top {
      gl.colors![0] = color.cgColor
    }
    if let color = bottom {
      gl.colors![1] = color.cgColor
    }
  }
  
  func drain(bottomValue value: Float) {
    self.gl.locations![1] = NSNumber(value: value)
  }
  
}
