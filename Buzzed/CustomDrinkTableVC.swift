//
//  CustomDrinkTableVC.swift
//  Buzzed
//
//  Created by Drew Lanning on 3/15/17.
//  Copyright © 2017 Drew Lanning. All rights reserved.
//

import UIKit

class CustomDrinkTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      print("loaded")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
}
