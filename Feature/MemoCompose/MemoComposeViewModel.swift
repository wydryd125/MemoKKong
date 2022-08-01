//
//  MemoComposeViewModel.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import Foundation
import RxCocoa
import RxSwift
import Action

class MemoComposeViewModel: BaseViewModel {
    struct Input {
        let addDidTap = PublishRelay<Void>()
        let selectedNotice = BehaviorRelay<Bool>(value: false)
        let selectedPrivate = BehaviorRelay<Bool>(value: false)
        let titleText = BehaviorRelay<String?>(value: nil)
        let memoText = BehaviorRelay<String?>(value: nil)
    }
    
    struct Output {
        let closeCompose = PublishRelay<Void>()
        
    }
    
    // MARK: - Property
    
    let input = Input()
    let output = Output()
    let bag = DisposeBag()
    
    // MARK: - Interface
    
    override init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
        
        //        self.input.addDidTap
        //            .bind { [weak self] in
        //                self?.selectedAddButton()
        //                //                self?.output.closeCompose
        //                //
        //                //                    .accept(())
        //            }
        //            .disposed(by: bag)
        
        
        
        //        Observable
        //            .combineLatest(
        //                self.input.addDidTap,
        //                self.input.titleText.compactMap { $0 },
        //                self.input.memoText.compactMap { $0 }
        //            )
        //            .bind { [weak self] _, title, memo in
        //                self?.storage.createMemo(title: title, content: memo, selectedNotice: false, selectedPrivate: false)
        //            }
        //            .disposed(by: self.bag)
        
        
        self.input.addDidTap
        //            .filter {
        //                return self.input.titleText.value != nil
        //            }
            .map { [weak self] _ -> MemoModel? in
                guard
                    let title = self?.input.titleText.value ,
                    let memo = self?.input.memoText.value,
                    let selectedNotice = self?.input.selectedNotice.value,
                    let selectedPivate = self?.input.selectedPrivate.value
                else { return nil }
                
                return MemoModel(title: title == "" ? "Non Title" : title, memo: memo, selectedNotice: selectedNotice, selectedPrivate: selectedPivate)
            }
            .compactMap { $0 }
            .bind(onNext: { memoModel in
                self.storage.createMemo(title: memoModel.title, content: memoModel.memo, selectedNotice: memoModel.selectedNotice, selectedPrivate: memoModel.selectedPrivate)
                self.output.closeCompose.accept(())
            })
        //            .bind(to: self.storage.createMemo)
        
        //            .bind { [weak self] memo in
        //                self?.storage.createMemo(title:, content: memo, selectedNotice: false, selectedPrivate: false)
        //            }
            .disposed(by: self.bag)
        
        
    }
    //    private func selectedAddButton() {
    //        storage.createMemo(title: "돼", content: "되라공", selectedNotice: false, selectedPrivate: false)
    //
    //        print(storage.memoList())
    //        self.output.closeCompose.accept(())
    //        print("찍혀")
    //
    //    }
    
    private func selectedNoticeButton() {
        
        
    }
    
}

