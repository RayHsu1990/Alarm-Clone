//
//  AddAlarmViewController.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/25.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import UIKit

class AddAlarmViewController: UIViewController {
    
    var editTVC: EditingTableViewController!
    var delegate: AlarmSetDelegate?
    var tempAlarm: AlarmModel?
    var okTime:String?
    var alarmLabel:String = "鬧鐘"
    var repeatDate:String = "永不"
    var mode = EditMode.Add
    
    @IBOutlet weak var myTimePicker: UIDatePicker! 
    @IBOutlet weak var myContainView: UIView!


    
    // MARK: - Life
    override func viewDidLoad() {
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
            guard let alarmLabel = tempAlarm?.label else {
                return
            }
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
        switch mode {
        case .Add:
        delegate?.alarmSetting(time: okTime, label: alarmLabel, repeatDate:repeatDate)
        case .Edit:
            delegate?.alarmSetting(time: tempAlarm?.time, label: tempAlarm?.label, repeatDate:tempAlarm?.repeatdate)
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
         if (segue.identifier == "editTableVCSegue") {
            let editTableView = segue.destination as! EditingTableViewController
            self.editTVC = editTableView
            editTVC.delegate = self
         }else if
            (segue.identifier == "labelPageSegue") {
            let labelVC = segue.destination as! LabelViewController
            labelVC.delegate = self
            switch mode {
            case .Add:
                labelVC.label = alarmLabel
            case .Edit:
                labelVC.label = tempAlarm?.label
            }
         }else if
            (segue.identifier == "repeatDayPageSegue") {
            let repeatVC = segue.destination as! RepeatDayTableViewController
            repeatVC.delegate = self
            
        }
    }
}
//MARK: - Protocol

extension AddAlarmViewController: CellPressedDelegate{
    func goNextPage(destination:String) {
        performSegue(withIdentifier: destination, sender: nil)
//    let vc = storyboard?.instantiateViewController(withIdentifier: destination)
//    show(vc!, sender: self)
    }
}

extension AddAlarmViewController: LabelSetDelegate {
    func labelSet(label: String) {
        alarmLabel = label
        self.editTVC.alarmName.text = alarmLabel
    }
}

extension AddAlarmViewController: RepeatDaysSetDelegate {
    func repeatDaysSet(dayOfWeek: String) {
        repeatDate = dayOfWeek
        self.editTVC.repeatLabel.text = repeatDate
    }
}
