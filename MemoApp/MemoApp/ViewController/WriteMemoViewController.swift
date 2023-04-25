//
//  WriteMemoViewController.swift
//  MemoApp
//
//  Created by 권현석 on 2023/04/24.
//

// 메모 작성 또는 수정으로 해당 화면이 불러와져야함

import UIKit
import SnapKit

class WriteMemoViewController: UIViewController {
    
    let textview: UITextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubeViews()
        configure()
        makeConstraints()

    }
    
    private func addSubeViews() {
        self.view.addSubview(textview)
    }

    private func configure() {
        self.view.backgroundColor = .black
        
        self.navigationController?.navigationBar.tintColor = .systemOrange
        // 이거 타이틀 나중에 바꿔야함 검색을 통해 들어오면 "검색", 나머지는 "메모"
        self.navigationController?.navigationBar.topItem?.title = "메모"

        // 이 두 버튼 텍스트 뷰 터치해야 생기도록 바꿔야함
        // 공유 버튼 누르면 UIActivityViewController로 공유됨
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: nil)
        // 완료 버튼 누르면 메모가 저장되어야함 뒤로가기 버튼 눌러도 저장되어야함 (제스쳐는 화면을 좌에서 우로 swipe하는걸 말하는거 같은데 이거는 )
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems = [shareButton, doneButton]
        
        textview.backgroundColor = .black
        textview.textColor = .white
        textview.font = .systemFont(ofSize: 14)
    }
    
    private func makeConstraints() {
        textview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
    }
}
