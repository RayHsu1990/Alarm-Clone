//
//  File.swift
//  alarm
//
//  Created by Ray Hsu on 2020/7/15.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import Foundation


class AlarmData {
        
    
    static func saveData(alarmArray: [Alarm]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(alarmArray)
            UserDefaults.standard.set(data, forKey: "alarmsKey")
        } catch {
            print("Save error")
        }
    }
    
    static func loadData(alarmArray: [Alarm]) -> [Alarm] {
        guard let data = UserDefaults.standard.data(forKey: "alarmsKey") else {
            return [Alarm]()
        }
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode([Alarm].self, from: data)
            let alarmArray = decoded
        } catch {
            print("Load error")
        }
        return alarmArray
    }

}
