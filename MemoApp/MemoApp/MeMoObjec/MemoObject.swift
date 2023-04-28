//
//  ObjectModel.swift
//  MemoApp
//
//  Created by 권현석 on 2023/04/27.
//

import Foundation
import RealmSwift

class MemoObject: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var memoTitle: String
    @Persisted var memoDetail: String
    @Persisted var memoDate = Date()
    
    convenience init(memoTitle: String, memoDetail: String, memoDate: Date = Date()) {
        self.init()
        self.memoTitle = memoTitle
        self.memoDetail = memoDetail
        self.memoDate = memoDate
    }
}
