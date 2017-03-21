//
//  HistoryVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/13/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit
import CoreData

class HistoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var topNav: TopNav!
  
  private var selected: IndexPath? = nil {
    didSet {
      print(selected)
    }
  }
  
  private lazy var fetchedResultsController: NSFetchedResultsController<CaffeineSourceCD> = {
    let dm = DataManager()
    let fetchReq: NSFetchRequest<CaffeineSourceCD> = CaffeineSourceCD.fetchRequest()
    fetchReq.sortDescriptors = [NSSortDescriptor(key: "creation", ascending: true)]
    let frc = NSFetchedResultsController<CaffeineSourceCD>(fetchRequest: fetchReq, managedObjectContext: dm.context, sectionNameKeyPath: nil, cacheName: nil)
    return frc
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchedResultsController.delegate = self
    initialSetup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    do {
      try fetchedResultsController.performFetch()
    } catch {
      print("could not perform fetch")
    }
    tableView.reloadData()
  }
  
  func initialSetup() {
    _ = ColorGradient(withView: self.view)
    topNav.configure(title: "History")
  }
  
  func dateGroupings(from results: NSFetchedResultsController<CaffeineSourceCD>) -> [[CaffeineSourceCD]]? {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM dd yy"
    var drinksByDate = [[CaffeineSourceCD]]()
    if let drinks = results.fetchedObjects {
      var currentDrinks = [CaffeineSourceCD]()
      for drink in drinks {
        if currentDrinks.count == 0 {
          currentDrinks.append(drink)
        } else {
          if formatter.string(from: drink.creation! as Date) == formatter.string(from: currentDrinks[currentDrinks.count-1].creation! as Date) {
            currentDrinks.append(drink)
          } else {
            drinksByDate.append(currentDrinks)
            currentDrinks.removeAll()
            currentDrinks.append(drink)
          }
        }
      }
      drinksByDate.append(currentDrinks)
    }
    return drinksByDate
  }
  
  // MARK: Tableview methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let drinks = dateGroupings(from: fetchedResultsController) else {
      return 0
    }
    return drinks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as? HistoryCell else {
      return HistoryCell()
    }
    
    if let drinks = dateGroupings(from: fetchedResultsController) {
      cell.configure(withDrinks: drinks[indexPath.row])
    } else {
      cell.textLabel?.text = "No date temp label"
      cell.hideDrinkStacks()
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "historyToDetail", sender: indexPath)
    self.selected = indexPath
  }
  
  func configure(cell: HistoryCell, at indexPath: IndexPath) {
    let drinksByDate = dateGroupings(from: fetchedResultsController)
    cell.configure(withDrinks: drinksByDate![indexPath.row])
  }
  
  // MARK: NS FRC methods
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .update:
      print("updating")
    case .insert:
      print("inserting")
    case .delete:
      print("deleting")
      // working the first time only?
      if dateGroupings(from: fetchedResultsController)![selected!.row].isEmpty {
        tableView.deleteRows(at: [selected!], with: .fade)
      } else {
        tableView.reloadRows(at: [selected!], with: .fade)
      }
    case .move:
      print("moving")
    }
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "historyToDetail" {
      if let dest = segue.destination as? HistoryDetailVC {
        dest.drinksByDate = dateGroupings(from: fetchedResultsController)![(sender as! IndexPath).row]
      }
    }
  }
  
}
