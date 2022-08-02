//
//  MemoListViewModel.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import Foundation
import RxCocoa
import RxSwift
import Action
import RxDataSources
import CoreData

//typealias MemoSelectionModel = [Memo]?

//AnimatableSectionModel<Int, Memo>

class MemoListViewModel: BaseViewModel {
    struct Input {
        let getMemoListData = PublishRelay<Void>()
        let makeDidTap = PublishRelay<Void>()
        let notictDidTap = PublishRelay<Void>()
    }
    
    struct Output {
        let showMemoList = PublishRelay<Void>()
        let goToCompose = PublishRelay<Void>()
        let goToDetail = PublishRelay<Void>()
    }
    
    // MARK: - Property
    
    let input = Input()
    let output = Output()
    private let bag = DisposeBag()
    
    var noticeMemoList: [Memo]?
    var memoList: [Memo]?
    
//    var memo = BehaviorRelay<[Memo]>(value: [])
    
    
    // MARK: - Interface
    
    override init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
        
        self.input.getMemoListData
            .bind { [weak self] in
                self?.getMemoList()
            }
            .disposed(by: bag)
        
        self.input.makeDidTap
            .bind { [weak self] in
                self?.output.goToCompose.accept(())
                
            }
            .disposed(by: self.bag)
        
        self.input.notictDidTap
            .bind { [weak self] in
                self?.output.goToDetail.accept(())
            }
            .disposed(by: self.bag)
    }
    
    //물어보기
    func getMemoList() {
        storage.memoList()
            .bind(onNext: { list in
                self.memoList = list
                self.noticeMemoList = list.filter { $0.selectedNotice == true }
                //self.getNoticeMemoList(memo: list)
                self.output.showMemoList.accept(())
            })
            .disposed(by: bag)
    }
}
