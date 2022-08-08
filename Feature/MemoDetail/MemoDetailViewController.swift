//
//  MemoDetailViewController.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/17.
//

import UIKit
import RxSwift
import RxCocoa
import Action

final class MemoDetailViewController: BaseViewController, ViewModelBindableType {
    
    // MARK: - Property
    
    let detailView = MemoDetailView()
    private let bag = DisposeBag()

    var viewModel: MemoDetailViewModel!
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.config()
    }
    
    // MARK: - Interface
    func bindViewModel() {
        
        // MARK: - Input
        
        self.detailView.addButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: viewModel.input.editDidTap)
            .disposed(by: bag)
        
        self.detailView.titleTextField.rx.text
            .bind(to: self.viewModel.input.editTitleText)
            .disposed(by: self.bag)
        
        self.detailView.memoTextView.rx.text
            .bind(to: self.viewModel.input.editMemoText)
            .disposed(by: self.bag)
        
        self.detailView.privateButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .scan(self.detailView.selectedPrivate) { lastState, newState in !lastState }
            .bind(to: self.viewModel.input.selectedPrivate)
            .disposed(by: self.bag)
        
        self.detailView.noticeButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .scan(self.detailView.selectedNotice) { lastState, newState in !lastState }
            .bind(to: self.viewModel.input.selectedNotice)
            .disposed(by: self.bag)
//
        // MARK: - Output
        self.viewModel.output.closeDetail
            .observe(on: MainScheduler.instance)
            .bind(onNext: { _ in
                self.navigationController?.popViewController(animated: true)
//                self.viewModel.sceneCoordinator.close(animated: true)
            })
            .disposed(by: bag)
        
        self.viewModel.output.setMemoData
            .observe(on: MainScheduler.instance)
            .compactMap { $0 }
            .bind { memo in
                self.detailView.setMemoData(memo: memo)
            }
            .disposed(by: bag)
    }
    
    private func config() {
        self.setNavigation(hidden: false, title: nil)
        self.view.backgroundColor = .backgroundColor
    }
    
    
}

