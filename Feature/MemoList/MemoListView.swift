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
    var addButton = UIButton()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setAttribute()
        self.setConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Interface
    
    // MARK: - UI
    
    private func setAttribute() {
        [listTableView, addButton].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .backgroundColor
        listTableView.backgroundColor = .customBlueColor
        
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
            make.top.equalTo(listTableView.snp.bottom).inset(24)
            make.centerX.equalToSuperview()
        }
        
    }
}
