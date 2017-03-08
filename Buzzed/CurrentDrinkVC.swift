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

class CurrentDrinkVC: UIViewController {
  
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
    topNav.meter.setLevel(to: 0)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func initialSetup() {
    _ = ColorGradient(withView: self.view)
    topNav.configure(title: "New drink")
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
      print("picking default drink")
      self.mode = .drinking
    }
    
    var lastTitle: String = "No prior drinks"
    if let lastDrink = dm.fetchLastDrink() {
      lastTitle = "\(lastDrink.sourceName) - \(lastDrink.volume) \(dm.getDefaultUnits().symbol)"
    }
    let lastDrink = UIAlertAction(title: lastTitle, style: .default) { (action) in
      print("picking last drink")
    }
    
    // TODO: goes to drink pinker
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
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
