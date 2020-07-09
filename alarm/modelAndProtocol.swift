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
    var repeatdate: String?
    var repeatArray: [Bool]
    var isOn: Bool = true
    var remindLater : Bool = false
    
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

    
//enum Days {
//    case 星期日 , 星期一, 星期二, 星期三 ,星期四, 星期五, 星期六
//    var title : String {
//        switch self {
//            
//        case .星期日:
//            <#code#>
//        case .星期一:
//            <#code#>
//        case .星期二:
//            <#code#>
//        case .星期三:
//            <#code#>
//        case .星期四:
//            <#code#>
//        case .星期五:
//            <#code#>
//        case .星期六:
//            <#code#>
//        }
//    }
//}


protocol AlarmSetDelegate {
    func setAlarm(alarm:Alarm?)
    
    func alarmSetting(time: String?, label: String?, repeatDate:String?, isOn: Bool ,array:[Bool])
    
    func valueChanged (array: Alarm?, index:Int )
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


