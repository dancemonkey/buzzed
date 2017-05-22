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
  @IBOutlet weak var drinkSize: UITextField!
  @IBOutlet weak var drinkCaffPer: UITextField!
  @IBOutlet weak var sizeInLbl: UILabel!
  @IBOutlet weak var mgCaffPerLbl: UILabel!
  @IBOutlet var drinkIconBtns: [UIButton]!
  
  var selectedIcon: String = CaffeineSourceType.dripCoffee.getAssociatedImageName()
  
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
  
//  func highlightSelectedIcon() {
//    switch selectedIcon {
//    case CaffeineSourceType.dripCoffee.getBlankImageName():
//      highlight(iconButton: getButton(withTag: 0)!)
//    case CaffeineSourceType.soda.getBlankImageName():
//      highlight(iconButton: getButton(withTag: 1)!)
//    case CaffeineSourceType.blackTea.getBlankImageName():
//      highlight(iconButton: getButton(withTag: 2)!)
//    case CaffeineSourceType.energyDrink.getBlankImageName():
//      highlight(iconButton: getButton(withTag: 3)!)
//    case CaffeineSourceType.icedTea.getBlankImageName():
//      highlight(iconButton: getButton(withTag: 4)!)
//    default:
//      highlight(iconButton: getButton(withTag: 0)!)
//    }
//  }
  
//  func getButton(withTag tag: Int) -> UIButton? {
//    for button in drinkIconBtns {
//      if button.tag == tag {
//        return button
//      }
//    }
//    return nil
//  }
  
//  func getDrinkIconName(fromSelection selection: Int) -> String {
//    switch selection {
//    case 0:
//      return CaffeineSourceType.dripCoffee.getBlankImageName()
//    case 1:
//      return CaffeineSourceType.soda.getBlankImageName()
//    case 2:
//      return CaffeineSourceType.blackTea.getBlankImageName()
//    case 3:
//      return CaffeineSourceType.energyDrink.getBlankImageName()
//    case 4:
//      return CaffeineSourceType.icedTea.getBlankImageName()
//    default:
//      return CaffeineSourceType.dripCoffee.getBlankImageName()
//    }
//  }
//  
//  func highlight(iconButton: UIButton) {
//    iconButton.borderColor = Constants.Color.accentSuccess.bground()
//    iconButton.borderWidth = 1.0
//  }
  
//  @IBAction func drinkIconPressed(sender: UIButton) {
//    selectedIcon = getDrinkIconName(fromSelection: sender.tag)
//    for button in drinkIconBtns {
//      button.borderColor = .clear
//    }
//    highlight(iconButton: sender)
//    self.view.endEditing(true)
//  }
  
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
    self.drinkSize.text = drink.volume.cleanValue
    self.drinkCaffPer.text = drink.mgCaffeinePerVolume.cleanValue
    self.selectedIcon = drink.imageName!
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
}
