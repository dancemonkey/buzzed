//
//  SettingsTableVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/3/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class SettingsTableVC: UITableViewController, DrinkSelectDelegate {
  
  @IBOutlet weak var defaultDrinkLbl: UILabel!
  @IBOutlet weak var dailyLimitFld: UITextField!
  @IBOutlet weak var defaultUnitsCtl: DefaultUnitControl!
  @IBOutlet weak var healthConnectImg: UIImageView!

  var dm: DataManager!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
  }
  
  func setupViews() {
    dm = DataManager()
    dailyLimitFld.text = dm.getDailyIntake().cleanValue
    defaultDrinkLbl.text = "Favorite drink - " + (dm.getFavoriteDrink()?.sourceName ?? "(none selected)")
    switch dm.getDefaultUnits() {
    case UnitVolume.milliliters:
      defaultUnitsCtl.selectedSegmentIndex = 1
    case UnitVolume.fluidOunces:
      defaultUnitsCtl.selectedSegmentIndex = 0
    default:
      defaultUnitsCtl.selectedSegmentIndex = 0
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("table row selected")
    if indexPath.item == 0 || indexPath.item == 2 {
      performSegue(withIdentifier: tableView.cellForRow(at: indexPath)!.reuseIdentifier!, sender: self)
    }
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let dest = segue.destination as? DrinkSelectVC {
      dest.passThroughDelegate = self
    }
  }
  
}
