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
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var viewTitle: UILabel!
  @IBOutlet weak var topNav: TopNav!
  
  weak var passThroughDelegate: DrinkSelectDelegate?
  
  let sections = ["Custom drinks", "Standard drinks"]
  var customDrinks: [CustomDrink]?
  
  private lazy var fetchedResultsController: NSFetchedResultsController<CustomDrink> = {
    let dm = DataManager()
    let fetchReq: NSFetchRequest<CustomDrink> = CustomDrink.fetchRequest()
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
  }
  
  @IBAction func backPressed(sender: SystemBtn) {
    _ = navigationController?.popViewController(animated: true)
  }
  
  // MARK: Tableview methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.sections[section]
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      if let drinks = customDrinks {
        return drinks.count
      } else {
        return 0
      }
    case 1:
      return DataManager().fetchDrinkTypes().count
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "drinkSelectCell") as? DrinkSelectCell else {
      return UITableViewCell()
    }
    switch indexPath.section {
    case 0:
      // configure custom drink cell
    case 1:
      cell.configure(with: DataManager().fetchDrinkTypes()[indexPath.row])
    default:
      
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "sizeSelect", sender: indexPath)
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let dest = segue.destination as? SizeSelectVC {
      dest.drinkType = DataManager().fetchDrinkTypes()[(sender as! IndexPath).row]
      dest.delegate = passThroughDelegate
    }
  }
  
}
