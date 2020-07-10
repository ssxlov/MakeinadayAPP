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
        
        AllTaskView.alpha = 1
        HighTaskView.alpha = 0
        MidTaskView.alpha = 0
        LowTaskView.alpha = 0
        
        sc.setTitleTextAttributes(whiteTextForSC, for: .normal)
        sc.setTitleTextAttributes(blackTextForSC, for: .selected)
    }
    
    // MARK: - Methods
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        sender.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .disabled)
        if sender.selectedSegmentIndex == 0 {
            AllTaskView.alpha = 1
            HighTaskView.alpha = 0
            MidTaskView.alpha = 0
            LowTaskView.alpha = 0
        } else if sender.selectedSegmentIndex == 1 {
            AllTaskView.alpha = 0
            HighTaskView.alpha = 1
            MidTaskView.alpha = 0
            LowTaskView.alpha = 0
        } else if sender.selectedSegmentIndex == 2 {
            AllTaskView.alpha = 0
            HighTaskView.alpha = 0
            MidTaskView.alpha = 1
            LowTaskView.alpha = 0
        } else {
            AllTaskView.alpha = 0
            HighTaskView.alpha = 0
            MidTaskView.alpha = 0
            LowTaskView.alpha = 1
        }
    }
}
