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
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
      let tempDrink = customDrinkContainer.getDrink()
      dm.saveCustom(drink: tempDrink)
      if customDrinkContainer.isFavorite() {
        // save drink as favorite drink too
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
