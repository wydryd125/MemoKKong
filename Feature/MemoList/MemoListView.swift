//
//  MemoListView.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import UIKit
import SnapKit

final class MemoListView: BaseView {
    
    // MARK: - Property
    
    var listTableView = UITableView()
    var addLabel = UILabel()
    var addButton = UIButton()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setAttribute()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Interface
    
    // MARK: - UI
    
    private func setAttribute() {
        [listTableView, addLabel, addButton].forEach {
            self.addSubview($0)
        }
        
        self.backgroundColor = .backgroundColor
        
        listTableView.backgroundColor = .backgroundColor
        
        addLabel.text = "메모를 추가해주세요 !!"
        addLabel.textColor = .customLightGrayColor
        addLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        
        addButton.backgroundColor = .customBlueColor
        addButton.layer.cornerRadius = 25
        addButton.setImage(UIImage(named: "plus60.png"), for: .normal)
    }
    
    private func setConstraint() {
        self.listTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        self.addButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.centerY).offset(-20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        self.addLabel.snp.makeConstraints { make in
            make.bottom.equalTo(addButton.snp.top).offset(-40)
            make.centerX.equalToSuperview()
        }
        
    }
}
