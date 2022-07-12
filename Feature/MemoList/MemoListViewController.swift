//
//  MemoListViewController.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import UIKit
import RxSwift
import RxCocoa

final class MemoListViewController: BaseViewController, ViewModelBindableType {
    // MARK: - Property
    
    private let mainView = MemoListView()
    var viewModel: MemoListViewModel!
    private let bag = DisposeBag()
    
    // MARK: - Life Cycle
    func bindViewModel() {
        print("찍혀찍혀!!!!!!!")
    }
    
    override func loadView() {
        self.view = mainView
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
