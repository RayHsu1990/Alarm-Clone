//
//  AddAlarmViewController.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/25.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import UIKit



class AddAlarmViewController: UIViewController {
    #warning("可以替代prepare")
    static func make(mode: EditMode) -> AddAlarmViewController {
        let vc = AddAlarmViewController()
        return vc
    }
    
    var alarmVC: AlarmViewController!
    var editTVC: EditingTableViewController!
    var delegate: AlarmSetDelegate?
    var tempAlarm: Alarm?
    var array : [Bool]!
//    var okTime:String?
//    var alarmLabel:String = "鬧鐘"
//    var repeatDate:String = "永不"
    var mode: EditMode = .add
    var indexPath: Int?
    
    @IBOutlet weak var myTimePicker: UIDatePicker! 
    @IBOutlet weak var myContainView: UIView!


    
    // MARK: - Life

    
    override func viewDidLoad() {
        super.viewDidLoad()
        modeChoose()
        pickTime()
        timePickerSetting()
    }

    //MARK: - IBAction
    
    @IBAction func timePicker(_ sender: UIDatePicker) {
        pickTime()
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: 按下儲存鍵
    @IBAction func clickSaveButton(_ sender: UIBarButtonItem) {
        switch mode {
        case .add:
        delegate?.setAlarm(alarm: tempAlarm)
        case .edit:
            if let indexPath = indexPath {
                delegate?.valueChanged(array: tempAlarm, index: indexPath)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Func
    fileprivate func modeChoose() {
        navigationItem.title = mode.title
        switch mode {
        case .add:
            array = Array(repeating: false, count: 7)
            tempAlarm = Alarm(label: "鬧鐘", repeatdate: "永不", repeatArray: array)
            editTVC.alarmName.text = tempAlarm?.label
            editTVC.repeatLabel.text = tempAlarm?.repeatdate
            editTVC.mode = .add
        case .edit:
            editTVC.alarmName.text = tempAlarm?.label
            editTVC.repeatLabel.text = tempAlarm?.repeatdate
            editTVC.mode = .edit
            pick()
        }
    }
    func pickTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        formatter.timeStyle = .short
        tempAlarm?.time = formatter.string(from:myTimePicker.date)
        }
    #warning("這邊要改")
    func pick(){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        formatter.timeStyle = .short
        if let date = formatter.date(from: tempAlarm?.time ?? "") {
            myTimePicker.setDate(date, animated: true)
        }
        }
    
    func timePickerSetting(){
        myTimePicker.setValue(UIColor.white, forKey: "textColor")
        myTimePicker.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    //MARK: prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.destination {
//        case let editTVC as EditingTableViewController:
//            editTVC.
//        default:
//        }
        switch segue.identifier {
        case "editTableVCSegue":
            let editTableView = segue.destination as! EditingTableViewController
                self.editTVC = editTableView
                editTVC.delegate = self
        case "labelPageSegue":
            let labelVC = segue.destination as! LabelViewController
                labelVC.delegate = self
                labelVC.label = tempAlarm?.label
        case "repeatDayPageSegue":
            let repeatVC = segue.destination as! RepeatDayTableViewController
            repeatVC.delegate = self
            repeatVC.isSelected = tempAlarm?.repeatArray as! [Bool]
        default:
            break
        }
    }
}
//MARK: - 編輯頁點cell後要做的事
extension AddAlarmViewController: CellPressedDelegate{
    func delete() {
        dismiss(animated: true, completion: nil)
        if let indexPath = indexPath {
            alarmVC.alarms.remove(at: indexPath)
            alarmVC.myTableView.reloadData()
        }
    }
    
    func goNextPage(destination:String) {
        performSegue(withIdentifier: destination, sender: nil)
    }
}
//MARK: - 標籤頁傳回來
extension AddAlarmViewController: LabelSetDelegate {
    func labelSet(label: String) {
        tempAlarm?.label = label
        self.editTVC.alarmName.text = tempAlarm?.label
    }
}
//MARK: - 重複頁傳回來
extension AddAlarmViewController: RepeatDaysSetDelegate {
    func repeatDaysSet(dayOfWeek: String, array: [Bool]) {
        tempAlarm?.repeatdate = dayOfWeek
        tempAlarm?.repeatArray = array
        self.editTVC.repeatLabel.text = tempAlarm?.repeatdate
    }
}
