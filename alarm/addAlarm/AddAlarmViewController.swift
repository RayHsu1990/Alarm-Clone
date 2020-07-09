//
//  AddAlarmViewController.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/25.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import UIKit



class AddAlarmViewController: UIViewController {
    
    static func make(mode: EditMode) -> AddAlarmViewController {
        let vc = AddAlarmViewController()
        return vc
    }
    
    var alarmVC: AlarmViewController!
    var editTVC: EditingTableViewController!
//    var repeatTVC: RepeatDayTableViewController!
//    var labelVC: LabelViewController!
    var delegate: AlarmSetDelegate?
    var tempAlarm: Alarm?
    var changedAlarm: Alarm?
    var array : [Bool]!
    var okTime:String?
    var alarmLabel:String = "鬧鐘"
    var repeatDate:String = "永不"
    var mode: EditMode = .add //    {
//        (tempAlarm == nil) ? .add : .edit
//    }
    var indexPath: Int?
    
    @IBOutlet weak var myTimePicker: UIDatePicker! 
    @IBOutlet weak var myContainView: UIView!


    
    // MARK: - Life

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = mode.title
        modeChoose()
        pickTime()
        myTimePicker.setValue(UIColor.white, forKey: "textColor")
        myTimePicker.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }

    
    override func viewWillAppear(_ animated: Bool) {
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
        if array == nil {
            array = Array(repeating: false, count: 7)
        }
        switch mode {
        case .add:

        delegate?.alarmSetting(time: okTime, label: alarmLabel, repeatDate:repeatDate, isOn: true ,array:array)
        case .edit:
            tempAlarm?.time = okTime!
            tempAlarm?.label = alarmLabel
            tempAlarm?.repeatdate = repeatDate
            tempAlarm?.repeatArray = array
            delegate?.valueChanged(array: tempAlarm, index: indexPath!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Func
    fileprivate func modeChoose() {
        switch mode {
        case .add:
            editTVC.alarmName.text = "鬧鐘"
            editTVC.repeatLabel.text = "永不"
            editTVC.mode = .add
        case .edit:
            editTVC.alarmName.text = tempAlarm?.label
            editTVC.repeatLabel.text = tempAlarm?.repeatdate!
            editTVC.mode = .edit
            //            alarmLabel = tempAlarm?.label ?? ""
            //            repeatDate = tempAlarm?.repeatdate ?? "永不"
            //要把時間套上
            pick()
        }
    }
    
    func pickTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        formatter.timeStyle = .short
//        formatter.amSymbol = "上午"
//        myTimePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale //24小時制
            self.okTime = formatter.string(from:myTimePicker.date)
        }
        func pick(){
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm"
            formatter.timeStyle = .short
            if let date = formatter.date(from: tempAlarm?.time ?? "") {
                myTimePicker.setDate(date, animated: true)
        }
        
//        }//改成儲存ＤＡＴＥ
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
                switch mode {
                    case .add:
                    labelVC.label = alarmLabel
                    case .edit:
                    labelVC.label = tempAlarm?.label
                }
        case "repeatDayPageSegue":
            let repeatVC = segue.destination as! RepeatDayTableViewController
            repeatVC.delegate = self
            switch mode {
                case .add:
                repeatVC.mode = .add
                case .edit:
                repeatVC.mode = .edit
                repeatVC.selected = tempAlarm?.repeatArray as! [Bool]
            }
            
        default:
            break
        }
    }
}
//MARK: - Protocol

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

extension AddAlarmViewController: LabelSetDelegate {
    func labelSet(label: String) {
        alarmLabel = label
        self.editTVC.alarmName.text = alarmLabel
    }
}

extension AddAlarmViewController: RepeatDaysSetDelegate {
    func repeatDaysSet(dayOfWeek: String, array: [Bool]) {
        repeatDate = dayOfWeek
        self.array = array
        self.editTVC.repeatLabel.text = repeatDate
    }
}
