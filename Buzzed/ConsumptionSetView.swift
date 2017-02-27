//
//  ConsumptionSetView.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/26/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit
import QuartzCore

class ConsumptionSetView: UIView {
  
  @IBOutlet weak var caffeineSourceImg: UIImageView!
  @IBOutlet weak var liquidImg: UIImageView!
  @IBOutlet weak var view: UIView!
  
  // TESTING: Label for testing
  @IBOutlet weak var caffeineConsumptionLbl: UILabel!
  
  var source: CaffeineSource?
  var level: Double!
  
  let minLevel: Double = 10.0
  let testSource: CaffeineSource = CaffeineSource(type: .dripCoffee, volume: 16.0)
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    view = Bundle.main.loadNibNamed("ConsumptionSetView", owner: self, options: nil)?[0] as! UIView
    self.addSubview(view)
    view.frame = self.bounds
    
    setLevel(to: minLevel)
    
    // for testing
    guard self.source != nil else {
      setSource(to: testSource)
      return
    }
    // end testing
  }
  
  func setLevel(to level: Double) {
    self.level = level
    source?.consume(percentage: self.level)
    
    // TESTING: Label is just for testing until I get drawing implemented
    cropToConsumptionTest()
    if let source = self.source {
      caffeineConsumptionLbl.text = "Consumed \(source.totalCaffeineConsumed())mg"
    } else {
      caffeineConsumptionLbl.text = ""
    }
  }
  
  func setSource(to source: CaffeineSource) {
    self.source = source
    let imageName = self.source!.associatedImageName
    // TODO: load liquid background view image from enum too, based on drink type
    let liquidImage = UIImage(named: "LiquidBrown")
    caffeineSourceImg.image = UIImage(named: imageName!)
    liquidImg.image = liquidImage
  }
  
  func addMask() {
    let drinkMask = UIImageView(image: UIImage(named: "DrinkMask"))
    drinkMask.contentMode = liquidImg.contentMode
    liquidImg.mask = drinkMask
    bottomOutMask()
  }
  
  private func bottomOutMask() {
    guard let mask = liquidImg.mask else {
      return
    }
    
    print(#function)
    print("original mask frame = \(liquidImg.mask?.frame)")
    
    mask.frame = CGRect(x: 0, y: -liquidImg.frame.height, width: mask.bounds.width, height: mask.bounds.height)
    
    print("new mask frame = \(liquidImg.mask?.frame)")
  }
  
  func cropToConsumptionTest() {
    guard let mask = liquidImg.mask else {
      return
    }
    guard let src = self.source else {
      return
    }
    
    let cc = src.percentageConsumed
    let newY = -(liquidImg.bounds.height * CGFloat(cc))
    
    print(#function)
    print(newY)
    print("original mask frame = \(liquidImg.mask?.frame)")
    
    mask.frame = CGRect(x: 0, y: newY, width: mask.bounds.width, height: mask.bounds.height)
    
    print("new mask frame = \(liquidImg.mask?.frame)")
    print("image bounds = \(liquidImg.bounds)")
  }
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
}
