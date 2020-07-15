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
    
    var alarms = [Alarm](){
        didSet {
            save()
        }
    }
    var addVC : AddAlarmViewController!
//    var mode : EditMode!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var myTableView: UITableView!
    
    //MARK: - Life
    override func viewDidLoad() {
        registerCell()
        //cell 產生才出現separator
        myTableView.tableFooterView = UIView(frame: CGRect.zero)
        alarms = load()
    }
    
    //MARK: IBAction
    @IBAction func newButton(_ sender: UIBarButtonItem) {
        popAddAlarm()
        addVC.mode = .add
    }
    #warning("要怎麼改")
    @IBAction func editButton(_ sender: UIBarButtonItem) {
//        myTableView.isEditing.toggle()
//        editButton.title = myTableView.isEditing ? "完成" : "編輯"
        if myTableView.isEditing == false{
            myTableView.setEditing(true, animated: true)
            editButton.title = "完成"
        }else {
            myTableView.setEditing(false, animated: true)
            editButton.title = "編輯"
        }
    }
    
    //MARK: Func
    func popAddAlarm() {
        performSegue(withIdentifier: "addAlarm", sender: nil)
        
        #warning("改成這樣")
//        let vc = ViewController()
//        vc.alarmList = []
//        self.present(vc, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//        let vc = AddAlarmViewController(
    }

    func save(){
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(alarms)
            UserDefaults.standard.set(data, forKey: "alarmsKey")
        } catch {
            print("Save error")
        }
    }
    
    func load() -> [Alarm]{
        guard let data = UserDefaults.standard.data(forKey: "alarmsKey") else {
            return [Alarm]()
        }
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode([Alarm].self, from: data)
            alarms = decoded
            myTableView.reloadData()
        } catch {
            print("Load error")
        }
        return alarms
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
        myTableView.reloadRows(at: [[0, index]], with: .none)
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
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    //MARK: Didselect
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if myTableView.isEditing  {
            popAddAlarm()
            addVC.tempAlarm = alarms[indexPath.row]
            addVC.indexPath = indexPath.row
            addVC.mode = .edit
        }
        myTableView.isEditing = false
        editButton.title = "編輯"
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        editButton.title = "完成"
    }

    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        editButton.title = "編輯"
    }
}
//MARK: - Protocol

//MARK: 第二頁傳值過來
extension AlarmViewController : AlarmSetDelegate {
    func setAlarm(alarm: Alarm) {
        alarms.append(alarm)
        alarms.sort { (alarm1, alarm2) -> Bool in
            return alarm1.time < alarm2.time
        }
        myTableView.reloadData()
    }
    //編輯過後的
    func valueChanged(array: Alarm, index: Int) {
        alarms[index] = array
        alarms.sort { (alarm1, alarm2) -> Bool in
            return alarm1.time < alarm2.time
        }
        myTableView.reloadData()
    }
}

