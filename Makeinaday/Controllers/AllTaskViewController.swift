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
    
    let example1 = "Показать приложение 'Makeindayapp'"
    let example2 = "Получить 10 баллов на защите проекта"
    let example3 = "Рассказать про будущий функционал"
    
    // MARK: - Outlets
    @IBOutlet weak var allTaskTableView: UITableView!
    
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.allTaskTableView.delegate = self
        self.allTaskTableView.dataSource = self
        
        self.allTaskTableView.separatorStyle = .none
        self.allTaskTableView.register(AllTaskTableViewCell.self, forCellReuseIdentifier: "AllTask")
        
        taskArr.append(example1)
        taskArr.append(example2)
        taskArr.append(example3)
        
        self.getData(from: "Model")
    }
    
    // MARK: - Methods
    func getData(from name: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: name)
        do {
            let result = try self.CoreDataModel.context.fetch(fetchRequest)
            result.forEach{
                guard let task = $0.value(forKey: "alltask") as? String else {
                    return
                }
                self.taskArr.append(task)
                
            }
        } catch let error as NSError {
            print("Couldn't read data. \(error)")
        }
    }
    
    @objc func deleteUser(_ sender: UIButton) {
        if let cell = sender.superview?.superview?.superview as? AllTaskTableViewCell,
            let indexPath = self.allTaskTableView.indexPath(for: cell) {
            self.taskArr.remove(at: indexPath.row)
            self.allTaskTableView.deleteRows(at: [indexPath], with: .fade)
        }
        self.allTaskTableView.reloadData()
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
                                                                        action: #selector(self.deleteUser(_ :)),
                                                                        for: .touchUpInside)
        
        return taskCell
    }
}
