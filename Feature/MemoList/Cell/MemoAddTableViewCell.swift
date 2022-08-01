//
//  MemoAddTableViewCell.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/27.
//

import UIKit

protocol MemoAddTableViewCellDelegate: class {
    func didTapCreateButton()
}

class MemoAddTableViewCell: UITableViewCell {
    static let identifier = "MemoAddTableViewCell"
    
    weak var delegate: MemoAddTableViewCellDelegate?
    
    var addButton = UIButton()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setAttribute()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttribute() {
        self.backgroundColor = .backgroundColor
        
        self.addSubview(addButton)
        addButton.backgroundColor = .customBlueColor
        addButton.layer.cornerRadius = 24
        addButton.setImage(UIImage(named: "plusWhite.png"), for: .normal)
        
        addButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
    }
    
    private func setConstraint() {
        self.addButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(48)
        }
        
    }
    
    @objc private func didTapCreateButton() {
        delegate?.didTapCreateButton()
    }
}
