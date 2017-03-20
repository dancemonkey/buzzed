//
//  CustomDrinkListVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/16/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit
import CoreData

class CustomDrinkListVC: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var topNav: TopNav!
  
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
    topNav.configure(title: "Custom drinks")
    do {
      try fetchedResultsController.performFetch()
      customDrinks = fetchedResultsController.fetchedObjects
    } catch {
      print("didn't fetch no custom drinks")
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func backPressed(withSender: UIButton) {
    _ = navigationController?.popViewController(animated: true)
  }
  
  // FRC Methods
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
  }
  
  // MARK: TableView methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchedResultsController.fetchedObjects?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "customDrinkCell") as? CustomDrinkCell else {
      return CustomDrinkCell()
    }
    
    cell.config(withDrink: fetchedResultsController.fetchedObjects![indexPath.row])
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "editCustomDrink", sender: indexPath)
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "editCustomDrink" {
      if let dest = segue.destination as? CustomDrinkBuildVC {
        dest.existingDrink = fetchedResultsController.fetchedObjects![(sender as! IndexPath).row]
      }
    }
  }
  
}
