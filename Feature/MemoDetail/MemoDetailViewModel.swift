//
//  MemoDetailViewModel.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import Foundation
import RxSwift
import RxCocoa

class MemoDetailViewModel : BaseViewModel {
    struct Input {
        let getMemoData = PublishRelay<Void>()
        let editDidTap = PublishRelay<Void>()
        let editTitleText = BehaviorRelay<String?>(value: nil)
        let editMemoText = BehaviorRelay<String?>(value: nil)
        let selectedNotice = BehaviorRelay<Bool?>(value: nil)
        let selectedPrivate = BehaviorRelay<Bool?>(value: nil)
    }
    
    struct Output {
        let setMemoData = BehaviorRelay<Memo?>(value: nil)
        let closeDetail = PublishRelay<Void>()
//        let editMemo = BehaviorRelay<Memo>(value: Memo()
        
    }
    
    // MARK: - Property
    
    let input = Input()
    let output = Output()
    let bag = DisposeBag()
    var memo: Memo!
    
    // MARK: - Interface
    
    override init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
        
        self.input.getMemoData
            .map { [weak self] _ -> Memo in
                guard let memo = self?.memo else { return Memo(memoTitle: "", content: "", selectedNotice: false, selectedPrivate: false) }
                
                return memo
            }
            .bind(onNext: { memo in
                print(memo)
                self.output.setMemoData.accept(memo)
            })
            .disposed(by: bag)
        
        
        self.input.editDidTap
            .map { [weak self] _ -> MemoModel? in
                
                guard
                    let title = self?.input.editTitleText.value,
                    let memo = self?.input.editMemoText.value
                else { return nil }
                
                
                let selectedNotice = self?.input.selectedNotice.value == nil ?  self?.memo.selectedNotice : self?.input.selectedNotice.value

                let selectedPrivate = self?.input.selectedPrivate.value  == nil ? self?.memo.selectedPrivate : self?.input.selectedPrivate.value
                
                return MemoModel(title: title == "" ? "Non Title" : title, memo: memo, selectedNotice: selectedNotice ?? false, selectedPrivate: selectedPrivate ?? false)
            }
            .compactMap { $0 }
            .bind(onNext:{ memoModel in
                
                self.storage.update(memo: self.memo, title: memoModel.title, content: memoModel.memo, selectedNotice: memoModel.selectedNotice, selectedPrivate: memoModel.selectedPrivate)
                self.output.closeDetail.accept(())
            })
            .disposed(by: bag)
        
    }
    
        
    }
    
    func performUpdate(memo: Memo) {
//        self.input.editDidTap
//            .map { [weak self] _ -> MemoModel? in
//                guard
//                    let title = self?.input.editTitleText.value,
//                    let memo = self?.input.editMemoText.value,
//                    let selectedNotice = self?.input.selectedNotice.value,
//                    let selectedPrivate = self?.input.selectedPrivate.value
//                else { return nil }
//
//                return MemoModel(title: title == "" ? "Non Title" : title, memo: memo, selectedNotice: selectedNotice, selectedPrivate: selectedPrivate)
//            }
//            .compactMap { $0 }
//            .bind(onNext:{ memoModel in
//                self.storage.update(memo: memo, title: memoModel.title, content: memoModel.memo, selectedNotice: memoModel.selectedNotice, selectedPrivate: memoModel.selectedPrivate)
//            })
//            .disposed(by: bag)
//
//    }
}
//    func performUpdate(memo: MemoModel) {
//        self.storage.update(memo: self.memo, title: memo.title, content: memo.memo, selectedNotice: memo.selectedNotice, selectedPrivate: memo.selectedPrivate)
//            .do(onNext: { self.memo = $0 } )
//            .map { [$0.content, self.dateFormate(date: $0.insertDate)] }
//            .bind(onNext: { self.contents.onNext($0)} )
//            .disposed(by: self.rx.disposeBag)
//    }
    
//    func dateFormate(date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ko_kr")
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .medium
//
//        return formatter.string(from: date)
//    }
