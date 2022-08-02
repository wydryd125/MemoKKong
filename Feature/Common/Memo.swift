//
//  Memo.swift
//  MemoKKong
//
//  Created by Yukyung Jeong on 2022/07/12.
//

import Foundation
import RxDataSources
import CoreData
import RxCoreData

struct Memo: Equatable, IdentifiableType {
    var memoTitle: String
    var content: String
    var insertDate: Date
    var selectedNotice: Bool
    var selectedPrivate: Bool
    var identity: String
 
    init(memoTitle: String, content: String, insertData: Date = Date(), selectedNotice: Bool, selectedPrivate: Bool) {
        self.memoTitle = memoTitle
        self.content = content
        self.selectedNotice = selectedNotice
        self.selectedPrivate = selectedPrivate
        self.insertDate = insertData
        self.identity = "\(insertData.timeIntervalSinceReferenceDate)"
    }
    
    init(original: Memo, updateTitle: String, updateContent: String, selectedNotice: Bool, selectedPrivate: Bool) {
        self = original
        
        self.memoTitle = updateTitle
        self.content = updateContent
        self.selectedPrivate = selectedPrivate
        self.selectedNotice = selectedNotice
    }
}

extension Memo: Persistable {
    static var entityName: String {
        return "MemoKKong"
    }
    
    static var primaryAttributeName: String {
        return "identity"
    }

    
    init(entity: NSManagedObject) {
        memoTitle = entity.value(forKey: "title") as! String
        content = entity.value(forKey: "content") as! String
        insertDate = entity.value(forKey: "insertDate") as! Date
        selectedNotice = entity.value(forKey: "selectedNotice") as! Bool
        selectedPrivate = entity.value(forKey: "selectedPrivate") as! Bool
        identity = "\(insertDate.timeIntervalSinceReferenceDate)"
        
    }
    
    func update(_ entity: NSManagedObject) {
        entity.setValue(memoTitle, forKey: "title")
        entity.setValue(content, forKey: "content")
        entity.setValue(insertDate, forKey: "insertDate")
        entity.setValue(selectedNotice, forKey: "selectedNotice")
        entity.setValue(selectedPrivate, forKey: "selectedPrivate")
        entity.setValue("\(insertDate.timeIntervalSinceReferenceDate)", forKey: "identity")
        
        do {
            try entity.managedObjectContext?.save()
        } catch {
            print(error)
        }
    }
    
}
