//
//  DrinkSelectVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/9/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class DrinkSelectVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var viewTitle: UILabel!
  @IBOutlet weak var topNav: TopNav!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    topNav.configure(title: "Select a drink")
    // Do any additional setup after loading the view.
  }
  
  @IBAction func backPressed(sender: SystemBtn) {
    _ = navigationController?.popViewController(animated: true)
  }
  
  // MARK: Tableview methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "drinkSelectCell") as? DrinkSelectCell else {
      return UITableViewCell()
    }
    // TODO: pull values from array of all coffee types
    // TODO: configure cell so tapping takes you to size select screen
    
    cell.configure(with: .dripCoffee)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "sizeSelect", sender: self)
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let dest = segue.destination as? SizeSelectVC {
      // TODO: implement all other drink types and select based on tapped cell
      dest.drinkType = .dripCoffee
    }
  }
  
}
