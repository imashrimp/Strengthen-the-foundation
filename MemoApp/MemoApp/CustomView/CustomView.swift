//
//  CustomView.swift
//  MemoApp
//
//  Created by 권현석 on 2023/04/21.
//

import UIKit

class CustomView: UIView {
    
    let memoCountLabel: UILabel = {
       let label = UILabel()
        //MARK: - lable.text의 값이 아마도 나중에 어떤 연산에 의해 바뀔거임
        // 'NumberFormatter'를 사용해 숫자의 3자리 마다 콤마(,)찍기
        label.text = "0개의 메모"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 35, weight: .bold)
        return label
    }()
}
