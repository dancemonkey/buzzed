//
//  DrinkStack.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/13/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class DrinkStack: UIStackView {
  
  @IBOutlet weak var timeLbl: UILabel!
  @IBOutlet weak var drinkImg: UIImageView!
  
  func configure(withDrink drink: CaffeineSourceCD) {
    self.isHidden = false
    if let imgName = drink.imageName {
      drinkImg.image = UIImage(named: imgName)
    }
    if let date = drink.creation {
      let formatter = DateFormatter()
      formatter.dateFormat = "HH:mm"
      timeLbl.text = formatter.string(from: date as Date)
      timeLbl.textColor = UIColor.darkGray
    }
  }

}
