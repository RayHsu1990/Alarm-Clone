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
