//
//  ViewController.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/03/30.
//

import UIKit


// 얘가 여자친구가 아니라 남자친구 왜? => 여자친구가 데이터에 변화를 주면 남자친구가 그 변화를 적용시킴
class InGameViewController: UIViewController {
    
    @IBOutlet weak var gameTimeLabel: UILabel!
    @IBOutlet weak var champNameLabel: UILabel!
    @IBOutlet weak var champOffensePowerLabel: UILabel!
    @IBOutlet weak var champGoldLabel: UILabel!
    @IBOutlet weak var champItemLabel: UILabel!
    @IBOutlet weak var minionCountLabel: UILabel!
    @IBOutlet weak var nexusHPLabel: UILabel!
    
    var inGame = InGame(myChampion: .init(name: "", hp: 0, offensePower: 0, gold: 0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 챔피언 선택화면에서 선택한 챔피언의 이름, 공격력, 골드 같은걸 화면에 있는 라벨에 표시할거임
    func setChampion(champion: Champion) {
        self.champNameLabel.text = champion.name
        self.champOffensePowerLabel.text = String(champion.offensePower)
        self.champGoldLabel.text = String(champion.gold)
        
        // 아래의 코드는 이전에 챔피언 선택 화면에서 챔피언 인스턴스를 버튼을 누르면서 생성했기 때문에 필요 없는거 아님?
//        self.inGame = InGame(myChampion: champion)
        
        // 인게임 상태에 뭔가 변화가 생기면 내가 처리하겠음!
        // 아래의 코드를 비활성화 하니까 골드 자동생성이 반영되지 않음 => 'setChampion'메서드는 버튼 눌렸을 때 한 번 실행됨
        self.inGame.delegate = self
        inGame.startGame()
    }
}

// 이건 왜 있는거야? => 이게 '내 여자친구 뭐든 하셈 니가 원하는거 내가 해주겠음'의 역할
extension InGameViewController: PlayGame {
    func showGold() {
        // 현재 뷰컨에 있는 챔피언 골드 라벨에 세팅된 챔피언의 골드를 넣겠음
        self.champGoldLabel.text = String(inGame.myChampion.gold)
    }
    
    func showMinionCount() {
        // 현재 뷰컨에 있는 미니언 숫자를 나타낼 라벨에 인게임 상태의 미니언 숫자를 표시하겠음
        self.minionCountLabel.text = String(inGame.minionAlive.count)
    }
    
    
}

