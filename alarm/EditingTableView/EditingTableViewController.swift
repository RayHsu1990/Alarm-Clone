//
//  EditingTableViewController.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/25.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import UIKit

class EditingTableViewController: UITableViewController {
    var delegate:CellPressedDelegate?
    
    var label: String?
//    var computedLabel:String {
//        get {
//            return label ?? ""
//        } set {
//            self.alarmName.text = newValue
//        }
//    }
    
    @IBOutlet weak var editingTableView: UITableView!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var alarmName: UILabel!
    @IBOutlet weak var toneLabel: UILabel!
    
    @IBOutlet weak var reminderSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmName.text = label
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 4
        }else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                break;
            case 1:
//                let vc = storyboard?.instantiateViewController(withIdentifier: "labelVC")
//                show(vc!, sender: self)
    //          delegate?.goNextPage(destination:"labelPageSegue")
              delegate?.goNextPage(destination: "labelPageSegue")
            default:
                break
            }
        default:
            break
        }
    }

}



