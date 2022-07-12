//
//  MemoListView.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import UIKit

final class MemoListView: BaseView {
    
    // MARK: - Property
    
    
    
    
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
        
    }
    
    private func setConstraint() {
        let guide = self.safeAreaLayoutGuide
        
    }
}
