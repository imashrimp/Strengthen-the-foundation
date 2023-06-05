//
//  BoxOfficeViewModel.swift
//  movieApp
//
//  Created by 권현석 on 2023/06/05.
//

import Foundation

protocol BoxOfficeRankProtocol: AnyObject {
    var boxOfficeRankData: [DailyBoxOfficeList] { get set }
}

class BoxOfficeViewModel {
    
    var boxOfficeAPINetworking = APINetworking()
    weak var delegate: BoxOfficeRankProtocol?
//    var boxOfficeRankData: [DailyBoxOfficeList] = []
    
    init() {
        boxOfficeAPINetworking.callBoxOfficeAPI { movies in
            self.delegate?.boxOfficeRankData = movies.boxOfficeResult.dailyBoxOfficeList
            /// delegate로 viewController에 데이터 왔다고 알려주기
        }
    }
}

/// 박스오피스 뷰 컨에 데이터가 왔다고 왜 알려야 하지? 그냥 이 클래스를 뷰컨에 인스턴스 생성하면 데이터 와 있는거 아님?
/// api 호출이 비 동기로 이루어지기 때문에 delegate가 필요한 거임
/// 왜냐하면 이 뷰 모델이 뷰컨에 인스턴스 생성된 시점에 데이터 호출 완료가 안 되었을 것이기 때문
/// 그래서 델리게이트 활용하는 거고 이를 통해 생성할 테이블 뷰의 셀 갯수랑 테이블 뷰 셀의 UI에 표시할 값을 알릴 수 있음 => 아마 테이블뷰 리로드 해야될 거임
/// 델리게이트를 뭘로 할건가? 즉, 프로토콜에 들어갈 메서드가 뭐가 되어야 하는가? => 쉽게 말하면 남자친구의 조건을 만들고, 그 조건을 사용해 여자친구(해당 뷰 모델)이 뭘 할것인가?

/// 뷰 모델이 변화를 만드는 주체임 그리고 delegate를 여기서 만들고 그 delegate가 뷰컨에 가서 뷰 모델의 변화가 있다고 알려줄거임
/// 그러면 delegate에는 뭘 너어줄 것인가? => 델리게이트에 'boxOfficeRankData' 이게 들어오면 되는건가? 그러면 해당 데이터에 값이 들어갔으니까 이걸 알려줄 수 있지 않을까?
