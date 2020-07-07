//
//  AddAlarmViewController.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/25.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import UIKit

class AddAlarmViewController: UIViewController {
    var alarmVC: ViewController!
    var editTVC: EditingTableViewController!
//    var repeatTVC: RepeatDayTableViewController!
//    var labelVC: LabelViewController!
    var delegate: AlarmSetDelegate?
    var tempAlarm: AlarmModel?
    var changedAlarm: AlarmModel?
    var array : [Bool]!
    var okTime:String?
    var alarmLabel:String = "鬧鐘"
    var repeatDate:String = "永不"
    var mode = EditMode.Add
    var path: Int?
    
    @IBOutlet weak var myTimePicker: UIDatePicker! 
    @IBOutlet weak var myContainView: UIView!


    
    // MARK: - Life
    override func viewDidLoad() {
        print(path)
        super.viewDidLoad()
        navigationItem.title = mode.title
//        print(mode)
        switch mode {
        case .Add:
            editTVC.alarmName.text = "鬧鐘"
            editTVC.repeatLabel.text = "永不"
            editTVC.mode = .Add
        case .Edit:
            editTVC.alarmName.text = tempAlarm?.label
            editTVC.repeatLabel.text = tempAlarm?.repeatdate!
            editTVC.mode = .Edit
//            alarmLabel = tempAlarm?.label ?? ""
//            repeatDate = tempAlarm?.repeatdate ?? "永不"
            //要把時間套上
        }
        pickTime()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    //MARK: - IBAction
    
    @IBAction func timePick(_ sender: UIDatePicker) {
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
        case .Add:

        delegate?.alarmSetting(time: okTime, label: alarmLabel, repeatDate:repeatDate, isOn: true ,array:array)
        case .Edit:
            tempAlarm?.time = okTime!
            tempAlarm?.label = alarmLabel
            tempAlarm?.repeatdate = repeatDate
            tempAlarm?.repeatArray = array
            delegate?.valueChanged(array: tempAlarm, index: path!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Func
    func pickTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        formatter.timeStyle = .short
//        formatter.amSymbol = "上午"
//        myTimePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale //24小時制
        self.okTime = formatter.string(from:myTimePicker.date)
//        if let okTime = formatter.date(from: okTime ?? ""){
//            myTimePicker.setDate(okTime, animated: true)
//        }
    }
    //MARK: prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "editTableVCSegue":
            let editTableView = segue.destination as! EditingTableViewController
                self.editTVC = editTableView
                editTVC.delegate = self
        case "labelPageSegue":
            let labelVC = segue.destination as! LabelViewController
            labelVC.delegate = self
                switch mode {
                    case .Add:
                    labelVC.label = alarmLabel
                    case .Edit:
                    labelVC.label = tempAlarm?.label
                }
        case "repeatDayPageSegue":
            let repeatVC = segue.destination as! RepeatDayTableViewController
            repeatVC.delegate = self
            switch mode {
                case .Add:
                repeatVC.mode = .Add
                case .Edit:
                repeatVC.mode = .Edit
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
        if let path = path {
            alarmVC.alarmList.remove(at: path)
        }
        dismiss(animated: true, completion: nil)
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
