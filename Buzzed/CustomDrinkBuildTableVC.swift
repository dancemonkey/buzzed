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
    
    let valids: [Bool] = [validName, validDesc, validSize, validCaff]
    let fields = [drinkName, drinkDesc, drinkSize, drinkCaffPer]
    
    for (index, valid) in valids.enumerated() {
      if !valid {
        UIView.animateKeyframes(withDuration: 0.0, delay: 0.0, options: [], animations: {
          fields[index]?.invalidEntryDisplay()
        }, completion: { (done) in
          UIView.animate(withDuration: 2.0, animations: {
            fields[index]?.validEntryDisplay()
          })
        })
      }
    }
    
    return validName && validDesc && validSize && validCaff
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
    return 4
  }
  
}
