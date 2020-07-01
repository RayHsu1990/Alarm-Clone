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

        pickTime()
        
    }
    

    @IBAction func timePick(_ sender: UIDatePicker) {
        pickTime()
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickSaveButton(_ sender: UIBarButtonItem) {
            delegate?.timeSetting(time: okTime, label: alarmLabel)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func pickTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
//        formatter.amSymbol = "上午"
        formatter.timeStyle = .short
        
        myTimePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale //24小時制
        
        
        let okTime = formatter.string(from:myTimePicker.date)
        self.okTime = okTime
        print(okTime)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if (segue.identifier == "editTableView") {
            let editTableView = segue.destination as! EditingTableViewController
            editTableView.delegate = self
         }else if (segue.identifier == "labelPageSegue") {
            let labelVC = segue.destination as! LabelViewController
            labelVC.label = alarmLabel
        }
}
    
}

protocol CellPressedDelegate {
    func goNextPage(destination:String)
}

extension AddAlarmViewController: CellPressedDelegate{
    func goNextPage(destination:String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: destination)
        show(vc!, sender: self)
//        if destination == "labelPageSegue"{
//        performSegue(withIdentifier: destination, sender: nil)
        
            
//        }
    }
    
}
