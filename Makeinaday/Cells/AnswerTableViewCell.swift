//
//  MyTableViewCell.swift
//  24h_ToDo
//
//  Created by Hazret Blyagoz on 25.06.2020.
//  Copyright © 2020 Hazret Blyagoz. All rights reserved.
//

import UIKit
import SnapKit

class AnswerTableViewCell: UITableViewCell {
   
    // MARK: - Variables
    private let edgeInsets = UIEdgeInsets(all: 20)
    private let contentEdgeInsets = UIEdgeInsets(all: 10)
    private let radius: CGFloat = 16
    private let arrowSize: CGSize = CGSize(width: 24, height: 24)


    // MARK: - GUI Variables
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
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
        self.setupConstraints()
    }

    // MARK: - Constraints
    private func setupConstraints() {
        self.containerView.snp.updateConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-5)
            make.right.equalToSuperview().inset(self.edgeInsets)
            make.left.greaterThanOrEqualToSuperview().offset(90)
            make.width.greaterThanOrEqualTo(descriptionLabel).offset(10)
        }
        
        self.descriptionLabel.snp.updateConstraints { (make) in
            make.right.top.left.bottom.equalToSuperview().inset(self.contentEdgeInsets)
        }
    }

    // MARK: - Methods
    private func setupContainerView() {
        self.contentView.addSubview(self.containerView)
        self.containerView.layer.cornerRadius = self.radius
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.black.cgColor
    }
  
    // MARK: - Setter
    func set(description: String, backgroungColor: UIColor) {
        self.descriptionLabel.text = description
        self.containerView.backgroundColor = backgroungColor
        
        self.setNeedsUpdateConstraints()
    }
}
