//
//  CurrentDrinkVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/2/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class CurrentDrinkVC: UIViewController {
  
  @IBOutlet weak var topNav: TopNav!
  @IBOutlet weak var newDrinkBtn: NewDrinkBtn!
  
  var currentSource: CaffeineSource? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialSetup()
    // Do any additional setup after loading the view.
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
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let defaultDrink = UIAlertAction(title: "Default", style: .default) { (action) in
      print("picking default drink")
    }
    let lastDrink = UIAlertAction(title: "Last drink", style: .default) { (action) in
      print("picking last drink")
    }
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