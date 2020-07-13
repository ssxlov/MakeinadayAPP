//
//  MidTaskTableViewCell.swift
//  Makeinaday
//
//  Created by Hazret Blyagoz on 07.07.2020.
//  Copyright © 2020 Hazret Blyagoz. All rights reserved.
//

import UIKit
import SnapKit

class MidTaskTableViewCell: UITableViewCell {
    // MARK: - Variables
    private let edgeInsets = UIEdgeInsets(all: 20)
    private let contentEdgeInsets = UIEdgeInsets(all: 10)
    
    // MARK: - GUI Variables
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        
        return label
    }()
    
    var deleteTaskButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "check"), for: .normal)
        return button
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.setupContainerView()
        self.containerView.addSubview(self.descriptionLabel)
        self.containerView.addSubview(self.deleteTaskButton)
        self.setupConstraints()
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        self.containerView.snp.updateConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview().inset(5)
        }
        self.descriptionLabel.snp.updateConstraints { (make) in
            make.right.top.left.bottom.equalToSuperview().inset(10)
        }
        self.deleteTaskButton.snp.updateConstraints { (make) in
            make.right.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    // MARK: - Methods
    private func setupContainerView() {
        self.contentView.addSubview(self.containerView)
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.black.cgColor
    }
    
    // MARK: - Setter
    func set(description: String) {
        self.descriptionLabel.text = description
        self.setNeedsUpdateConstraints()
    }
}

