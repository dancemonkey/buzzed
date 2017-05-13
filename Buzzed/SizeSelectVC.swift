//
//  SizeSelectVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/9/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class SizeSelectVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var topNav: TopNav!
  
  var drinkType: CaffeineSourceType?
  var sizes = [Double]()
  weak var delegate: DrinkSelectDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let dm = DataManager()
    if let sizes = drinkType?.getSize(inVolumeUnit: dm.getDefaultUnits()) {
      self.sizes = sizes
    }
    topNav.configure(title: "Select a size")
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func backPressed(_ sender: SystemBtn) {
    _ = navigationController?.popViewController(animated: true)
  }
  
  // MARK: Tableview methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sizes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sizeSelectCell") as? SizeSelectCell else {
      return SizeSelectCell()
    }
    
    cell.configure(withType: drinkType!, andSize: sizes[indexPath.row])
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let source = CaffeineSource(type: drinkType!, volume: sizes[indexPath.row])
    if let delegate = self.delegate as? CurrentDrinkVC {
      delegate.setSelected(source)
    } else if let delegate = self.delegate as? SettingsTableVC {
      delegate.setFavorite(source)
    }
    _ = navigationController?.popToRootViewController(animated: true)
  }
  
}
