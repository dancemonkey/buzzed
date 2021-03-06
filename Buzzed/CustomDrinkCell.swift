//
//  CustomDrinkCell.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/17/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class CustomDrinkCell: UITableViewCell {
  
  @IBOutlet weak var drinkImg: UIImageView!
  @IBOutlet weak var drinkNameLbl: UILabel!
  @IBOutlet weak var drinkInfoLbl: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    drinkInfoLbl.textColor = .darkGray
    drinkNameLbl.textColor = .darkGray
  }
  
  func config(withDrink drink: CustomDrink) {
    let dm = DataManager()
    drinkImg.image = UIImage(named: CaffeineSourceType.custom.getBlankImageName())
    drinkNameLbl.text = "\(drink.sourceName!) - \(drink.volume) \(dm.getDefaultUnits().symbol)"
    let unit = DataManager().getDefaultUnits()
    drinkInfoLbl.text = "\(drink.mgCaffeinePerVolume)mg per \(unit.symbol)"
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
}
