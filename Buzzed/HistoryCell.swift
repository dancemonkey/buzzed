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
  
  var drinkStacks = [DrinkStack]()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    hideDrinkStacks()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func hideDrinkStacks() {
    drinkStack1.isHidden = true
    drinkStack2.isHidden = true
    drinkStack3.isHidden = true
    isUserInteractionEnabled = false
  }
  
  func configure(withDrinks drinks: [CaffeineSourceCD]) {
    guard drinks.count > 0 else {
      dateLbl.text = "No history"
      caffLbl.text = ""
      self.accessoryType = .none
      self.selectionStyle = .none
      return
    }
    
    isUserInteractionEnabled = true
    
    drinkStacks = [drinkStack1, drinkStack2, drinkStack3]
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-dd-yy"
    dateLbl.text = formatter.string(from: drinks.first!.creation! as Date)
    caffLbl.text = String(drinks.reduce(0, { (result, drink) -> Double in
      let consumed: Double = (drink.volume * drink.mgCaffeinePerVolume) * drink.percentageConsumed
      return result + consumed
    }).roundTo(0)) + "mg"
    
    for (index, drink) in drinks.enumerated() where index < 3 {
      drinkStacks[index].configure(withDrink: drink)
    }
  }
  
}
