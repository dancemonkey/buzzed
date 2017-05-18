//
//  HistoryDetailCell.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/20/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class HistoryDetailCell: UITableViewCell {
  
  @IBOutlet weak var drinkName: UILabel!
  @IBOutlet weak var caffTotal: UILabel!
  @IBOutlet weak var drinkStack: DrinkStack!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configCell(with drink: CaffeineSourceCD) {
    let dm = DataManager()
    let size = drink.volume
    let units = dm.getDefaultUnits().symbol
    let drinkSize = "\(size) \(units)"
    drinkName.text = drinkSize + " - " + drink.sourceName!
    let totalCaffAvailable = drink.mgCaffeinePerVolume * drink.volume
    caffTotal.text = (totalCaffAvailable * drink.percentageConsumed).roundTo(2).cleanValue + " mg"
    drinkStack.configure(withDrink: drink)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
}
