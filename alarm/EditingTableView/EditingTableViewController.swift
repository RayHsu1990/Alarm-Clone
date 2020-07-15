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
    var addVC : AddAlarmViewController!
    var mode = EditMode.add
    
    @IBOutlet weak var editingTableView: UITableView!
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var alarmName: UILabel!
    @IBOutlet weak var toneLabel: UILabel!
    @IBOutlet weak var reminderSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if mode == EditMode.add {
            return 1
        }else{
            return 2
        }
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
                delegate?.goNextPage(destination:"repeatDayPageSegue")
            case 1:
              delegate?.goNextPage(destination: "labelPageSegue")
            default:
                break
            }
        case 1:
            delegate?.delete()
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: 414 , height: 30))
        footer.backgroundColor = .none
        return footer
    }

}



