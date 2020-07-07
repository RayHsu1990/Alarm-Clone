//
//  ViewController.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/25.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var alarmList = [AlarmModel]()
    var savedAlarm : AlarmModel?
    var addVC : AddAlarmViewController!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        myTableView.allowsSelectionDuringEditing = true
        let nib = UINib(nibName: "MainPageTableViewCell", bundle: nil)
        self.myTableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func newButton(_ sender: UIBarButtonItem) {
        popAddAlarm()
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        
        if myTableView.isEditing {
            myTableView.setEditing(false, animated: true)
            editButton.title = "編輯"
        }else {
            myTableView.setEditing(true, animated: true)
            editButton.title = "完成"
        }
    }
    
    func popAddAlarm() {
        performSegue(withIdentifier: "addAlarm", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dist = segue.destination as! UINavigationController
        if (segue.identifier == "addAlarm") {
            let addVC = dist.topViewController as! AddAlarmViewController
            self.addVC = addVC
                addVC.delegate = self
            
            if myTableView.isEditing{
                addVC.mode = .Edit
                addVC.tempAlarm = savedAlarm
            }else {
                addVC.mode = .Add
            }
        }
    }
}

//MARK: - Tableview

extension ViewController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = myTableView .dequeueReusableCell(withIdentifier: "cell" , for:indexPath) as! MainPageTableViewCell
        let alarm = alarmList[indexPath.row]
        myCell.myTitle.text = alarm.time
        //
        if alarm.repeatdate == "永不" {
            myCell.label.text = alarm.label
        }else {
            myCell.label.text = alarm.label! + "," + alarm.repeatdate!
        }
        //
        let onOfSwitch = UISwitch()
        myCell.accessoryView = onOfSwitch
        onOfSwitch.isOn = true
        myCell.editingAccessoryType = .disclosureIndicator
        myCell.selectionStyle = .none
        return myCell
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alarmList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        editButton.title = "完成"
        editButton.style = .done
    }
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        editButton.title = "編輯"
        editButton.style = .plain
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if myTableView.isEditing  {
            popAddAlarm()
            //
            savedAlarm = alarmList[indexPath.row]
            addVC.tempAlarm = savedAlarm
        }
    }
}

extension ViewController : AlarmSetDelegate {
    func alarmSetting(time: String?, label: String?,  repeatDate:String?) {
        if let time = time, let label = label, let repeatDate = repeatDate {
            let newAlarm = AlarmModel(time: time, label: label, repeatdate: repeatDate, isOn: true)
            alarmList.append(newAlarm)
            let newTex = IndexPath(row: self.alarmList.count - 1, section: 0)
            self.myTableView.insertRows(at: [newTex], with: .automatic)
        }


        
    }
    
    
}
