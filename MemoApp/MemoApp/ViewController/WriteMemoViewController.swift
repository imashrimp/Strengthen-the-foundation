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
    var memoSequenceNumber: Int?
    
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
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }

    // UITextViewDelegate을 통해 textDidChange()메서드를 통해 저장하고, 업데이트 하면 아래의 메서드는 그냥 pop역할만 하도록 한다.
    @objc func saveMemo() {
        
        if distributor == "edit" {
            var memoContent = textview.text.components(separatedBy: .newlines) // 이건 배열 타입

            let memoTitle = memoContent.remove(at: 0) //
            // 나중에 배열 형태가 데이터를 화면에 나타내는데 편하면 배열형태로 저장하자
            let memoDetail = memoContent.joined(separator: " ")
            
            let memoObject = realm.objects(MemoObject.self)
            let memoToUpdate = memoObject[memoSequenceNumber ?? 0]
            
            try! realm.write{
                memoToUpdate.memoTitle = memoTitle
                memoToUpdate.memoDetail = memoDetail
            }
            
        } else if distributor == nil { // ** 주의 => 해당 뷰컨 선언 시 distributor를 옵셔널 타입으로 설정했는데, (거의 이건 nil 일거임) nil이 아닐 수 있으니 브레이크 포인트 걸어서 '새 메모 작성'의 경우 distributor의 값 확인해보기
            // 여기서는 새로운 메모를 작성하기 위한 로직 작성 => 이전에 '완료'버튼에서 작성된 로직 그대로 작성하면 됨
            var memoContent = textview.text.components(separatedBy: .newlines) // 이건 배열 타입
            let memoTitle = memoContent.remove(at: 0) //
            
            // 나중에 배열 형태가 데이터를 화면에 나타내는데 편하면 배열형태로 저장하자
            let memoDetail = memoContent.joined(separator: " ")
            let memoObject = MemoObject(memoTitle: memoTitle, memoDetail: memoDetail)
            try! realm.write{
                realm.add(memoObject)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension WriteMemoViewController: UITextViewDelegate {
    
}
