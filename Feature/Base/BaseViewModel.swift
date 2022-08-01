//
//  BaseViewModel.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import Foundation
import RxSwift
import RxCocoa

/*
 ViewModel에는 크게 2가지가 추가
 1. 의존성을 주입하는 initializer, 2.binding에 사용되는 속성과 메소드가 추가
 화면 전환과 메모 저장을 모두 처리하는데 sceneCoordinatord와 memoStorage 활용
 ViewModel을 생성하는 시점에 initializer 이용하여 의존성을 주입
 */

class BaseViewModel: NSObject {
    // 모든 scene가 navigation에 embad되기 떄문에 navigation title이 필요
    // Driver를 사용하면 naviagtion item에 쉽게 binding 할 수 있다.
  let title: Driver<String>
  let sceneCoordinator: SceneCoordinatorType
  let storage: MemoStorageType
  
    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
    self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
    self.sceneCoordinator = sceneCoordinator
    self.storage = storage
  }
}
