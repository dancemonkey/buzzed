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
    
    // TODO: this should eventually call core data for current daily caffeine level, not minLevel
    // INFO: minLevel is basically zero on the meter
    setLevel(to: minLevel)
    
    let dm = DataManager()
    setMaxLevel(to: dm.getDailyIntake())
  }
  
  func setLevel(to level: Double) {
    self._level = level <= maxLevel ? level : _maxLevel
    rotateNeedle()
  }
  
  private func setZeroLevel(to level: Double) {
    
  }
  
  private var _level: Double = 0
  var level: Double {
    return _level
  }
  private let _minLevel: Double = -75.0
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
      self.needleImg.transform = CGAffineTransform(rotationAngle: CGFloat(self._level) * CGFloat.pi / 180)
    }
  }
  
//  private func drawNeedle() {
//    let start = CGPoint(x: background.frame.width/2, y: background.frame.height)
//    let end = CGPoint(x: background.frame.width/2, y: 0)
//    background.image = drawLineOnImage(size: background.frame.size, image: needleImg.image!, from: start, to: end)
//  }
//  
//  override func draw(_ rect: CGRect) {
//    
//  }
//  
//  private func drawLineOnImage(size: CGSize, image: UIImage, from: CGPoint, to: CGPoint) -> UIImage {
//    
//    UIGraphicsBeginImageContext(size)
//    image.draw(at: CGPoint.zero)
//    
//    let context = UIGraphicsGetCurrentContext()
//    
//    context!.setLineWidth(2.0)
//    context!.setStrokeColor(UIColor.white.cgColor)
//    
//    context!.move(to: from)
//    context!.addLine(to: to)
//    
//    context!.strokePath()
//    
//    let resultImage = UIGraphicsGetImageFromCurrentImageContext()
//    
//    UIGraphicsEndImageContext()
//    
//    return resultImage!
//  }

  
}
