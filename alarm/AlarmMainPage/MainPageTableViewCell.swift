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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
