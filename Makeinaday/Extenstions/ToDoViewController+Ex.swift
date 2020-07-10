//
//  ToDoViewController+Ex.swift
//  Makeinaday
//
//  Created by Hazret Blyagoz on 27.06.2020.
//  Copyright © 2020 Hazret Blyagoz. All rights reserved.
//

import UIKit

extension ToDoViewController {
    
    func registerForKeyboardWillShowNotification(_ tableView: UITableView, priorityView: UIView, inputView: UIView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: tableView.contentInset.top, left: tableView.contentInset.left, bottom: tableView.contentInset.bottom, right: tableView.contentInset.right)
            
            tableView.scrollToBottom()
            
            priorityView.snp.updateConstraints{ (make) in
                make.top.equalTo(self.toDoTableView.snp.bottom).offset(500)
            }
            
            inputView.snp.updateConstraints { (make) in
                make.top.equalTo(self.priorityView.snp.bottom)
                make.bottom.equalToSuperview().inset(keyboardSize.height)
            }
            
            tableView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
            
        })
    }

    func registerForKeyboardWillHideNotification(_ tableView: UITableView, priorityView: UIView, inputView: UIView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: tableView.contentInset.top, left: tableView.contentInset.left, bottom: 0, right: tableView.contentInset.right)
            tableView.scrollToBottom()
            
            priorityView.snp.removeConstraints()
            tableView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }
}

extension UIScrollView {
    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
        self.contentInset = edgeInsets
        self.scrollIndicatorInsets = edgeInsets
    }
}


