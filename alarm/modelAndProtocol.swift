//
//  task.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/25.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//
//"星期日", "星期一", "星期二", "星期三","星期四", "星期五", "星期六"
import Foundation

struct Alarm {
    var time: String
    var label: String?
    var repeatDate: String?
    var repeatArray: [Bool]
    var isOn: Bool = true
    var remindLater : Bool = false
    
//    var repeatTitle : String {
//        switch repeatArray {
//        case :
//            return
//        case:
//            return
//            
//            
//        }
//    }
//    
}

enum EditMode {
    case add, edit
    
    var title:String{
        switch self {
        case .add: return "加入鬧鐘"
        case .edit: return "編輯鬧鐘"
        }
    }
}

    
enum Days {
    case sun , mon, tue, wed ,thu, fri, sat
    
    var title : String {
        switch self {
        case .sun: return "日"
        case .mon: return "一"
        case .tue: return "二"
        case .wed: return "三"
        case .thu: return "四"
        case .fri: return "五"
        case .sat: return "六"
        }
    }
    func getTitle(prefix: String) -> String {
        prefix + self.title
    }
    
}


protocol AlarmSetDelegate {
    func setAlarm(alarm:Alarm)
        
    func valueChanged (array: Alarm, index:Int )
}
protocol LabelSetDelegate {
    func labelSet (label:String)
}

protocol CellPressedDelegate {
    func goNextPage(destination:String)
    
    func delete()
}

protocol RepeatDaysSetDelegate {
    func repeatDaysSet(dayOfWeek:String, array:[Bool])
}


