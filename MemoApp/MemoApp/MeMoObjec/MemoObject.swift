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
    @Persisted var memoDate = Date()
    @Persisted var memoTitle: String
    @Persisted var memoDetail: String
    
    convenience init(memoTitle: String, memoDetail: String) {
        self.init()
        self.memoTitle = memoTitle
        self.memoDetail = memoDetail
    }
}


