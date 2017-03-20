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
      // populate the container with this drink's data
      customDrinkContainer.editExisting(drink: drinkToEdit)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    topNav.configure(title: "Custom Drink")
  }
  
  @IBAction func backPressed(sender: UIButton) {
    _ = navigationController?.popViewController(animated: true)
  }
  
  @IBAction func savePressed(sender: UIButton) {
    let dm = DataManager()
    if customDrinkContainer.allEntriesValid() == true {
      print("valid entries")
      if let drink = existingDrink {
        print("saving existing drink")
        drink.sourceName = customDrinkContainer.drinkName.text!
        drink.sourceDescription = customDrinkContainer.drinkDesc.text!
        drink.mgCaffeinePerVolume = Double(customDrinkContainer.drinkCaffPer.text!)!
        drink.volume = Double(customDrinkContainer.drinkSize.text!)!
        dm.save()
        if customDrinkContainer.isFavorite() {
          // save this drink as favorite or not
        }
      } else {
        print("saving new drink")
        let tempDrink = customDrinkContainer.getDrink()
        dm.saveCustom(drink: tempDrink)
        _ = navigationController?.popViewController(animated: true)
        if customDrinkContainer.isFavorite() {
          // save drink as favorite drink too
        }
      }
    }
  }
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "customDrinkBuildContainer" {
      if let child = segue.destination as? CustomDrinkBuildTableVC {
        customDrinkContainer = child
      }
    }
  }
  
}
