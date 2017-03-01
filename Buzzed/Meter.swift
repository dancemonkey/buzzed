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
    
    let dm = DataManager()
    setMaxLevel(to: dm.getDailyIntake())
  }
  
  func setLevel(to level: Double) {
    self._level = level <= maxLevel ? level : _maxLevel
    rotateNeedle()
  }
  
  private var _level: Double = 0
  var level: Double {
    return _level
  }
  private let _minLevel: Double = 0
  var minLevel: Double {
    return _minLevel
  }
  private var _maxLevel: Double = 90
  var maxLevel: Double {
    return _maxLevel
  }
  
  private func setMaxLevel(to level: Double) {
    self._maxLevel = level
  }
  
  private func rotateNeedle() {
    UIView.animate(withDuration: 0.5) { 
      self.needle.transform = CGAffineTransform(rotationAngle: CGFloat(self._level) * CGFloat.pi / 180)
    }
  }
  
}
