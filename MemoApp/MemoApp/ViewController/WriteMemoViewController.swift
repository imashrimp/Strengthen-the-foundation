//
//  WriteMemoViewController.swift
//  MemoApp
//
//  Created by 권현석 on 2023/04/24.
//

import UIKit
import SnapKit
import RealmSwift

class WriteMemoViewController: UIViewController {
    
    let realm = try! Realm()
    let textview: UITextView = UITextView()
    var distributor: String? // 아니면 빈 문자열로 설정
    var memoSequenceNumber: Int? // 테이블 뷰 셀의 indexPath를 전달하기 위한 프로퍼티
    var memoSectionIdentifier: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubeViews()
        configure()
        makeConstraints()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.textview.becomeFirstResponder()
    }
    
    private func addSubeViews() {
        self.view.addSubview(textview)
    }
    
    private func configure() {
        self.view.backgroundColor = .white
    
        textview.backgroundColor = .white
        textview.font = .systemFont(ofSize: 20)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = .systemOrange
        self.navigationController?.navigationBar.topItem?.title = "메모"
        
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveMemo))
        navigationItem.rightBarButtonItems = [shareButton, doneButton]
    }
    
    private func makeConstraints() {
        textview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }

    @objc func saveMemo() {

        if distributor == "edit" {
            if memoSectionIdentifier == "normal" {
                // 여기서는 일반 메모 업데이트
                var memoContent = textview.text.components(separatedBy: .newlines)
                let memoTitle = memoContent.remove(at: 0) //
                let memoDetail = memoContent.joined(separator: " ")
                let memoObject = realm.objects(MemoObject.self)
                let memoToUpdate = memoObject[memoSequenceNumber ?? 0]
                
                try! realm.write{
                    memoToUpdate.memoTitle = memoTitle
                    memoToUpdate.memoDetail = memoDetail
                    memoToUpdate.entireMemo = textview.text
                }
            } else if memoSectionIdentifier == "fixed" {
                // 여기서는 고정 메모 업데이트
                var memoContent = textview.text.components(separatedBy: .newlines)
                let memoTitle = memoContent.remove(at: 0) //
                let memoDetail = memoContent.joined(separator: " ")
                let fixedMemoObject = realm.objects(FixedMemoObject.self)
                let fixedMemoToUpdate = fixedMemoObject[memoSequenceNumber ?? 0]
                
                try! realm.write{
                    fixedMemoToUpdate.memoTitle = memoTitle
                    fixedMemoToUpdate.memoDetail = memoDetail
                    fixedMemoToUpdate.entireMemo = textview.text
                }
            }
        } else if distributor == nil {
            var memoContent = textview.text.components(separatedBy: .newlines) // 이건 배열 타입
            let memoTitle = memoContent.remove(at: 0) //
            let memoDetail = memoContent.joined(separator: " ")
            let memoObject = MemoObject(memoTitle: memoTitle, memoDetail: memoDetail, entireMemo: textview.text)
            try! realm.write{
                realm.add(memoObject)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}

