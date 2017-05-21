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
//  @IBOutlet weak var drinkDesc: UITextField!
  @IBOutlet weak var drinkSize: UITextField!
  @IBOutlet weak var drinkCaffPer: UITextField!
  @IBOutlet weak var sizeInLbl: UILabel!
  @IBOutlet weak var mgCaffPerLbl: UILabel!
  @IBOutlet var drinkIconBtns: [UIButton]!
  
  var selectedIcon: UIImage = UIImage(named: CaffeineSourceType.dripCoffee.getAssociatedImageName())!
  
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
    let validSize = drinkSize.text?.isEmpty == false && Double(drinkSize.text!) != nil && drinkSize.numbersOnly()
    let validCaff = drinkCaffPer.text?.isEmpty == false && Double(drinkCaffPer.text!) != nil && drinkCaffPer.numbersOnly()
    
    let valids: [Bool] = [validName, validSize, validCaff]
    let fields = [drinkName, drinkSize, drinkCaffPer]
    
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
    
    return validName && validSize && validCaff
  }
  
  func getDrinkIconName(fromSelection selection: Int) -> String {
    switch selection {
    case 0:
      return CaffeineSourceType.dripCoffee.getAssociatedImageName()
    case 1:
      return CaffeineSourceType.soda.getAssociatedImageName()
    case 2:
      return CaffeineSourceType.blackTea.getAssociatedImageName()
    case 3:
      return CaffeineSourceType.energyDrink.getAssociatedImageName()
    case 4:
      return CaffeineSourceType.icedTea.getAssociatedImageName()
    default:
      return CaffeineSourceType.dripCoffee.getAssociatedImageName()
    }
  }
  
  @IBAction func drinkIconPressed(sender: UIButton) {
    selectedIcon = UIImage(named: getDrinkIconName(fromSelection: sender.tag))!
    for button in drinkIconBtns {
      button.borderColor = .clear
    }
    sender.borderColor = Constants.Color.accentSuccess.bground()
    sender.borderWidth = 1.0
  }
  
  func getDrink() -> CaffeineSource {
    var drink: CaffeineSource
    drink = CaffeineSource(type: .custom, volume: Double(drinkSize.text!)!)
    drink.setCaffeinePerVolume(inMg: Double(drinkCaffPer.text!)!)
    drink.changeName(to: drinkName.text!)
    drink.changeDescription(to: "")
    return drink
  }
  
  func editExisting(_ drink: CustomDrink) {
    self.drinkName.text = drink.sourceName!
//    self.drinkDesc.text = drink.sourceDescription!
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
