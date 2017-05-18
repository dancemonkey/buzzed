
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
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  func configure(with source: CaffeineSourceType) {
    self.drinkImg.image = UIImage(named: source.getBlankImageName())
    self.drinkName.text = source.getName()
    let unit = DataManager().getDefaultUnits()
    self.drinkInfo.text = "\(source.getMgCaffeinePer(unit))mg per \(unit.symbol)"
    drinkName.textColor = .darkGray
    drinkInfo.textColor = .darkGray
  }
}
