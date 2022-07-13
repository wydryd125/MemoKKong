//
//  MemoListViewModel.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import Foundation
import RxCocoa
import RxSwift

class MemoListViewModel: BaseViewModel {
    struct Input {
        let makeDidTap = PublishRelay<Void>()
    }
    
    struct Output {
        
    }
    
    // MARK: - Property
    
    let input = Input()
    let output = Output()
    let bag = DisposeBag()
    
    // MARK: - Interface

    private func makeCreateAction() {
       print("dddd")
    }

    
}
