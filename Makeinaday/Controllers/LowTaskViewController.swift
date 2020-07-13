//
//  LowTaskViewController.swift
//  Makeinaday
//
//  Created by Hazret Blyagoz on 05.07.2020.
//  Copyright © 2020 Hazret Blyagoz. All rights reserved.
//

import UIKit
import CoreData

class LowTaskViewController: UIViewController {
    // MARK: - Variables
    let CoreDataModel = CoreDataManager()
    private var lowTaskData: [String] = []
    
    // MARK: - Outlets
    @IBOutlet weak var lowTaskTableView: UITableView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lowTaskTableView.delegate = self
        lowTaskTableView.dataSource = self
        lowTaskTableView.separatorStyle = .none
        
        self.lowTaskTableView.register(LowTaskTableViewCell.self, forCellReuseIdentifier: "LowTasks")
        getData(from: "Model")
    }
    
    // MARK: - Methods
    func getData(from name: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: name)
        
        do {
            let result = try CoreDataModel.context.fetch(fetchRequest)
            result.forEach{
                guard let task = $0.value(forKey: "low") as? String else {
                    return
                }
                lowTaskData.append(task)
            }
        } catch let error as NSError {
            print("Couldn't read data. \(error)")
        }
    }
    @objc func deleteUser(_ sender: UIButton) {
        if let cell = sender.superview?.superview?.superview as? LowTaskTableViewCell,
            let indexPath = lowTaskTableView.indexPath(for: cell) {
            self.lowTaskData.remove(at: indexPath.row)
            self.lowTaskTableView.deleteRows(at: [indexPath], with: .fade)
        }
        lowTaskTableView.reloadData()
    }
}

extension LowTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lowTaskData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = self.lowTaskTableView.dequeueReusableCell(
            withIdentifier: "LowTasks",
            for: indexPath)
        (taskCell as? LowTaskTableViewCell)?.set(
            description: lowTaskData[indexPath.row])
        (taskCell as? LowTaskTableViewCell)?.deleteTaskButton.addTarget(self,
                                                                        action: #selector(deleteUser(_ :)),
                                                                        for: .touchUpInside)
        return taskCell
    }
}
