//
//  MemoDetailViewController.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/17.
//

import UIKit
import RxCocoa
import RxSwift

final class MemoDetailViewController: BaseViewController {
    
    // MARK: - Property
    
    private let detailView = MemoDetailView()
    private let viewModel = MemoListViewModel()
    private let bag = DisposeBag()
    
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.config()
        self.bind()
    }
    
    
    
    // MARK: - Interface
    
    private func config() {
        
    }
    
    private func bind() {
        
        // MARK: - Input
        
        
        // MARK: - Output
        
    }
}

