//
//  SettingsVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/2/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
  
  @IBOutlet weak var topNav: TopNav!
  
  var settingsContainer: SettingsTableVC!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    initialSetup()
  }
  
  func initialSetup() {
    _ = ColorGradient(withView: self.view)
    topNav.configure(title: "Settings")
  }
  
  @IBAction func savePressed(_ sender: UIButton) {
    let dm = DataManager()
    if settingsContainer.dailyLimitFld.numbersOnly() {
      dm.setDailyIntake(Double(settingsContainer.dailyLimitFld.text!)!)
      settingsContainer.dailyLimitFld.clearBorder()
      dm.setDefaultMeasurement(settingsContainer.defaultUnitsCtl.getDefaultUnit())
    } else {
      settingsContainer.dailyLimitFld.invalidEntryDisplay()
    }
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "settingsContainer" {
      if let child = segue.destination as? SettingsTableVC {
        settingsContainer = child
      }
    }
  }
  
}
