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
    @Persisted var entireMemo: String
    @Persisted var isFixed: String // fixed = 0이면 일반 메모, 1이면 고정된 메모
    
    convenience init(memoTitle: String, memoDetail: String, entireMemo: String, isFixed: String) {
        self.init()
        self.memoTitle = memoTitle
        self.memoDetail = memoDetail
        self.entireMemo = entireMemo
        self.isFixed = isFixed
    }
}

//class FixedMemoObject: Object {
//    // primaryKey 만들어야 하나 아닌가?
//    @Persisted var memoDate = Date()
//    @Persisted var memoTitle: String
//    @Persisted var memoDetail: String
//    @Persisted var entireMemo: String
//    
//    convenience init(memoTitle: String, memoDetail: String, entireMemo: String) {
//        self.init()
//        self.memoTitle = memoTitle
//        self.memoDetail = memoDetail
//        self.entireMemo = entireMemo
//    }
//}
