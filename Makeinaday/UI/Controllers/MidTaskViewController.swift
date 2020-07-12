//
//  MidTaskVIewController.swift
//  Makeinaday
//
//  Created by Hazret Blyagoz on 05.07.2020.
//  Copyright © 2020 Hazret Blyagoz. All rights reserved.
//

import UIKit
import CoreData

class MidTaskVIewController: UIViewController {
    // MARK: - Variables
    let CoreDataModel = CoreDataManager()
    private var midTasksData: [String] = []
    
    let example1 = "Рассказать про будущий функционал"
    
    // MARK: - Outlets
    @IBOutlet weak var midTaskTableView: UITableView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        midTaskTableView.delegate = self
        midTaskTableView.dataSource = self
        midTaskTableView.separatorStyle = .none
        
        midTasksData.append(example1)
        
        self.midTaskTableView.register(MidTaskTableViewCell.self, forCellReuseIdentifier: "MidTasks")
        getData(from: "Model")
    }
    
    // MARK: - Methods
    func getData(from name: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: name)
        
        do {
            let result = try CoreDataModel.context.fetch(fetchRequest)
            result.forEach{
                guard let task = $0.value(forKey: "medium") as? String else {
                    return
                }
                midTasksData.append(task)
            }
        } catch let error as NSError {
            print("Couldn't read data. \(error)")
        }
    }
    
    @objc func deleteUser(_ sender: UIButton) {
        if let cell = sender.superview?.superview?.superview as? MidTaskTableViewCell,
            let indexPath = midTaskTableView.indexPath(for: cell) {
            self.midTasksData.remove(at: indexPath.row)
            self.midTaskTableView.deleteRows(at: [indexPath], with: .fade)
        }
        midTaskTableView.reloadData()
    }
}

extension MidTaskVIewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.midTasksData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = self.midTaskTableView.dequeueReusableCell(
            withIdentifier: "MidTasks",
            for: indexPath)
        (taskCell as? MidTaskTableViewCell)?.set(
            description: midTasksData[indexPath.row])
        (taskCell as? MidTaskTableViewCell)?.deleteTaskButton.addTarget(self,
                                                                        action: #selector(deleteUser(_ :)),
                                                                        for: .touchUpInside)
        return taskCell
    }
}
