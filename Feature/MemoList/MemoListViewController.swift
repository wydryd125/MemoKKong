//
//  MemoListViewController.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

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

        loadViewIfNeeded()

        self.config()
        self.bind()
    }
    
    
    
    // MARK: - Interface
    
    private func config() {
        self.view.backgroundColor = .red
    }
    
    private func bind() {
        print("binding 성공")
        // MARK: - Input
        self.mainView.addButton.rx.tap
            .bind(to: viewModel.input.makeDidTap)
            .disposed(by: bag)
        
        // MARK: - Output
        
    }
}
