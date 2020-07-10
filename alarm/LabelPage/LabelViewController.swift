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
    
    override func viewWillAppear(_ animated: Bool) {
        if  label != nil {
            self.myTextField.text = label
        }else {
            myTextField.text = ""
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        if let label = myTextField.text {
            delegate?.labelSet(label: label)

        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let label = myTextField.text {
            delegate?.labelSet(label: label)
            navigationController?.popViewController(animated: true)
        }
        return true
    }
    

}
