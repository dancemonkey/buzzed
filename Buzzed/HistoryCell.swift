//
//  HistoryCell.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/13/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
  
  @IBOutlet weak var dateLbl: UILabel!
  @IBOutlet weak var caffLbl: UILabel!
  @IBOutlet weak var drinkStack1: DrinkStack!
  @IBOutlet weak var drinkStack2: DrinkStack!
  @IBOutlet weak var drinkStack3: DrinkStack!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
