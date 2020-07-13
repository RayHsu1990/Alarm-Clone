//
//  ViewController.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/25.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import UIKit



// TODO: rename
class AlarmViewController: UIViewController {
    
    var alarms = [Alarm]()
    var savedAlarm : Alarm?
    var addVC : AddAlarmViewController!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var myTableView: UITableView!
    
    //MARK: - Life
    override func viewDidLoad() {
        registerCell()
        colorSetting()
    }
    
    //MARK: IBAction
    @IBAction func newButton(_ sender: UIBarButtonItem) {
        popAddAlarm()
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        myTableView.isEditing.toggle()
        editButton.title = myTableView.isEditing ? "完成" : "編輯"

    }
    
    //MARK: Func
    func popAddAlarm() {
        performSegue(withIdentifier: "addAlarm", sender: nil)
        
//        let vc = ViewController()
//        vc.alarmList = []
//        self.present(vc, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//        let vc = AddAlarmViewController(
    }
    
    func colorSetting() {
        navigationItem.leftBarButtonItem?.tintColor = .orange
        navigationItem.rightBarButtonItem?.tintColor = .orange
        myTableView.separatorColor = .lightGray
        //cell 產生才出現separator
        myTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func registerCell() {
        myTableView.allowsSelectionDuringEditing = true
        let nibName = "MainPageTableViewCell"
        let nib = UINib(nibName: nibName, bundle: nil)
        self.myTableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    @objc func switchOnOff(_ sender: UISwitch) {
        let index = sender.tag
        alarms[index].isOn = sender.isOn ? true : false
        myTableView.reloadRows(at: [[0, index]], with: .automatic)
    }
    
    //MARK: Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dist = segue.destination as! UINavigationController
        if (segue.identifier == "addAlarm") {
            let addVC = dist.topViewController as! AddAlarmViewController
            self.addVC = addVC
            addVC.alarmVC = self
            addVC.delegate = self
        }
    }
}

//MARK: - Tableview

extension AlarmViewController:UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = myTableView .dequeueReusableCell(withIdentifier: "cell" , for:indexPath) as! MainPageTableViewCell
        let alarm = alarms[indexPath.row]
        myCell.update(by: alarm)
        //
        let onOfSwitch = UISwitch()
        myCell.accessoryView = onOfSwitch
        onOfSwitch.isOn = alarms[indexPath.row].isOn
        onOfSwitch.tag = indexPath.row
        onOfSwitch.addTarget(self, action: #selector(switchOnOff(_:)), for: .valueChanged)
        
        return myCell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alarms.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    //MARK: Didselect
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if myTableView.isEditing  {
            popAddAlarm()
            //
            addVC.tempAlarm = alarms[indexPath.row]
            addVC.indexPath = indexPath.row
            addVC.mode = .edit
            
            myTableView.isEditing = false
            editButton.title = "編輯"
        }
    }
}
//MARK: - Protocol

//MARK: 第二頁傳值過來
extension AlarmViewController : AlarmSetDelegate {
    func setAlarm(alarm: Alarm?) {
        alarms.append(alarm!)
        let index = IndexPath(row: self.alarms.count - 1, section: 0) //這個要改 順序不對
        self.myTableView.insertRows(at: [index], with: .automatic)    }
    //編輯過後的
    func valueChanged(array: Alarm?, index: Int) {
            alarms[index] = array!
        myTableView.reloadData()
        print(alarms)
    }
}
