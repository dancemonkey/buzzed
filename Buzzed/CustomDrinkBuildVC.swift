//
//  CustomDrinkBuildVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/15/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit
import Toast_Swift

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
        drink.sourceDescription = ""
        drink.imageName = CaffeineSourceType.custom.getAssociatedImageName()
        drink.mgCaffeinePerVolume = Double(customDrinkContainer.drinkCaffPer.text!)!
        drink.volume = Double(customDrinkContainer.drinkSize.text!)!
        dm.save()
      } else {
        let tempDrink = customDrinkContainer.getDrink()
        dm.saveCustom(tempDrink)
      }
      _ = navigationController?.popViewController(animated: true)
    }
    self.view.makeToast("Saved!", duration: 2.0, position: .bottom)
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
