//
//  DrinkSelectVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/9/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit
import CoreData

class DrinkSelectVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  // todo: frc methods to update custom area
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var viewTitle: UILabel!
  @IBOutlet weak var topNav: TopNav!
  
  weak var passThroughDelegate: DrinkSelectDelegate?
  
  let sections = ["Custom drinks", "Standard drinks"]
  var customDrinks: [CustomDrink]?
  
  fileprivate lazy var fetchedResultsController: NSFetchedResultsController<CustomDrink> = {
    let dm = DataManager()
    let fetchReq: NSFetchRequest<CustomDrink> = CustomDrink.fetchRequest() as! NSFetchRequest<CustomDrink>
    fetchReq.sortDescriptors = [NSSortDescriptor(key: "creation", ascending: true)]
    let frc = NSFetchedResultsController<CustomDrink>(fetchRequest: fetchReq, managedObjectContext: dm.context, sectionNameKeyPath: nil, cacheName: nil)
    return frc
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    topNav.configure(title: "Select a drink")
    do {
      try fetchedResultsController.performFetch()
      customDrinks = fetchedResultsController.fetchedObjects
    } catch {
      print("didn't fetch no custom drinks")
    }
    tableView.reloadData()
  }
  
  @IBAction func backPressed(_ sender: SystemBtn) {
    _ = navigationController?.popViewController(animated: true)
  }
  
  // MARK: Tableview methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      if fetchedResultsController.fetchedObjects != nil, fetchedResultsController.fetchedObjects!.count > 0 {
        return self.sections[section]
      } else {
        return nil
      }
    case 1:
      return self.sections[section]
    default:
      print("this should never be reached")
    }
    return nil
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return fetchedResultsController.fetchedObjects!.count
    case 1:
      return DataManager().fetchDrinkTypes().count
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.section {
    case 0:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "customDrinkCell") as? CustomDrinkCell else {
        return UITableViewCell()
      }
      cell.config(withDrink: fetchedResultsController.fetchedObjects![indexPath.row])
      return cell
    case 1:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "drinkSelectCell") as? DrinkSelectCell else {
        return UITableViewCell()
      }
      cell.configure(with: DataManager().fetchDrinkTypes()[indexPath.row])
      return cell
    default:
      return UITableViewCell()
    }
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("row selected")
    switch indexPath.section {
    case 0:
      if let delegate = self.passThroughDelegate as? CurrentDrinkVC {
        let customDrink = fetchedResultsController.fetchedObjects![indexPath.row]
        let source = CaffeineSource(type: .custom, volume: customDrink.volume)
        source.initFromCustom(customDrink)
        delegate.setSelected(source)
        _ = navigationController?.popToRootViewController(animated: true)
      } else if let delegate = self.passThroughDelegate as? SettingsTableVC {
        let customDrink = fetchedResultsController.fetchedObjects![indexPath.row]
        let source = CaffeineSource(type: .custom, volume: customDrink.volume)
        source.initFromCustom(customDrink)
        delegate.setFavorite(source)
        _ = navigationController?.popToRootViewController(animated: true)
      }
    case 1:
      performSegue(withIdentifier: "sizeSelect", sender: indexPath)
    default:
      print("this should not be happening")
    }
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let dest = segue.destination as? SizeSelectVC {
      dest.drinkType = DataManager().fetchDrinkTypes()[(sender as! IndexPath).row]
      dest.delegate = passThroughDelegate
    }
  }
  
}
