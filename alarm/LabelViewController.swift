//
//  LabelViewController.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/30.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import UIKit

class LabelViewController: UIViewController {
    var label: String?
    @IBOutlet weak var myTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if  label != nil {
            self.myTextField.text = label
        }else {
            myTextField.text = ""
        }
        myTextField.becomeFirstResponder()
        myTextField.enablesReturnKeyAutomatically = true
        
    }
    
//    @IBAction func unwind(for segue:UIStoryboardSegue) {
//        if segue.identifier == "labelPageSegue"{
//            let vc = segue.source as! AddAlarmViewController
//            vc.alarmLabel = myTextField.text ?? ""
    
    
//        }
//    }
    
//    @objc func printHello() {
//        print("Hello")
//    }

}
