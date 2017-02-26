//
//  ConsumptionSetView.swift
//  Buzzed
//
//  Created by Drew Lanning on 2/26/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class ConsumptionSetView: UIView {
  
  @IBOutlet weak var caffeineSourceImg: UIImageView!
  @IBOutlet weak var view: UIView!
  
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
    print("\(#function) level set to \(self.level)")
    source?.consume(percentage: self.level)
  }
  
  func setSource(to source: CaffeineSource) {
    self.source = source
    let imageName = self.source!.associatedImageName
    caffeineSourceImg.image = UIImage(named: imageName!)
  }
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
}
