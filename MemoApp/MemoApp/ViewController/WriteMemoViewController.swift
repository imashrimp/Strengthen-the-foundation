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
    /// 아니면 빈 문자열로 설정
    var distributor: String?
    /// 테이블 뷰 셀의 indexPath를 전달하기 위한 프로퍼티
    var memoSequenceNumber: Int?
    /// 메모 업데이트 시 고정 메모와 일반 메모를 구분하기 위한 식별자 역할/
    var memoSectionNumber: Int?
    
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
    
    //MARK: - 테스트용
    @objc func saveMemo() {
        if distributor == "edit" {
            var memoContent = textview.text.components(separatedBy: .newlines)
            let memoTitle = memoContent.remove(at: 0) //
            let memoDetail = memoContent.joined(separator: " ")
            let memoObject = realm.objects(MemoObject.self)
            // 고정된 메모 편집
            if memoSectionNumber == 0 {
                let fixedMemObject = memoObject.where {
                    $0.isFixed == "fixed"
                }
                let fixedMemoToUpdate = fixedMemObject[memoSequenceNumber ?? 0]
                if textview.text == "" {
                    // 렐름에서 지우기
                    try! realm.write{
                        realm.delete(fixedMemoToUpdate)
                    }
                } else {
                    // 메모에 내용이 있으면 저장
                    try! realm.write{
                        fixedMemoToUpdate.memoTitle = memoTitle
                        fixedMemoToUpdate.memoDetail = memoDetail
                        fixedMemoToUpdate.entireMemo = textview.text
                    }
                }
            } else {
                let normalMemoObject = memoObject.where {
                    $0.isFixed == "none"
                }
                let normalMemoToUpdate = normalMemoObject[memoSequenceNumber ?? 0]
                if textview.text == "" {
                    // 렐름에서 지우기
                    try! realm.write{
                        realm.delete(normalMemoToUpdate)
                    }
                } else {
                    // 메모에 내용이 있으면 저장
                    try! realm.write{
                        normalMemoToUpdate.memoTitle = memoTitle
                        normalMemoToUpdate.memoDetail = memoDetail
                        normalMemoToUpdate.entireMemo = textview.text
                    }
                }
            }
            // 메모 새로 작성하는 경우
        } else if distributor == nil {
            // 이건 배열 타입
            var memoContent = textview.text.components(separatedBy: .newlines)
            let memoTitle = memoContent.remove(at: 0) //
            let memoDetail = memoContent.joined(separator: " ")
            let memoObject = MemoObject(memoTitle: memoTitle, memoDetail: memoDetail, entireMemo: textview.text, isFixed: "none")
            // 메모가 빈 경우 저장하지 않고
            if textview.text == "" {
            } else {
                //메모에 무언가 작성된 경우만 realm에 저장
                try! realm.write{
                    realm.add(memoObject)
                }
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}
