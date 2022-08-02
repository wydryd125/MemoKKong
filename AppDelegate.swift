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
        //UINavigationController(rootViewController: MemoListViewController())
//        self.window?.makeKeyAndVisible()

        let storage = CoreDataStorage(modelName: "MemoKKong")
        let coordinator = SceneCoordinator(window: window!)
        let listViewModel = MemoListViewModel(title: "", sceneCoordinator: coordinator, storage: storage)
        let listVC = Scene.list(listViewModel)
        
        coordinator.transition(to: listVC, using: .root, animated: true)
        
        return true
    }
}
