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
        
        // 이게 왜 필요한거지? => 아마도 저장하고 불러올 때 쓰려고 한거 같은데? 여튼, 필요 없을 듯
//        textview.text = memoContentAll
        textview.backgroundColor = .white
        textview.font = .systemFont(ofSize: 20)
        textview.delegate = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = .systemOrange
        self.navigationController?.navigationBar.topItem?.title = "메모"
        
        // 공유 버튼 누르면 UIActivityViewController로 공유됨
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: nil)
        // 완료 버튼 누르면 메모가 저장되어야함 뒤로가기 버튼 눌러도 저장되어야함 (제스쳐는 화면을 좌에서 우로 swipe하는걸 말하는거 같은데 이거는 )
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveMemo))
        navigationItem.rightBarButtonItems = [shareButton, doneButton]
    }
    
    private func makeConstraints() {
        textview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
    }
    
    @objc func saveMemo() {
        if let memo =  textview.text, memo.count > 0 {
            
            var memoContent = textview.text.components(separatedBy: .newlines) // 이건 배열 타입
            let memoTitle = memoContent.remove(at: 0) //
            
            // 나중에 배열 형태가 데이터를 화면에 나타내는데 편하면 배열형태로 저장하자
            let memoDetail = memoContent.joined(separator: " ")
            let memoObject = MemoObject(memoTitle: memoTitle, memoDetail: memoDetail)
            try! realm.write{
                realm.add(memoObject)
            }
            
            self.navigationController?.popViewController(animated: true)
        } else {
            // 메모가 없는 상태에서 '확인' 버튼을 누르면 그냥 화면 전환이 되도록
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension WriteMemoViewController: UITextViewDelegate {
    
}
