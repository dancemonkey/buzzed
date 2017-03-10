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
    initialSetup()
    let dm = DataManager()
    dm.decay()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func initialSetup() {
    _ = ColorGradient(withView: self.view)
    topNav.configure(title: "")
  }
  
  @IBAction func newDrinkPressed(sender: NewDrinkBtn) {
    presentNewDrinkOptions()
  }
  
  private func presentNewDrinkOptions() {
    // TODO: final form - buttons without values will not show up.
    // if no favorite or last drink, tapping goes straight to drink picker
    
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let dm = DataManager()
    
    var favTitle: String = "No favorite selected"
    if let favorite = dm.getFavoriteDrink() {
      favTitle = favorite.sourceName
    }
    let defaultDrink = UIAlertAction(title: favTitle, style: .default) { (action) in
      self.performSegue(withIdentifier: "drinkSelect", sender: self)
    }
    
    var lastTitle: String = "No prior drinks"
    if let lastDrink = dm.fetchLastDrink() {
      lastTitle = "\(lastDrink.sourceName) - \(lastDrink.volume) \(dm.getDefaultUnits().symbol)"
    }
    let lastDrink = UIAlertAction(title: lastTitle, style: .default) { (action) in
      print("picking last drink")
    }
    
    // TODO: goes to drink picker
    let choose = UIAlertAction(title: "Choose...", style: .default) { (action) in
      print("choosing another drink")
    }
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(defaultDrink)
    alert.addAction(lastDrink)
    alert.addAction(choose)
    alert.addAction(cancel)
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func donePressed(sender: SystemBtn) {
    // TODO: dismiss consumed drink differently than canceled drink
    
    if let drink = consumptionControls.source {
      let dm = DataManager()
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
