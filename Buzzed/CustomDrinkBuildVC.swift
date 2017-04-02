//
//  CustomDrinkBuildVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/15/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class CustomDrinkBuildVC: UIViewController {
  
  @IBOutlet weak var topNav: TopNav!
  var customDrinkContainer: CustomDrinkBuildTableVC!
  
  var existingDrink: CustomDrink?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let drinkToEdit = existingDrink {
      customDrinkContainer.editExisting(drinkToEdit)
    }
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    topNav.configure(title: "Custom Drink")
  }
  
  @IBAction func backPressed(_ sender: UIButton) {
    _ = navigationController?.popViewController(animated: true)
  }
  
  @IBAction func savePressed(_ sender: UIButton) {
    let dm = DataManager()
    if customDrinkContainer.allEntriesValid() == true {
      if let drink = existingDrink {
        drink.sourceName = customDrinkContainer.drinkName.text!
        drink.sourceDescription = customDrinkContainer.drinkDesc.text!
        drink.mgCaffeinePerVolume = Double(customDrinkContainer.drinkCaffPer.text!)!
        drink.volume = Double(customDrinkContainer.drinkSize.text!)!
        dm.save()
        if customDrinkContainer.isFavorite() {
          // save this drink as favorite or not
        }
      } else {
        let tempDrink = customDrinkContainer.getDrink()
        dm.saveCustom(tempDrink)
        if customDrinkContainer.isFavorite() {
          // save drink as favorite drink too
        }
      }
      _ = navigationController?.popViewController(animated: true)
    }
  }
  
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "customDrinkBuildContainer" {
      if let child = segue.destination as? CustomDrinkBuildTableVC {
        customDrinkContainer = child
      }
    }
  }
  
}
