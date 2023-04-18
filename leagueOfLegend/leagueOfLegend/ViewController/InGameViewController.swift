//
//  ViewController.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/03/30.
//

// 할거
// 1. 아이템 구입 기능 작동시키기
// 2. 넥서스 피가 0이하가 되면 마지막 스크린 불러오기
// 3. 이건 미니언 공격 메서드, 넥서스 공격 메서드를 따로 실행시키고 미니언 숫자가 0이냐 아니야에 따라 버튼이 active 또는 inatctive 상태로 되도록 설정하기

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameTimeLabel.text = "00:00"
        minionCountLabel.text = "미니언 수: 0"
        nexusHPLabel.text = "넥서스 체력: \(inGame.nexus.hp)"
        itemShopButton.setTitle("상점으로 가기", for: .normal)
        itemShopButton.setTitleColor(.white, for: .normal)
        itemShopButton.backgroundColor = .black
        itemShopButton.addTarget(self, action: #selector(pushToItemShop), for: .touchUpInside)
        
        attackNexusButton.setTitle("넥서스 공격하기", for: .normal)
        attackNexusButton.setTitleColor(.white, for: .normal)
        attackNexusButton.backgroundColor = .black
        
        attackMinionButton.setTitle("미니언 공격하기", for: .normal)
        attackMinionButton.setTitleColor(.white, for: .normal)
        attackMinionButton.backgroundColor = .black
        // 미니언이 게임 실행 시 최초로 생성된 미니언 표시를 하기 위함. 처음에 바로 3마리를 주는 이유는 게임 시작하자마자 넥서스 공격을 할 수 없게 하려고
        showMinionCount()
    }
    
    // 챔피언 선택화면에서 선택한 챔피언의 이름, 공격력, 골드 같은걸 화면에 있는 라벨에 표시할거임
    // 이 메서드가 챔피언 선택화면에서 실행된 이후로 inGame.myChampion은 선택한 챔피언 인스턴스를 가짐
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
        let vc = storyboard.instantiateViewController(withIdentifier: "ItemShop") as! ItemShopViewController
        vc.loadView()
        vc.inGame = self.inGame
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func attackNexusPressed(_ sender: UIButton) {
        inGame.champAttackNexus()
    }
    
    @IBAction func attackMinionPressed(_ sender: UIButton) {
        inGame.champAttackMinion()
    }
}

// 이건 왜 있는거야? => 이게 '내 여자친구야 뭐든 하셈 니가 원하는거 내가 해주겠음'의 역할
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
        self.nexusHPLabel.text = "넥서스 체력: \(inGame.nexus.hp)"
    }
    
    func showMyItem() {
        self.champItemLabel.text = "아이템: \(inGame.myChampion.itemArray[0].name)"
    }
    
    func showMyOffensePower() {
        self.champOffensePowerLabel.text = "공격력: \(inGame.myChampion.offensePower)"
    }
    
    // 이게 제대로 작동이 안 됨
    func onOffAttackButton() {
        if inGame.minionAlive.count > 0 {
            attackMinionButton.isEnabled = true
            attackNexusButton.isEnabled = false
        } else {
            attackMinionButton.isEnabled = false
            attackNexusButton.isEnabled = true
        }
    }
    
    func finishGame() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GameDone") as! GameDoneViewController
        vc.loadView()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

