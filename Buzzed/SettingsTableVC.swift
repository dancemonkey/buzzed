//
//  SettingsTableVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/3/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class SettingsTableVC: UITableViewController, DrinkSelectDelegate, UITextFieldDelegate {
  
  @IBOutlet weak var defaultDrinkLbl: UILabel!
  @IBOutlet weak var dailyLimitFld: UITextField!
  @IBOutlet weak var defaultUnitsCtl: DefaultUnitControl!
  @IBOutlet weak var healthConnectLbl: UILabel!

  var dm: DataManager!
  var tapper: UITapGestureRecognizer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let hm = HealthManager()
    healthConnectLbl.isEnabled = hm.isAuthorized()
    if healthConnectLbl.isEnabled == false {
      healthConnectLbl.text = "Not connected to Health"
    } else {
      healthConnectLbl.textColor = Constants.Color.accentSuccess.bground()
      healthConnectLbl.text = "Connected to Health"
    }
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
    dailyLimitFld.delegate = self
  }
  
  @IBAction func deleteAllPressed(sender: SystemBtn) {
    showConfirmationPopup()
  }
  
  func showConfirmationPopup() {
    let alert = UIAlertController(title: "Delete all data?", message: "Are you sure you want to delete all of your caffeine data from the app?", preferredStyle: .actionSheet)
    let cancel = UIAlertAction(title: "Nevermind!", style: .cancel, handler: nil)
    let confirm = UIAlertAction(title: "Yep, go for it.", style: .destructive) { (action) in
      let dm = DataManager()
      dm.clearAllHistory()
      // also pop-up asking if all Health data should be removed
    }
    alert.addAction(confirm)
    alert.addAction(cancel)
    present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.item == 0 || indexPath.item == 2 {
      performSegue(withIdentifier: tableView.cellForRow(at: indexPath)!.reuseIdentifier!, sender: self)
    }
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("preparing for segue")
    if let dest = segue.destination as? DrinkSelectVC {
      dest.passThroughDelegate = self
    }
  }
  
  // MARK: - TextFieldDelegate methods
  
  func didTapView() {
    self.view.endEditing(true)
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    tapper = UITapGestureRecognizer(target: self, action: #selector(SettingsTableVC.didTapView))
    self.view.addGestureRecognizer(tapper)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    self.view.removeGestureRecognizer(tapper)
  }
  
}
