//
//  CoreDataStorage.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/21.
//

import Foundation
import RxSwift
import RxCoreData
import CoreData
import RxRelay

class CoreDataStorage: MemoStorageType {
    
    let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    @discardableResult
    func createMemo(title: String, content: String, selectedNotice: Bool, selectedPrivate: Bool) -> Observable<Memo> {

        let memo = Memo(memoTitle: title, content: content, selectedNotice: selectedNotice, selectedPrivate: selectedPrivate)
        
        do {
            _ = try mainContext.rx.update(memo)
            return Observable.just(memo)
        } catch {
            return Observable.error(error)
        }
    }
    
    @discardableResult
    func memoList() -> Observable<[Memo]> {
        return mainContext.rx.entities(Memo.self, sortDescriptors: [NSSortDescriptor (key: "insertDate", ascending: false)])
//            .map { result in [MemoSelectionModel(result)]}
//        return mainContext.rx.entities(Memo.self, sortDescriptors: [NSSortDescriptor(key: "insertDate", ascending: false)])
//            .map { results in [MemoSelectionModel(model: 0, items: results)]}
    }
    
    @discardableResult
    func update(memo: Memo, title: String, content: String, selectedNotice: Bool, selectedPrivate: Bool) -> Observable<Memo> {
        // 물어보자
        let updated = Memo(memoTitle: title, content: content, selectedNotice: selectedNotice, selectedPrivate: selectedPrivate)
        
        do {
            _ = try mainContext.rx.delete(memo)
            _ = try mainContext.rx.update(updated)
            return Observable.just(updated)
        } catch {
            return Observable.error(error)
        }
//        let updated = Memo(original: memo, updateTitle: title, updateContent: content, selectedNotice: selectedNotice, selectedPrivate: selectedPrivate)
//
//
//        do {
//            _ = try mainContext.rx.update(updated)
//            return Observable.just(updated)
//        } catch {
//            return Observable.error(error)
//        }
    }
    
    
    func delete(memo: Memo) {//}-> Observable<Memo> {
        do {
            try mainContext.rx.delete(memo)
            
//            return Observable.just(memo)
        } catch {
//            return Observable.error(error)
        }
    }
    
    
    var createMemo: Binder<MemoModel> {
        return Binder(self) { storage, data in
            let memo = Memo(memoTitle: data.title,
                            content: data.memo,
                            selectedNotice: data.selectedNotice,
                            selectedPrivate: data.selectedPrivate)
            
            do {
                _ = try storage.mainContext.rx.update(memo)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


struct MemoModel {
    let title: String
    let memo: String
    let selectedNotice: Bool
    let selectedPrivate: Bool
}
