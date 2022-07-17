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
        
    }
    
    struct Output {
        
    }
    
    // MARK: - Property
    
    let input = Input()
    let output = Output()
    let bag = DisposeBag()
    
    // MARK: - Interface
    
    override init() {
        super.init()
    }
}
