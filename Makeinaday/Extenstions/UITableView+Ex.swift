//
//  UITableView+Ex.swift
//  Makeinaday
//
//  Created by Hazret Blyagoz on 27.06.2020.
//  Copyright © 2020 Hazret Blyagoz. All rights reserved.
//

import UIKit

extension UITableView {
  func scrollToBottom() {

    let lastSectionIndex = self.numberOfSections - 1
    if lastSectionIndex < 0 {
        return
    }

    let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1
    if lastRowIndex < 0 { 
        return
    }

    let pathToLastRow = IndexPath(row: lastRowIndex, section: lastSectionIndex)
    self.scrollToRow(at: pathToLastRow, at: .bottom, animated: true)
  }
}
