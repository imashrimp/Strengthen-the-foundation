//
//  ViewController.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/03/30.
//

// 할거
// 1. 아이템 구입 기능 작동시키기
// 2. 미니언 공격, 넥서스 공격 버튼 설정하고 기능 구현하기 => 게임 시작 시 미니언 3마리 주기
// 이건 미니언 공격 메서드, 넥서스 공격 메서드를 따로 실행시키고 미니언 숫자가 0이냐 아니야에 따라 버튼이 active 또는 inatctive 상태로 되도록 설정하기
// 3. 넥서스 피가 0이하가 되면 마지막 스크린 불러오기

// 4. 챔피언 선택화면에서 챔피언 선택 안하고 챔피언 선택 버튼 눌렀을 때 처리하기
// 5. 소지 아이템 리스트 표시하기(대괄호 없애기)

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
    @IBOutlet weak var itemShopButton: UIButton!
    
    @IBOutlet weak var attackNexusButton: UIButton!
    @IBOutlet weak var attackMinionButton: UIButton!
    
    var inGame = InGame(myChampion: .init(name: "", hp: 0, offensePower: 0, gold: 0))
    
    
    // 여기에 라벨에 무슨 값을 설정하거나 해도 소용없음 왜 그런거?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 근데 여기서는 되네?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameTimeLabel.text = "00:00"
        minionCountLabel.text = "미니언 수: 0"
        // 이것도 짤림 레이아웃 수정 다시 하기
        nexusHPLabel.text = "넥서스 체력: \(inGame.nexus.hp)"
        itemShopButton.setTitle("상점으로 가기", for: .normal)
        itemShopButton.setTitleColor(.white, for: .normal)
        itemShopButton.backgroundColor = .black
        itemShopButton.addTarget(self, action: #selector(pushToItemShop), for: .touchUpInside)
        
        // 아래 버튼 두개도 레이아웃 재조정하기
        attackNexusButton.setTitle("넥서스 공격하기", for: .normal)
        attackNexusButton.setTitleColor(.white, for: .normal)
        attackNexusButton.backgroundColor = .black
        
        attackMinionButton.setTitle("미니언 공격하기", for: .normal)
        attackMinionButton.setTitleColor(.white, for: .normal)
        attackMinionButton.backgroundColor = .black
    }
    
    // 챔피언 선택화면에서 선택한 챔피언의 이름, 공격력, 골드 같은걸 화면에 있는 라벨에 표시할거임
    func setChampion(champion: Champion) {
        // 시뮬레이터에서 이름이 길면 짤림 수정할 것
        self.champNameLabel.text = "챔피언: \(champion.name)"
        self.champOffensePowerLabel.text = "공격력: \(champion.offensePower)"
        self.champGoldLabel.text = "골드: \(champion.gold)"
        // 배열에 있는 아이템이 '[]'없이 표시될 수 있도록 할 것
        self.champItemLabel.text = "아이템: \(champion.itemArray)"
        // 아래의 코드에서는 실제로 인스턴스를 받는 역할
        self.inGame = InGame(myChampion: champion)
        
        // 인게임 상태에 뭔가 변화가 생기면 내가 처리하겠음!
        self.inGame.delegate = self
        inGame.startGame()
    }
    
    @objc func pushToItemShop() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        print("상점으로 가기")
        // 여기서 'Could not cast value of type 'UIViewController'라는 에러가 발생하며 안 넘어가짐
        let vc = storyboard.instantiateViewController(withIdentifier: "ItemShop") as! ItemShopViewController
        vc.loadView()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func attackNexusPressed(_ sender: UIButton) {
        // 버튼이 눌려서 넥서스를 공격하고, 챔피언의 공격력 만큼 피다 닳고, 남은 넥서스의 피를 라벨에 표시하기
        // 다만 넥서스를 공격할 수 있는 조건은 미니언 숫자가 0일때 이다.
        
        //여기서는 챔피언이 지정되지 않아 공격버튼을 눌러도 넥서스 공격이 안됨
        // 너도 InGame클래스 내부에 있는 myChampion 프로퍼티가 받는 챔피언 인스턴스의 공격력을 가져와야함
        inGame.champAttackNexus()
        
        // 골드가 자동으로 올라가는 이유는? setChampion()메서드를 통해 챔피언을 받아오기 때문임 그러면 여기서도 setChampion을 통해 받아온 챔피언 인스턴스를 사용한다면?
    }
    
    @IBAction func attackMinionPressed(_ sender: UIButton) {
        // 버튼이 눌려서 미니언을 공격하고, 챔피언의 공격력 만큼 미니언의 피가 닳고, 그 미니언의 피가 0 밑으로 떨어져 죽으면 다음 미니언을 공격 할 수 있도록 할 것. 그리고 미니언 숫자가 0이 되면 넥서스 공격을 할 수 있도록 할 것
        inGame.champAttackMinion()
    }
}

// 이건 왜 있는거야? => 이게 '내 여자친구 뭐든 하셈 니가 원하는거 내가 해주겠음'의 역할
extension InGameViewController: PlayGame {
    func showGold() {
        // 현재 뷰컨에 있는 챔피언 골드 라벨에 세팅된 챔피언의 골드를 넣겠음
        self.champGoldLabel.text = "골드: \(inGame.myChampion.gold)"
        
    }
    
    func showMinionCount() {
        // 현재 뷰컨에 있는 미니언 숫자를 나타낼 라벨에 인게임 상태의 미니언 숫자를 표시하겠음
        self.minionCountLabel.text = "미니언 수: \(inGame.minionAlive.count)"
    }
    
    func showPlayTime() {
        let minute = inGame.time / 60
        let second = inGame.time % 60
        self.gameTimeLabel.text = String(format: "%02d:%02d", minute, second)
    }
    
    func showNexusHP() {
        // 넥서스 공격 받고 넥서스 피 바뀌는지 확인하면 됨
        self.nexusHPLabel.text = String(inGame.nexus.hp)
    }
}

