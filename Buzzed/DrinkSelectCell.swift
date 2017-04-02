
//
//  DrinkSelectCell.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/9/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class DrinkSelectCell: UITableViewCell {
  
  @IBOutlet weak var drinkImg: UIImageView!
  @IBOutlet weak var drinkName: UILabel!
  @IBOutlet weak var drinkInfo: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configure(with source: CaffeineSourceType) {
    self.drinkImg.image = UIImage(named: "Blank Drink") //UIImage(named: source.getAssociatedImageName())
    self.drinkName.text = source.getName()
    let unit = DataManager().getDefaultUnits()
    self.drinkInfo.text = "\(source.getMgCaffeinePer(unit))mg per \(unit.symbol)"
    drinkName.textColor = UIColor.white
    drinkInfo.textColor = UIColor.white
  }
}
