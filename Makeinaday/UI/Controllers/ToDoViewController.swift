//
//  ViewController.swift
//  24h_ToDo
//
//  Created by Hazret Blyagoz on 24.06.2020.
//  Copyright © 2020 Hazret Blyagoz. All rights reserved.
//

import UIKit
import CoreData
class ToDoViewController: UIViewController {
    // MARK: - Variables
    let CoreDataModel = CoreDataManager()
    let context = CoreDataManager.shared.persistentContainer.viewContext
    private var model: [String] = []
    private var highPriorityArray: [String] = []
    private var mediumPriorityArray: [String] = []
    private var lowPriorityArray: [String] = []
    
    // MARK: - Outlets
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var myInputView: UIView!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var highPriorityButton: UIButton!
    @IBOutlet weak var mediumPriorityButton: UIButton!
    @IBOutlet weak var lowPriorityButton: UIButton!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toDoTableView.register(AnswerTableViewCell.self, forCellReuseIdentifier: "Answer")
        
        registerForKeyboardWillShowNotification(toDoTableView, priorityView: priorityView, inputView: myInputView)
        registerForKeyboardWillHideNotification(toDoTableView, priorityView: priorityView, inputView: myInputView)
        
        self.myTextField.layer.cornerRadius = myTextField.frame.size.height/2
        self.myTextField.clipsToBounds = true
    }
    
    // MARK: - Methods
    @IBAction func setHighPriority(_ sender: Any) {
        self.myTextField.textColor = .systemRed
        let text = myTextField.text!
        
        if text.count != 0{
            self.model.append(text)
            self.toDoTableView.insertRows(at: [IndexPath(row: self.model.count - 1, section: 0)], with: .right)
            self.highPriorityArray.append(text)
            self.myTextField.textColor = .black
        }
        self.toDoTableView.scrollToBottom()
        
        let object = Model(context: self.CoreDataModel.context)
        object.high = text
        object.alltask = text
        do {
            try self.CoreDataModel.context.save()
        } catch let error as NSError {
            print("Couldn't save data. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func setMediumPriority(_ sender: Any) {
        self.myTextField.textColor = .systemYellow
        let text = myTextField.text!
        
        if text.count != 0{
            self.model.append(text)
            self.toDoTableView.insertRows(at: [IndexPath(row: self.model.count - 1, section: 0)], with: .right)
            self.mediumPriorityArray.append(text)
            self.myTextField.textColor = .black
        }
        self.toDoTableView.scrollToBottom()
        
        let object = Model(context: self.CoreDataModel.context)
        object.medium = text
        object.alltask = text
        do {
            if text.count != 0 {
                try self.self.CoreDataModel.context.save()
            }
        } catch let error as NSError {
            print("Couldn't save data. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func setLowPriority(_ sender: Any) {
        self.myTextField.textColor = .systemGreen
        
        let text = myTextField.text!
        if text.count != 0{
            self.model.append(text)
            self.toDoTableView.insertRows(at: [IndexPath(row: self.model.count - 1 , section: 0)], with: .right)
            self.lowPriorityArray.append(text)
            self.myTextField.textColor = .black
        }
        self.toDoTableView.scrollToBottom()
        
        let object = Model(context: self.CoreDataModel.context)
        object.low = text
        object.alltask = text
        do {
            if text.count != 0 {
                try self.CoreDataModel.context.save()
            }
        } catch let error as NSError {
            print("Couldn't save data. \(error), \(error.userInfo)")
        }
    }
    
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let answerCell = self.toDoTableView.dequeueReusableCell(
            withIdentifier: "Answer",
            for: indexPath)
        (answerCell as? AnswerTableViewCell)?.set(
            description: self.myTextField.text ?? "none",
            backgroungColor: self.myTextField.textColor ?? UIColor.white)
        answerCell.selectionStyle = .none
        self.myTextField.text = ""
        return answerCell
    }
}
