//
//  AddAlarmViewController.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/25.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import UIKit

class AddAlarmViewController: UIViewController {

    @IBOutlet weak var myTimePicker: UIDatePicker!
    @IBOutlet weak var myContainView: UIView!
    
    var delegate: timeSet?
    var task: Task?
    var okTime:String?
    var index: Int?
    var alarmLabel:String = "鬧鐘"
//    var repeatDate:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func timePick(_ sender: UIDatePicker) {
        pickTime()
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
//    @IBAction func saveButton(_ sender: UIBarButtonItem, time:Strin) {
//
//        delegate?.timeSetting(value: okTime)
//        self.dismiss(animated: true, completion: nil)
//    }
    
    @IBAction func clickSaveButton(_ sender: UIBarButtonItem) {
        if let okTime = okTime {
            delegate?.timeSetting(time: okTime, label: alarmLabel)
        }else {
            pickTime()
            delegate?.timeSetting(time: okTime, label: alarmLabel)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func pickTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeStyle = .short
        
        
        let okTime = formatter.string(from:myTimePicker.date)
        self.okTime = okTime
        print(okTime)

    }
    
}


