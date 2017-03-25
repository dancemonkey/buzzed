//
//  ConsumptionSetView.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/26/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit
//import QuartzCore

class ConsumptionSetView: UIView, Hideable {
  
  @IBOutlet weak var caffeineSourceImg: UIImageView!
  @IBOutlet weak var liquidImg: UIImageView!
  @IBOutlet weak var view: UIView!
  
  // TESTING: Label for testing
  @IBOutlet weak var caffeineConsumptionLbl: UILabel!
  
  var source: CaffeineSource?
  var level: Double!
  var settingLevel: Bool = false
  
  let minLevel: Double = 0.0
  let testSource: CaffeineSource = CaffeineSource(type: .dripCoffee, volume: 16.0)
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    view = Bundle.main.loadNibNamed("ConsumptionSetView", owner: self, options: nil)?[0] as! UIView
    self.addSubview(view)
    view.frame = self.bounds
    
    // for testing, source will most likely be set from parent or segue
    guard self.source != nil else {
      setSource(to: testSource)
      return
    }
    // end testing
  }
  
  func setLevel(to level: Double) {
    self.level = level
    source?.consume(percentage: self.level)
    setDrinkLevel()
  
  }
  
  func setSource(to source: CaffeineSource) {
    self.source = source
    let imageName = self.source!.associatedImageName
    
    // TODO: load liquid background view image from enum too, based on drink type
    
    let liquidImage = UIImage(named: "LiquidWhite")
    caffeineSourceImg.image = UIImage(named: imageName!)
    liquidImg.image = liquidImage
    
    setShadow()
    
    setLevel(to: minLevel)
    addMask()
    setDrinkLevel()
  }
  
  private func setShadow() {
    caffeineSourceImg.layer.shadowColor = (LargeDrink.Shadow.color.value() as! CGColor)
    caffeineSourceImg.layer.shadowRadius = LargeDrink.Shadow.radius.value() as! CGFloat
    caffeineSourceImg.layer.shadowOffset = LargeDrink.Shadow.offset.value() as! CGSize
    caffeineSourceImg.layer.shadowOpacity = LargeDrink.Shadow.opacity.value() as! Float
  }
  
  private func addMask() {
    let drinkMask = UIImageView(image: UIImage(named: "DrinkMask"))
    drinkMask.contentMode = liquidImg.contentMode
    drinkMask.bounds = liquidImg.bounds
    liquidImg.mask = drinkMask
  }
  
  private func setDrinkLevel() {

    guard let mask = liquidImg.mask else {
      return
    }
    guard let src = self.source else {
      return
    }
    
    let cc = src.percentageConsumed
    let newY = -(liquidImg.bounds.height * CGFloat(cc))
    let offset: CGFloat = 50 * CGFloat(cc)

    mask.frame = CGRect(x: 0, y: newY+offset, width: mask.bounds.width, height: mask.bounds.height)
  }
  
  private func getLevel(fromTouchDiff touchDiff: CGFloat) -> CGFloat {
    return ((touchDiff / caffeineSourceImg.frame.height) * 100).clamped(to: 0...100)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    settingLevel = true
    let diff = caffeineSourceImg.frame.height - touches.first!.location(in: self).y
    setLevel(to: Double(getLevel(fromTouchDiff: diff)))
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    let diff = caffeineSourceImg.frame.height - touches.first!.location(in: self).y
    setLevel(to: Double(getLevel(fromTouchDiff: diff)))
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    settingLevel = false
  }
  
}
