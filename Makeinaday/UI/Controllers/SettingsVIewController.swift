//
//  SettingsVIewController.swift
//  Makeinaday
//
//  Created by Hazret Blyagoz on 11.07.2020.
//  Copyright © 2020 Hazret Blyagoz. All rights reserved.
//

import UIKit

class SettingsVIewController: UIViewController {
    // MARK: - Variables
    let coreData = CoreDataManager()
    let allTaskView = AllTaskViewController()
    @IBOutlet weak var colorSwitcher: UISwitch!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func deleteAllTask(_ sender: Any) {
        self.coreData.deleteAll(entityName: "Model")
    }
}
