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
    var time: String
    var label: String?
    var repeatdate: String?
    var isOn: Bool = true
    var remindLater : Bool = false
    
}

enum EditMode {
    case Add, Edit
    
    var title:String{
        switch self {
        case .Add: return "加入鬧鐘"
        case .Edit: return "編輯鬧鐘"
        }
    }
    
}

    
enum Days {
    case 星期日 , 星期一, 星期二, 星期三 ,星期四, 星期五, 星期六
}


protocol AlarmSetDelegate {
    func alarmSetting(time: String?, label: String?, repeatDate:String?)
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


