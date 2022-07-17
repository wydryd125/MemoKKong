//
//  AppDelegate.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MemoListViewController()
        self.window?.makeKeyAndVisible()

//        let storage = MemoryStorage()
        let coordinator = SceneCoordinator(window: window!)
        let listViewModel = MemoListViewModel()
        //MemoListViewModel(title: "", sceneCoordinator: coordinator)
        let listVC = Scene.list(listViewModel)
        
        coordinator.transition(to: listVC, using: .root, animated: true)
        
        return true
    }
}
