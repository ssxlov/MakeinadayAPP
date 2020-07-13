//
//  TaskListViewController.swift
//  Makeinaday
//
//  Created by Hazret Blyagoz on 05.07.2020.
//  Copyright © 2020 Hazret Blyagoz. All rights reserved.
//

import UIKit

class TaskListController: UIViewController {
    // MARK: - Variables
    let addTaskView = ToDoViewController()
    let CoreDataModel = CoreDataManager()
    let whiteTextForSC = [NSAttributedString.Key.foregroundColor: UIColor.white]
    let blackTextForSC = [NSAttributedString.Key.foregroundColor: UIColor.black]
    
    // MARK: - Outlets
    @IBOutlet weak var AllTaskView: UIView!
    @IBOutlet weak var HighTaskView: UIView!
    @IBOutlet weak var MidTaskView: UIView!
    @IBOutlet weak var LowTaskView: UIView!
    @IBOutlet weak var sc: UISegmentedControl!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.AllTaskView.alpha = 1
        self.HighTaskView.alpha = 0
        self.MidTaskView.alpha = 0
        self.LowTaskView.alpha = 0
        
        self.sc.setTitleTextAttributes(self.whiteTextForSC, for: .normal)
        self.sc.setTitleTextAttributes(self.blackTextForSC, for: .selected)
    }
    
    // MARK: - Methods
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        sender.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .disabled)
        if sender.selectedSegmentIndex == 0 {
            self.AllTaskView.alpha = 1
            self.HighTaskView.alpha = 0
            self.MidTaskView.alpha = 0
            self.LowTaskView.alpha = 0
        } else if sender.selectedSegmentIndex == 1 {
            self.AllTaskView.alpha = 0
            self.HighTaskView.alpha = 1
            self.MidTaskView.alpha = 0
            self.LowTaskView.alpha = 0
        } else if sender.selectedSegmentIndex == 2 {
            self.AllTaskView.alpha = 0
            self.HighTaskView.alpha = 0
            self.MidTaskView.alpha = 1
            self.LowTaskView.alpha = 0
        } else {
            self.AllTaskView.alpha = 0
            self.HighTaskView.alpha = 0
            self.MidTaskView.alpha = 0
            self.LowTaskView.alpha = 1
        }
    }
}
