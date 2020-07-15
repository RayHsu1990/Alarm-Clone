//
//  LabelViewController.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/30.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import UIKit

class LabelViewController: UIViewController, UITextFieldDelegate {
    
    var label: String?
    var delegate: LabelSetDelegate?
    
    @IBOutlet weak var myTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextField.delegate = self
        myTextField.becomeFirstResponder()
        myTextField.enablesReturnKeyAutomatically = true
    }
    func sendBackText() {
        if let label = myTextField.text {
            if label == "" {
                delegate?.labelSet(label: "鬧鐘")
            }else {
                delegate?.labelSet(label: label)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let label = label {
            self.myTextField.text = label
        }else {
            myTextField.text = ""
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        sendBackText()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendBackText()
        navigationController?.popViewController(animated: true)
        return true
    }
    

}
