//
//  SizeSelectCell.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/9/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class SizeSelectCell: UITableViewCell {
  
  @IBOutlet weak var sizeName: UILabel!
  @IBOutlet weak var totalCaff: UILabel!
  @IBOutlet weak var drinkImg: UIImageView!
  
  func configure(withType type: CaffeineSourceType, andSize volume: Double) {
    let dm = DataManager()
    drinkImg.image = UIImage(named: "Blank Drink") //type.getAssociatedImageName())
    let caff = type.getMgCaffeinePer(volumeUnit: dm.getDefaultUnits()) * volume
    totalCaff.text = "\(caff)mg total caffeine"
    sizeName.text = "\(volume) \(dm.getDefaultUnits().symbol)"
    
    sizeName.textColor = UIColor.white
    totalCaff.textColor = UIColor.white
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
