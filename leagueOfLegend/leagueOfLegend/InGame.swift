//
//  InGame.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/04/10.
//

import UIKit

protocol PlayGame: AnyObject {
    func showGold()
    func showMinionCount()
    func showPlayTime()
    func showNexusHP()
    func showMyItem()
    func showMyOffensePower()
    func onOffAttackButton()
    func finishGame()
}

//얘가 여자친구 왜? => 데이터 변하는걸 주고싶은 애가 여자친구여야함 이게 무슨 말? => 얘는 골드도 자동 생성하고 미니언도 자동생성함. 이게 데이터가 변하는거임 그래서 이런걸 갖고 남자친구한테 "나 골드도 만들고 미니언도 만들었음 그러니까 니가 화면에 표시하셈"이라고 얘기하는 여자친구가 되는거임
class InGame {
    
    weak var delegate: PlayGame?
    
    var time: Int = 0
    var minionAlive: [Minion] {
        didSet {
            self.delegate?.onOffAttackButton()
        }
    }
    var goldTimer: Timer?
    var minionSpawnTimer: Timer?
    var timer: Timer?
    var myChampion: Champion
    var minionCount: Int?
    
    init(myChampion: Champion) {
        self.myChampion = myChampion
        self.minionAlive = []
    }
    
    var nexus: Nexus = .init()
    
    func startGame() {
        giveGoldOn3Sec()
        spawnMinionOn30sec() // 미니언 30초 마다 3마리씩 추가
        showGametime() // 게임시간 표시
        minionAlive.append(contentsOf: nexus.createMinion())
        self.delegate?.onOffAttackButton()
    }
    
    func giveGoldOn3Sec() {
        goldTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(giveGold), userInfo: nil, repeats: true)
    }
    
    @objc func giveGold() {
        myChampion.gold += 5
        print("\(myChampion.name)(이)가 초당 5의 골드를 자동으로 얻습니다.")
        print("\(myChampion.gold)골드가 있습니다.")
        // 내 남자친구가 챔피언이 가진 골드를 인게임 뷰컨의 골드 라벨에 표시한대 그러니까 나는 챔피언 한테 3초마다 5골드만 주면 됨
        self.delegate?.showGold()
    }
    

    func spawnMinionOn30sec() {
        minionSpawnTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(spawnMinion), userInfo: nil, repeats: true)
        print(minionAlive)
    }
    
    @objc func spawnMinion() {
        // createMinion 메서드가 뱉어내는 걸 array에 추가해야함
        minionAlive.append(contentsOf: nexus.createMinion())
        print("미니언이 3마리 생성되었습니다.")
        // 내 남자친구가 미니언숫자를 라벨에 표시할거임 나는 미니언이나 만들면됨!
        self.delegate?.showMinionCount()

    }
    
    func showGametime() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showMinAndSec), userInfo: nil, repeats: true)
    }
    
    @objc func showMinAndSec() {
        time += 1
        
        let minute = time / 60
        let second = time % 60
        print(String(format: "게임 시간: %02d:%02d", minute, second))
        self.delegate?.showPlayTime()
    }
    
    //아이템을 사고
//    func shopping(item: ItemList) {
//        // 나는 아이템을 존나 살거야 => 누가 내가 산 아이템 화면에 표시해줘
//        myChampion.buyItem(item: item)
//        self.delegate?.showMyItem()
//    }
    
    func shopping(item: Item) {
        // 여기서 item이 내가 선택한 아이템 이어야함
        if myChampion.gold >= item.expense {
            myChampion.itemArray.append(item)
            myChampion.offensePower += item.extraPower
            myChampion.gold -= item.expense
            print("\(myChampion.name)이 \(item.name)을 구입해 남은 골드는\(myChampion.gold) 공격력이 \(myChampion.offensePower)가 되었습니다.")
        } else {
            print("골드가 부족합니다.")
        }
        self.delegate?.showGold()
        self.delegate?.showMyItem()
        // 여기에 공격력 바뀐게 라벨에 반영되어야함
    }
    
    func champAttackMinion() {
        // 미니언 체력이 0아래로 내려가도 바로 제거되는게 아님 이거 수정해야함. 그리고 미니언이 없을때 미니언 공격 버튼 누르면 앱 충돌남
        if minionAlive[0].hp >= 0 {
            minionAlive[0].hp -= myChampion.offensePower
            print("\(myChampion.name)이 미니언을 공격해 \(myChampion.offensePower)의 데미지를 줬습니다. 미니언의 체력이 \(minionAlive[0].hp) 남았습니다")
            if minionAlive[0].hp <= 0 {
                minionAlive.remove(at: 0)
                myChampion.gold += 20
                print("챔피언이 \(myChampion.gold)를 획득했습니다.")
                print("미니언 한 마리가 처치되었습니다.")
            }
        }
        self.delegate?.showGold()
        self.delegate?.showMinionCount()
    }
    
    func champAttackNexus() {
        if nexus.hp > 0 {
            nexus.hp -= myChampion.offensePower
            print("\(myChampion.name)이 넥서스를 공격해 \(myChampion.offensePower)의 데미지를 줬습니다. 넥서스의 체력이 \(nexus.hp)남았습니다.")
            if nexus.hp <= 0 {
                gameFinished()
                pushToGameDoneVC()
                self.delegate?.finishGame()
            }
        }
        self.delegate?.showNexusHP()
    }
    
    func doAttack() {
        print("doAttack 실행됨")
        if minionAlive.count > 0 {
            champAttackMinion()
        } else if minionAlive.count == 0 {
            champAttackNexus()
        }
    }
    
    func gameFinished() {
        goldTimer?.invalidate()
        minionSpawnTimer?.invalidate()
        timer?.invalidate()
        print("게임이 끝났습니다.")
        
    }
    
    // 이건 안 넘어가는게 당연한 거임 왜냐? 이건 @objc 메서드이고, 
    func pushToGameDoneVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GameDone") as! GameDoneViewController
        vc.loadView()
        InGameViewController().navigationController?.pushViewController(vc, animated: true)
        print("마지막 화면으로 화면전환 됩니다")
    }
}
