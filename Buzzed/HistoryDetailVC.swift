//
//  HIstoryDetailVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/20/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit
import CoreData

class HistoryDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var topNav: TopNav!
  @IBOutlet weak var tableView: UITableView!
  
  var drinksByDate: [CaffeineSourceCD]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let date = drinksByDate[0].creation as? Date {
      topNav.configure(title: "History for \(extractDate(from: date))")
    }
  }
  
  @IBAction func backPressed(sender: UIButton) {
    _ = navigationController?.popViewController(animated: true)
  }
  
  func extractDate(from date: Date) -> String {
    let cal = Calendar.current
    let month = cal.component(.month, from: date)
    let day = cal.component(.day, from: date)
    return "\(month)-\(day)"
  }
  
  // MARK: Tableview methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let drinks = drinksByDate else {
      return 0
    }
    return drinks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "historyDetailCell") as? HistoryDetailCell else {
      return HistoryDetailCell()
    }
    cell.configCell(with: drinksByDate[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let dm = DataManager()
      let drinkToRemove = drinksByDate[indexPath.row]
      dm.context.delete(drinkToRemove)
      drinksByDate.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      dm.save()
      
      // TODO: must also delete record from HealthKit?
      // TODO: must also remove caffeine from total
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
