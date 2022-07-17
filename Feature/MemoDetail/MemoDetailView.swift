//
//  MemoDetailView.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/17.
//

import UIKit
import RxSwift
import RxCocoa

final class MemoDetailView: BaseView {
    
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
