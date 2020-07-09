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
        editButton.title = myTableView.isEditing ? "編輯" : "完成" //簡化下面寫法
//        if myTableView.isEditing {
//            myTableView.setEditing(false, animated: true)
//            editButton.title = "編輯"
//        }else {
//            myTableView.setEditing(true, animated: true)
//            editButton.title = "完成"
//        }
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
        print(alarms[index].isOn)
    }
    
    //MARK: Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dist = segue.destination as! UINavigationController
        if (segue.identifier == "addAlarm") {
            let addVC = dist.topViewController as! AddAlarmViewController
            self.addVC = addVC
            addVC.alarmVC = self
            addVC.delegate = self
            if myTableView.isEditing{
                addVC.mode = .edit
                addVC.tempAlarm = savedAlarm
            }else {
                addVC.mode = .add
            }
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
        //MARK: 這邊放去cell那邊
        //這裡可以寫去cell那邊 寫一個func
        
        let alarm = alarms[indexPath.row]
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
        onOfSwitch.isOn = alarms[indexPath.row].isOn
        onOfSwitch.tag = indexPath.row
        onOfSwitch.addTarget(self, action: #selector(switchOnOff(_:)), for: .valueChanged)
        myCell.editingAccessoryType = .disclosureIndicator
        myCell.selectionStyle = .none
        myCell.myTitle.textColor = alarms[indexPath.row].isOn ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        myCell.label.textColor = alarms[indexPath.row].isOn ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)

//        myCell.update(by: alarm)
        
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
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        editButton.title = "完成"
    }
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        editButton.title = "編輯"
    }
    //MARK: Didselect
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if myTableView.isEditing  {
            popAddAlarm()
            //
            savedAlarm = alarms[indexPath.row]
            addVC.tempAlarm = savedAlarm
            addVC.indexPath = indexPath.row

            
            myTableView.isEditing = false
            editButton.title = "編輯"
        }
    }
}
//MARK: - Protocol

//MARK: 第二頁傳值過來
extension AlarmViewController : AlarmSetDelegate {
    func setAlarm(alarm: Alarm?) {
         
    }
    
    //第一次傳過來
    func alarmSetting(time: String?, label: String?,  repeatDate:String?, isOn: Bool ,array:[Bool]) {
        let newAlarm = Alarm(time: time!, label: label, repeatdate: repeatDate, repeatArray: array, isOn: true)
            alarms.append(newAlarm)
            let index = IndexPath(row: self.alarms.count - 1, section: 0) //這個要改 順序不對
            self.myTableView.insertRows(at: [index], with: .automatic)
    }
    //編輯過後的
    func valueChanged(array: Alarm?, index: Int) {
            alarms[index] = array!
        myTableView.reloadData()
        print(alarms)
    }
}
