//
//  ViewController.swift
//  realmTableview
//
//  Created by Tanvir on 1/4/20.
//  Copyright © 2020 tanvir841. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    var realm : Realm!
    var dataList : Results<task>{
        get{
            return realm.objects(task.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        print(realm.configuration.fileURL as Any)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Add your task here", message: "This App will remind you about the task you added here", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter The task"
        })
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter The time"
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: {ACTION in
            if let textField = alert.textFields?[0], let text = textField.text {
                let currentID = self.realm.objects(task.self).max(ofProperty: "id") as Int? ?? 0
                let job = task()
                job.id = currentID + 1
                job.name = alert.textFields![0].text!
                job.time = currentID + 9
                do {
                    try self.realm.write {
                        self.realm.add(job)
                        print("saved")
                        self.tableView.reloadData()
                    }
                } catch {
                    print(0)
                }
                print(text)
            } else {
                print("nothing inserted")
            }
        }))
        
        self.present(alert, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = dataList[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }


}

