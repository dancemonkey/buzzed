//
//  HistoryVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/13/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit
import CoreData
import Toast_Swift

class HistoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var topNav: TopNav!
  @IBOutlet weak var emptyHistoryLbl: UILabel!
  
  var style = ToastStyle()
  
  fileprivate lazy var fetchedResultsController: NSFetchedResultsController<CaffeineSourceCD> = {
    let dm = DataManager()
    let priorMonthToDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
    let predicate = NSPredicate(format: "creation >= %@", priorMonthToDate! as CVarArg)
    let fetchReq: NSFetchRequest<CaffeineSourceCD> = CaffeineSourceCD.fetchRequest() as! NSFetchRequest<CaffeineSourceCD>
    fetchReq.sortDescriptors = [NSSortDescriptor(key: "creation", ascending: false)]
    fetchReq.predicate = predicate
    let frc = NSFetchedResultsController<CaffeineSourceCD>(fetchRequest: fetchReq, managedObjectContext: dm.context, sectionNameKeyPath: #keyPath(CaffeineSourceCD.sectionNameFromDate), cacheName: nil)
    return frc
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchedResultsController.delegate = self
    initialSetup()
    tableView.sectionHeaderHeight = 32.0
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    do {
      try fetchedResultsController.performFetch()
    } catch {
      print("could not perform fetch")
    }
    tableView.reloadData()
    topNav.configure(title: "History")
  }
  
  func initialSetup() {
    _ = ColorGradient(withView: self.view)
    style.messageColor = Constants.Color.accentError.bground()
  }
  
  func configure(_ cell: HistoryDetailCell, at indexPath: IndexPath) {
    let drink = fetchedResultsController.object(at: indexPath)
    cell.configCell(with: drink)
  }
  
  // MARK: Tableview methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    guard let count = fetchedResultsController.sections?.count else {
      return 0
    }
    if count == 0 {
      emptyHistoryLbl.isHidden = false
    } else {
      emptyHistoryLbl.isHidden = true
    }
    return count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let sectionInfo = fetchedResultsController.sections?[section] else {
      fatalError("unexpected section")
    }
    
    return sectionInfo.numberOfObjects
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let sectionInfo = fetchedResultsController.sections?[section] else {
      fatalError("Unexpected Section")
    }
    
    let totalCaffForSection = fetchedResultsController.fetchedObjects?.reduce(0, { (result, source) -> Double in
      if source.sectionNameFromDate == sectionInfo.name {
        return result + source.totalMgConsumed()
      }
      return result
    }).roundTo(2)
    
    let vw = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 32))
    vw.backgroundColor = Constants.Color.doneBtn.bground()
    let lbl = UILabel(frame: CGRect(x: 20, y: 0, width: vw.frame.size.width, height: 32))
    lbl.text = sectionInfo.name + " - \(totalCaffForSection!)mg"
    lbl.textColor = .white
    vw.addSubview(lbl)
    return vw
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let sectionInfo = fetchedResultsController.sections?[section] else {
      fatalError("Unexpected Section")
    }
    
    let totalCaffForSection = fetchedResultsController.fetchedObjects?.reduce(0, { (result, source) -> Double in
      if source.sectionNameFromDate == sectionInfo.name {
        return result + source.totalMgConsumed()
      }
      return result
    }).roundTo(2)
    
    return sectionInfo.name + " - \(totalCaffForSection!)mg"
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "historyDetailCell") as? HistoryDetailCell else {
      return HistoryCell()
    }
    
    configure(cell, at: indexPath)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let dm = DataManager()
      let record = fetchedResultsController.object(at: indexPath)
      let uuidToDelete = record.hkUUID
      let hm = HealthManager()
      hm.deleteSample(withUUID: uuidToDelete)
      dm.context.delete(record)
      if Calendar.current.isDateInToday(record.creation!) {
        dm.reduceCaffeineBy(caffReduction: record.totalMgConsumed())
      }
      dm.save()
      self.view.makeToast("Deleted", duration: 2.0, position: .bottom, style: style)
    }
  }
  
  // MARK: NS FRC methods
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    switch type {
    case .insert:
      tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
    case .delete:
      tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
    default:
      break
    }
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .update:
      print("updating")
    case .insert:
      tableView.insertRows(at: [newIndexPath!], with: .fade)
    case .delete:
      tableView.deleteRows(at: [indexPath!], with: .fade)
      print("deleting")
    case .move:
      print("moving")
    }
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
  }
  
}
