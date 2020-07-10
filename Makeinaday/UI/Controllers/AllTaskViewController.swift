//
//  AllTaskViewController.swift
//  Makeinaday
//
//  Created by Hazret Blyagoz on 05.07.2020.
//  Copyright © 2020 Hazret Blyagoz. All rights reserved.
//

import UIKit
import CoreData

class AllTaskViewController: UIViewController {
    // MARK: - Variables
    let CoreDataModel = CoreDataManager()
    var taskArr: [String] = []
    let context = CoreDataManager.shared
    
    // MARK: - Outlets
    @IBOutlet weak var allTaskTableView: UITableView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allTaskTableView.delegate = self
        allTaskTableView.dataSource = self
        allTaskTableView.separatorStyle = .none
        self.allTaskTableView.register(AllTaskTableViewCell.self, forCellReuseIdentifier: "AllTask")
        getData(from: "Model")
    }
    
    // MARK: - Methods
    func getData(from name: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: name)
        do {
            let result = try CoreDataModel.context.fetch(fetchRequest)
            result.forEach{
                guard let task = $0.value(forKey: "alltask") as? String else {
                    return
                }
                taskArr.append(task)
                
            }
        } catch let error as NSError {
            print("Couldn't read data. \(error)")
        }
    }
    
    @objc func deleteUser(_ sender: UIButton) {
        if let cell = sender.superview?.superview?.superview as? AllTaskTableViewCell,
            let indexPath = allTaskTableView.indexPath(for: cell) {
            self.taskArr.remove(at: indexPath.row)
            self.allTaskTableView.deleteRows(at: [indexPath], with: .fade)
        }
        allTaskTableView.reloadData()
    }
}

extension AllTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = self.allTaskTableView.dequeueReusableCell(
            withIdentifier: "AllTask",
            for: indexPath)
        (taskCell as? AllTaskTableViewCell)?.set(
            description: taskArr[indexPath.row])
        (taskCell as? AllTaskTableViewCell)?.deleteTaskButton.addTarget(self,
                                                                        action: #selector(deleteUser(_ :)),
                                                                        for: .touchUpInside)
        
        return taskCell
    }
}
