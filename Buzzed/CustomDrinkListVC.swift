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
  @IBOutlet weak var createCustomBtn: SystemBtn!
  
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
    fetchedResultsController.delegate = self
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
  
  @IBAction func backPressed(_ withSender: UIButton) {
    _ = navigationController?.popViewController(animated: true)
  }
  
  @IBAction func createDrinkPressed(sender: UIButton) {
    performSegue(withIdentifier: "editCustomDrink", sender: nil)
  }
  
  func configure(_ cell: CustomDrinkCell, at indexPath: IndexPath) {
    let drink = fetchedResultsController.object(at: indexPath)
    cell.config(withDrink: drink)
  }
  
  // FRC Methods
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      if let indexPath = newIndexPath {
        tableView.insertRows(at: [indexPath], with: .fade)
      }
      break
    case .delete:
      print("case delete")
      if let indexPath = indexPath {
        print("found indexPath and deleting")
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
      break
    case .update:
      if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? CustomDrinkCell {
        configure(cell, at: indexPath)
      }
      break
    default:
      print("whoops")
    }
  }
  
  // MARK: TableView methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    if (fetchedResultsController.fetchedObjects?.isEmpty)! {
      createCustomBtn.isHidden = false
    } else {
      createCustomBtn.isHidden = true
    }
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = fetchedResultsController.fetchedObjects?.count {
      return count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "customDrinkCell") as? CustomDrinkCell else {
      return CustomDrinkCell()
    }
    
    configure(cell, at: indexPath)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "editCustomDrink", sender: indexPath)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let drink = fetchedResultsController.object(at: indexPath)
      let dm = DataManager()
      dm.context.delete(drink)
      dm.save()
    }
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "editCustomDrink" {
      if let dest = segue.destination as? CustomDrinkBuildVC {
        if let indexPath = sender as? IndexPath {
          dest.existingDrink = fetchedResultsController.fetchedObjects![indexPath.row]
        } else {
          dest.existingDrink = nil
        }
      }
    }
  }
  
}
