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
  @IBOutlet weak var view: UIView!
  @IBOutlet weak var needleImg: UIImageView!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    view = Bundle.main.loadNibNamed("Meter", owner: self, options: nil)?[0] as! UIView
    self.addSubview(view)
    view.frame = self.bounds
    
    let dm = DataManager()
    _maxIntake = dm.getDailyIntake()
    setLevel(to: dm.getCurrentCaff())
  }
  
  private var _level: Double = 0
  var level: Double {
    return _level
  }
  private let _minLevel: Double = -90.0
  var minLevel: Double {
    return _minLevel
  }
  private var _maxLevel: Double = 90.0
  var maxLevel: Double {
    return _maxLevel
  }
  private var _maxIntake: Double = 300.0
  
  func setLevel(to level: Double) {
    let levelMod = level / (self._maxIntake / 180) - 90
    self._level = (levelMod <= maxLevel ? levelMod : _maxLevel)
    rotateNeedle()
  }
  
  private func setMaxLevel(to level: Double) {
    self._maxLevel = level
  }
  
  private func rotateNeedle() {
    UIView.animate(withDuration: 0.5) {
      let angle = CGFloat(self._level) * CGFloat.pi / 180
      self.needleImg.transform = CGAffineTransform(rotationAngle: angle)
    }
  }
  
}
