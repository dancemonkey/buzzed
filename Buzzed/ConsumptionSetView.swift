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
    caffeineSourceImg.image = UIImage(named: imageName!)
  }
  
  func cropToConsumptionTest() {
    // calculation wrong, should be inverted percentage
    // zooming in on image, should remain in place
    guard let src = self.source else {
      return
    }
    let rect = caffeineSourceImg.bounds
    let cc = src.percentageConsumed
    let cropRect = CGRect(x: 0, y: 0, width: rect.size.width, height: CGFloat(Double(rect.size.height) * cc))
    let imageRef = caffeineSourceImg.image?.cgImage?.cropping(to: cropRect)
    let newImage = UIImage(cgImage: imageRef!, scale: (caffeineSourceImg.image?.scale)!, orientation: (caffeineSourceImg.image?.imageOrientation)!)
    caffeineSourceImg.image = newImage
  }
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
}
