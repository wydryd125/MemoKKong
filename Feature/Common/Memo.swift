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
    //추가추가추가
  var content: String
  var insertDate: Date
  var identity: String
  
  init(content: String, insertData: Date = Date()) {
    self.content = content
    self.insertDate = insertData
    self.identity = "\(insertData.timeIntervalSinceReferenceDate)"
  }
  
  init(original: Memo, updateContent: String) {
    self = original
    self.content = updateContent
  }
}
