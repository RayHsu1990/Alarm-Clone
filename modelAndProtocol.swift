//
//  task.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/25.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//
//"星期日", "星期一", "星期二", "星期三","星期四", "星期五", "星期六"
import Foundation

struct AlarmModel {
    var title:String
    var subTitle:String?
    var isOn: Bool

}

//enum Days:Int {
//    case 星期日 = 0
//    case 星期一 = 1
//    case 星期二 = 2
//    case 星期三 = 3
//    case 星期四 = 4
//    case 星期五 = 5
//    case 星期六 = 6
//}
    
enum Days {
    case 星期日 , 星期一, 星期二, 星期三 ,星期四, 星期五, 星期六
}

protocol AlarmSetDelegate {
    func timeSetting(time: String?, label: String?)
}
protocol LabelSetDelegate {
    func labelSet (label:String)
}

protocol CellPressedDelegate {
    func goNextPage(destination:String)
}

protocol RepeatDaysSetDelegate {
    func repeatDaysSet(dayOfWeek:String)
}
