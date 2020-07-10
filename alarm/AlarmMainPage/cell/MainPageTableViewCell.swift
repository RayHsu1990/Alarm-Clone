//
//  MainPageTableViewCell.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/29.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import UIKit

class MainPageTableViewCell: UITableViewCell {


    
    @IBOutlet weak var myTitle: UILabel!
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        editingAccessoryType = .disclosureIndicator
        selectionStyle = .none
        editingAccessoryView = UIImageView(image: UIImage(named: "Forward_Filled"))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func update(by alarm: Alarm) {
//        myTitle.text = alarm.label
        myTitle.text = alarm.time
        if alarm.repeatdate == "永不" {
            label.text = alarm.label
        }else {
            label.text = alarm.label! + "," + alarm.repeatdate!
        }
        myTitle.textColor = alarm.isOn ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        label.textColor = alarm.isOn ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)

    }
}
