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
        backgroundColor = .backgroundColor
        
        self.addSubview(listTableView)
        listTableView.backgroundColor = .backgroundColor
        listTableView.separatorInset = .zero
        listTableView.separatorStyle = .none
        listTableView.isScrollEnabled = true
        
    }
    
    private func setConstraint() {
        let guide = self.safeAreaLayoutGuide

        self.listTableView.snp.makeConstraints { make in
            make.edges.equalTo(guide)
            make.width.equalToSuperview()
        }
        
    }
}
