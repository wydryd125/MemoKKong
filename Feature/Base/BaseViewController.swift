//
//  BaseViewController.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import UIKit
import CoreData

class BaseViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let storage = CoreDataStorage(modelName: "MemoKKong")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setNavigation(hidden: Bool, title: String?) {
        if hidden {
            self.navigationController?.isNavigationBarHidden = true
        } else {
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.navigationBar.tintColor = .black
            self.navigationController?.navigationBar.topItem?.title = ""
        
            self.navigationItem.title = title
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)]
          
        }
    }
    
}
