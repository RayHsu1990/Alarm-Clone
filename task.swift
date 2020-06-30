//
//  task.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/25.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import Foundation

struct Task {
    var title:String
    var subTitle:String?
    var isOn: Bool
}

protocol timeSet {
    func timeSetting(value: String?)
}

