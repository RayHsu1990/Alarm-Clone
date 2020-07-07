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
    
    let dayOfWeek = ["星期日", "星期一", "星期二", "星期三","星期四", "星期五", "星期六"]
    var secDayOfWeek = ["週日", "週一", "週二", "週三", "週四", "週五", "週六"]
    var selected = [Bool]()
    var isSelected = [Bool]()
    var repeatDays: String!
    var mode = EditMode.Add

    override func viewDidLoad() {
        super.viewDidLoad()
        switch mode {
        case .Add:
            isSelected = Array(repeating: false, count: dayOfWeek.count)
        case .Edit:
            isSelected = selected
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        var repeatString : String {
            if isSelected == Array(repeating: true, count: 7) {
                return "每天"
            }else if isSelected == Array(repeating: false, count: 7) {
                return "永不"
            }else if isSelected == [true, false, false, false, false, false, true] {
                return "週末"
            }else if isSelected == [false, true, true, true, true, true, false] {
                return "平日"
            }else {
                var repeatString = ""
                for i in isSelected.enumerated() {
                    if isSelected[i.offset]{
                        repeatString = repeatString + " " + secDayOfWeek[i.offset]
                    }
                }
                return repeatString
            }
        }
        delegate?.repeatDaysSet(dayOfWeek: repeatString, array: isSelected)
        print(repeatString)
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
        if isSelected[indexPath.row] {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isSelected[indexPath.row] = !isSelected[indexPath.row]
        print(dayOfWeek[indexPath.row])
        tableView.reloadData()
    }
    




}
