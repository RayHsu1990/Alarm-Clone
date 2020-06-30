//
//  ViewController.swift
//  alarm
//
//  Created by Ray Hsu on 2020/6/25.
//  Copyright © 2020 Ray Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var alarmList = [Task]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func newButton(_ sender: UIBarButtonItem) {
        popAddAlarm()

    }

    @IBAction func editButton(_ sender: UIBarButtonItem) {
    }

    
    override func viewDidLoad() {
        let nib = UINib(nibName: "MainPageTableViewCell", bundle: nil)
        self.myTableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    
    func popAddAlarm() {
        performSegue(withIdentifier: "addAlarm", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addAlarm") {
                let editVC = segue.destination as! AddAlarmViewController
                editVC.delegate = self
        }
    }

}

//MARK: - Tableview

extension ViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = alarmList[indexPath.row]
        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = task.subTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alarmList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

extension ViewController : timeSet {
    func timeSetting(time: String?, label: String?) {
        if let time = time, let label = label{
            let newAlarm = Task(title: time, subTitle: label, isOn: true)
            alarmList.append(newAlarm)
            let newTex = IndexPath(row: self.alarmList.count - 1, section: 0)
            self.myTableView.insertRows(at: [newTex], with: .automatic)
        }

        
    }
    
    
}
