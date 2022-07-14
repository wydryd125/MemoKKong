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
        self.bind()
    }
    
//    override func loadView() {
//        self.view = mainView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewIfNeeded()
        self.config()
        self.setConstraint()
    }
    
    // MARK: - Interface
    
    private func config() {
        print("백그라운드,,,,")
        
        view.addSubview(mainView)
        self.view.backgroundColor = .red
    }
    
    private func setConstraint() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
