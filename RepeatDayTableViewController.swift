//
//  RepeatDayTableViewController.swift
//  alarm
//
//  Created by Ray Hsu on 2020/7/2.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import UIKit

class RepeatDayTableViewController: UITableViewController {
    var delegate: RepeatDaysSetDelegate?
    
    var dayOfWeek = ["星期日", "星期一", "星期二", "星期三","星期四", "星期五", "星期六"]
    var isSlected = [Bool]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        isSlected = Array(repeating: false, count: dayOfWeek.count)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayOfWeek.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dayOfWeek[indexPath.row]
        if isSlected[indexPath.row] {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isSlected[indexPath.row] = !isSlected[indexPath.row]
        tableView.reloadData()
    }
    





}
