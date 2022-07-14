//
//  MemoCompseViewController.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/14.
//

import UIKit
import RxSwift

final class MemoCompseViewController: BaseViewController {
    
    // MARK: - Property
    
    private let composeView =  MemoComposeView()
    private let viewModel = MemoComposeViewModel()
    private let bag = DisposeBag()
    
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = composeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.config()
        self.bind()
    }
    
    
    
    // MARK: - Interface
    
    private func config() {
        self.setNavigation(hidden: false, title: "새 메모")
        self.view.backgroundColor = .backgroundColor
        
    }
    
    private func bind() {
        
        // MARK: - Input
        
        
        // MARK: - Output
        
    }
}
