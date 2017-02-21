//
//  Meter.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/18/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class Meter: UIView {
  
  @IBOutlet weak var background: UIImageView!
  @IBOutlet weak var needle: UIImageView!
  @IBOutlet weak var view: UIView!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    view = Bundle.main.loadNibNamed("Meter", owner: self, options: nil)?[0] as! UIView
    self.addSubview(view)
    view.frame = self.bounds
    
    setLevel(to: minLevel)
  }
  
  private var _level: CGFloat = 0
  var level: CGFloat {
    return _level
  }
  private let _minLevel: CGFloat = 0
  var minLevel: CGFloat {
    return _minLevel
  }
  private var _maxLevel: CGFloat = 90
  var maxLevel: CGFloat {
    return _maxLevel
  }
  
  func setLevel(to level: CGFloat) {
    self._level = level <= maxLevel ? level : _maxLevel
    rotateNeedle()
  }
  
  func setMaxLevel(to level: CGFloat) {
    self._maxLevel = level
  }
  
  private func rotateNeedle() {
    UIView.animate(withDuration: 0.5) { 
      self.needle.transform = CGAffineTransform(rotationAngle: self._level * CGFloat.pi / 180)
    }
  }
  
}
