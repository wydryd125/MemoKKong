//
//  MemoCompseViewController.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/14.
//

import UIKit
import RxSwift

final class MemoCompseViewController: BaseViewController, ViewModelBindableType {
    
    // MARK: - Property
    
    private let composeView =  MemoComposeView()
    private let bag = DisposeBag()
    
    var viewModel: MemoComposeViewModel!
  
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = composeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.config()
    }
    
    // MARK: - Interface
    
    private func config() {
        self.setNavigation(hidden: false, title: "새 메모")
        self.view.backgroundColor = .backgroundColor
        
    }
    func bindViewModel() {
        // MARK: - Input
        self.composeView.addButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
//            .withLatestFrom(self.composeView.memoTextView.rx.text.orEmpty)
            .bind(to: viewModel.input.addDidTap)
            .disposed(by: bag)
        
        self.composeView.privateButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .scan(false) { lastState, newState in !lastState }
            .bind(to: viewModel.input.selectedPrivate)
            .disposed(by: bag)
        
        self.composeView.noticeButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .scan(false) { lastState, newState in !lastState }
            .bind(to: viewModel.input.selectedNotice)
            .disposed(by: bag)
        
        self.composeView.titleTextField.rx.text
            .bind(to: self.viewModel.input.titleText)
            .disposed(by: self.bag)
        
        self.composeView.memoTextView.rx.text
            .bind(to: self.viewModel.input.memoText)
            .disposed(by: self.bag)
        
        // MARK: - Output
        self.viewModel.output.closeCompose
            .observe(on: MainScheduler.instance)
            .bind(onNext: { _ in
                self.navigationController?.popViewController(animated: true)
//                self.viewModel.sceneCoordinator.close(animated: true)
            })
            .disposed(by: bag)
    }
}
