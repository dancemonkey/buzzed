//
//  CustomDrinkBuildTableVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/16/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class CustomDrinkBuildTableVC: UITableViewController {
  
  @IBOutlet weak var drinkName: UITextField!
  @IBOutlet weak var drinkDesc: UITextField!
  @IBOutlet weak var drinkSize: UITextField!
  @IBOutlet weak var drinkCaffPer: UITextField!
  @IBOutlet weak var setFavorite: UISwitch!
  @IBOutlet weak var sizeInLbl: UILabel!
  @IBOutlet weak var mgCaffPerLbl: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupViews()
  }
  
  func setupViews() {
    let dm = DataManager()
    sizeInLbl.text = "Size in \(dm.getDefaultUnits().symbol)"
    mgCaffPerLbl.text = "Mg caffeine per \(dm.getDefaultUnits().symbol)"
  }
  
  func allEntriesValid() -> Bool {
    let validName = drinkName.text?.isEmpty == false
    let validDesc = drinkDesc.text?.isEmpty == false
    let validSize = drinkSize.text?.isEmpty == false && Double(drinkSize.text!) != nil && drinkSize.numbersOnly()
    let validCaff = drinkCaffPer.text?.isEmpty == false && Double(drinkCaffPer.text!) != nil && drinkCaffPer.numbersOnly()
    return validName && validDesc && validSize && validCaff
  }
  
  func isFavorite() -> Bool {
    return setFavorite.isOn
  }
  
  func getDrink() -> CaffeineSource {
    var drink: CaffeineSource
    drink = CaffeineSource(type: .custom, volume: Double(drinkSize.text!)!)
    drink.setCaffeinePerVolume(inMg: Double(drinkCaffPer.text!)!)
    drink.changeName(to: drinkName.text!)
    drink.changeDescription(to: drinkDesc.text!)
    return drink
  }
  
  func editExisting(_ drink: CustomDrink) {
    self.drinkName.text = drink.sourceName!
    self.drinkDesc.text = drink.sourceDescription!
    self.drinkSize.text = drink.volume.cleanValue
    self.drinkCaffPer.text = drink.mgCaffeinePerVolume.cleanValue
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//    
//    // Configure the cell...
//    
//    return cell
//  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
