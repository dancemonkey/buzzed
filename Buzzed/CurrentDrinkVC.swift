//
//  CurrentDrinkVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/2/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit
import Toast_Swift

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
  var style = ToastStyle()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let hm = HealthManager()
    hm.authorizeHealthkit { (success, error) in }
    
    style.messageColor = Constants.Color.accentSuccess.bground()
    ToastManager.shared.tapToDismissEnabled = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    initialSetup()
  }
  
  func initialSetup() {
    _ = ColorGradient(withView: self.view)
    topNav.configure(title: "")
  }
  
  @IBAction func newDrinkPressed(_ sender: NewDrinkBtn) {
    presentNewDrinkOptions()
  }
  
  fileprivate func presentNewDrinkOptions() {
    
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
  
  fileprivate func getLastDrinkAction(fromDrink drink: CaffeineSource?) -> UIAlertAction {
    guard drink != nil else {
      return UIAlertAction(title: "No recent drinks", style: .default, handler: nil)
    }
    let dm = DataManager()
    let title = "Recent: \(drink!.sourceName) - \(drink!.volume) \(dm.getDefaultUnits().symbol)"
    return UIAlertAction(title: title, style: .default, handler: { (action) in
      let source = CaffeineSource(type: drink!.sourceType, volume: drink!.volume)
      self.setSelected(source)
    })
  }
  
  fileprivate func getFavoriteDrinkAction(fromDrink drink: CaffeineSource?) -> UIAlertAction {
    guard drink != nil else {
      return UIAlertAction(title: "No favorite drinks", style: .default, handler: nil)
    }
    let dm = DataManager()
    return UIAlertAction(title: "Favorite: \(drink!.sourceName) - \(drink!.volume) \(dm.getDefaultUnits().symbol)", style: .default, handler: { (action) in
      let source = CaffeineSource(type: drink!.sourceType, volume: drink!.volume)
      self.setSelected(source)
    })
  }
  
  @IBAction func donePressed(_ sender: SystemBtn) {
    // TODO: dismiss consumed drink differently than canceled drink
    
    if let drink = consumptionControls.source {
      let dm = DataManager()
      let hm = HealthManager()
      let drinkEntity = drink.createEntity(fromSource: drink)
      hm.storeSample(fromDrink: drinkEntity)
      dm.save()
      
      dm.setCurrentCaff(to: dm.getCurrentCaff() + drink.totalCaffeineConsumed())
      topNav.configure(title: "")
    }
    mode = .notDrinking
    
    self.view.makeToast("Saved!", duration: 2.0, position: .bottom, style: style)
  }
  
  @IBAction func cancelPressed(_ sender: SystemBtn) {
    mode = .notDrinking
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let dest = segue.destination as? DrinkSelectVC {
      dest.passThroughDelegate = self
    }
  }
  
}
