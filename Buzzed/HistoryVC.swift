//
//  HistoryVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/13/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit
import CoreData

class HistoryVC: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var topNav: TopNav!
  
  private lazy var fetchedResultsController: NSFetchedResultsController<CaffeineSourceCD> = {
    let dm = DataManager()
    let fetchReq: NSFetchRequest<CaffeineSourceCD> = CaffeineSourceCD.fetchRequest()
    fetchReq.sortDescriptors = [NSSortDescriptor(key: "creation", ascending: true)]
    let frc = NSFetchedResultsController<CaffeineSourceCD>(fetchRequest: fetchReq, managedObjectContext: dm.context, sectionNameKeyPath: nil, cacheName: nil)
    frc.delegate = self
    return frc
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    do {
      try fetchedResultsController.performFetch()
      initialSetup()
    } catch {
      print("could not perform fetch")
    }
  }
  
  func initialSetup() {
    _ = ColorGradient(withView: self.view)
    topNav.configure(title: "History")
    // create arrays that will be used in tableView
    print(makeDateGroupings())
  }
  
  func makeDateGroupings() -> [[CaffeineSourceCD]] {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM dd yy"
    var drinksByDate = [[CaffeineSourceCD]]()
    if let drinks = fetchedResultsController.fetchedObjects {
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
    guard let drinks = fetchedResultsController.fetchedObjects else {
      return 0
    }
    return drinks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as? HistoryCell else {
      return HistoryCell()
    }
    
    var drinks = [CaffeineSourceCD]()
    let drink = fetchedResultsController.object(at: indexPath)
    if indexPath.item == 0 {
      drinks.append(drink)
      cell.configure(withDrinks: drinks)
    }
    
    return cell
    
  }
  
  // MARK: NS FRC Methods
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      if let indexPath = newIndexPath {
        tableView.insertRows(at: [indexPath], with: .fade)
      }
      break
    default:
      break
    }
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
