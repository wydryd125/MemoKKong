//
//  Scene.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import Foundation


import UIKit

/*
 구현해야하는 Scene
 */

enum Scene {
    case list(MemoListViewModel) // 메모 목록, 연관된 view model 저장
    case detail(MemoDetailViewModel) // 메모 자세히
    case compose(MemoComposeViewModel) // 메모 쓰기
    
}

extension Scene {
    func instantiat() -> UIViewController {
        
        switch self {
        case .list(let memoListViewModel):
            var listVC = MemoListViewController()
            listVC.bind(viewModel: memoListViewModel)
            
            return listVC
            
        case .detail(let memoDetailViewModel):
            var detailVC = MemoDetailViewController()
            detailVC.bind(viewModel: memoDetailViewModel)
        
            return detailVC

        case .compose(let memoComposeViewModel):
            var composeVC = MemoCompseViewController()
            
            DispatchQueue.main.async { //바인딩 시간을 늦춰야 네비게이션 타이틀 사이즈가 라지로 나옴
                composeVC.bind(viewModel: memoComposeViewModel)
            }
            
            return composeVC
        }
    }
}

