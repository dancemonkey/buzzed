//
//  CurrentDrinkVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/2/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

enum ScreenMode {
  case drinking, notDrinking
}

class CurrentDrinkVC: UIViewController, DrinkSelectDelegate {
  
  @IBOutlet weak var topNav: TopNav!
  @IBOutlet weak var newDrinkBtn: NewDrinkBtn!
  @IBOutlet weak var buttonStack: HideableStack!
  @IBOutlet weak var consumptionControls: ConsumptionSetView!
  
  var currentSource: CaffeineSource? = nil
  var mode: ScreenMode = .notDrinking {
    willSet(newValue) {
      if newValue == .drinking {
        UIView.animate(withDuration: 1.0, animations: {
          self.newDrinkBtn.hide()
          self.buttonStack.unHide()
          self.consumptionControls.unHide()
        })
      } else {
        UIView.animate(withDuration: 1.0, animations: {
          self.newDrinkBtn.unHide()
          self.buttonStack.hide()
          self.consumptionControls.hide()
        })
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    initialSetup()
  }
  
  @IBAction func tempDeleteAllDataPressed(sender: UIButton) {
    let dm = DataManager()
    _ = dm.clearAllHistory()
    dm.clearUserDefaults()
  }
  
  func initialSetup() {
    _ = ColorGradient(withView: self.view)
    topNav.configure(title: "")
  }
  
  @IBAction func newDrinkPressed(sender: NewDrinkBtn) {
    presentNewDrinkOptions()
  }
  
  private func presentNewDrinkOptions() {
    
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let dm = DataManager()
    
    let favoriteDrinkAction = getFavoriteDrinkAction(fromDrink: dm.getFavoriteDrink())
    
    let lastDrinkAction = getLastDrinkAction(fromDrink: dm.fetchLastDrink())
    
    let choose = UIAlertAction(title: "Choose a drink...", style: .default) { (action) in
      self.performSegue(withIdentifier: "drinkSelect", sender: self)
    }
    
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(favoriteDrinkAction)
    alert.addAction(lastDrinkAction)
    alert.addAction(choose)
    alert.addAction(cancel)
    present(alert, animated: true, completion: nil)
  }
  
  private func getLastDrinkAction(fromDrink drink: CaffeineSource?) -> UIAlertAction {
    guard drink != nil else {
      return UIAlertAction(title: "No recent drinks", style: .default, handler: nil)
    }
    let dm = DataManager()
    let title = "Recent: \(drink!.sourceName) - \(drink!.volume) \(dm.getDefaultUnits().symbol)"
    return UIAlertAction(title: title, style: .default, handler: { (action) in
      let source = CaffeineSource(type: drink!.sourceType, volume: drink!.volume)
      self.setSelected(drink: source)
    })
  }
  
  private func getFavoriteDrinkAction(fromDrink drink: CaffeineSource?) -> UIAlertAction {
    guard drink != nil else {
      return UIAlertAction(title: "No favorite drinks", style: .default, handler: nil)
    }
    let dm = DataManager()
    return UIAlertAction(title: "Favorite: \(drink!.sourceName) - \(drink!.volume) \(dm.getDefaultUnits().symbol)", style: .default, handler: { (action) in
      let source = CaffeineSource(type: drink!.sourceType, volume: drink!.volume)
      self.setSelected(drink: source)
    })
  }
  
  @IBAction func donePressed(sender: SystemBtn) {
    // TODO: dismiss consumed drink differently than canceled drink
    
    if let drink = consumptionControls.source {
      let dm = DataManager()
      let hm = HealthManager()
      hm.storeSample(fromDrink: drink)
      _ = drink.createEntity(fromSource: drink)
      dm.save()
      
      dm.setCurrentCaff(to: dm.getCurrentCaff() + drink.totalCaffeineConsumed())
      topNav.configure(title: "")
    }
    mode = .notDrinking
    
  }
  
  @IBAction func cancelPressed(sender: SystemBtn) {
    mode = .notDrinking
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let dest = segue.destination as? DrinkSelectVC {
      dest.passThroughDelegate = self
    }
  }
  
}
