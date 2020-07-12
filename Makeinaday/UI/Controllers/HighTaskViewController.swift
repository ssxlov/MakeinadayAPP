//
//  HighTaskViewController.swift
//  Makeinaday
//
//  Created by Hazret Blyagoz on 05.07.2020.
//  Copyright © 2020 Hazret Blyagoz. All rights reserved.
//

import UIKit
import CoreData

class HighTaskViewController: UIViewController {
    // MARK: - Variables
    let CoreDataModel = CoreDataManager()
    private var highTasksData: [String] = []
    
    let example1 = "Показать приложение 'Makeindayapp'"
    let example2 = "Получить 10 баллов на защите проекта"
    
    // MARK: - Outlets
    @IBOutlet weak var highTaskTableView: UITableView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highTaskTableView.delegate = self
        highTaskTableView.dataSource = self
        highTaskTableView.separatorStyle = .none
        
        self.highTaskTableView.register(HighTaskTableViewCell.self, forCellReuseIdentifier: "HighTasks")
        highTasksData.append(example1)
        highTasksData.append(example2)
        getData(from: "Model")
    }
    
    // MARK: - Methods
    func getData(from name: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: name)
        
        do {
            let result = try CoreDataModel.context.fetch(fetchRequest)
            result.forEach{
                guard let task = $0.value(forKey: "high") as? String else {
                    return
                }
                highTasksData.append(task)
            }
        } catch let error as NSError {
            print("Couldn't read data. \(error)")
        }
    }
    
    @objc func deleteUser(_ sender: UIButton) {
        if let cell = sender.superview?.superview?.superview as? HighTaskTableViewCell,
            let indexPath = highTaskTableView.indexPath(for: cell) {
            self.highTasksData.remove(at: indexPath.row)
            self.highTaskTableView.deleteRows(at: [indexPath], with: .fade)
        }
        highTaskTableView.reloadData()
    }
}

extension HighTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.highTasksData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = self.highTaskTableView.dequeueReusableCell(
            withIdentifier: "HighTasks",
            for: indexPath)
        (taskCell as? HighTaskTableViewCell)?.set(
            description: highTasksData[indexPath.row])
        (taskCell as? HighTaskTableViewCell)?.deleteTaskButton.addTarget(self,
                                                                         action: #selector(deleteUser(_ :)),
                                                                         for: .touchUpInside)
        return taskCell
    }
}
