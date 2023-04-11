//
//  InGame.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/04/10.
//

import Foundation

protocol PlayGame: AnyObject {
    func showGold()
    func showMinionCount()
}

//얘가 여자친구 왜? => 데이터 변하는걸 주고싶은 애가 여자친구여야함 이게 무슨 말? => 얘는 골드도 자동 생성하고 미니언도 자동생성함. 이게 데이터가 변하는거임 그래서 이런걸 갖고 남자친구한테 "나 골드도 만들고 미니언도 만들었음 그러니까 니가 화면에 표시하셈"이라고 얘기하는 여자친구가 되는거임
// 얘가 프로토콜을 채택해야하는 이유가 있음? => 없어도 잘 작동하는데?
class InGame {
    
    weak var delegate: PlayGame?
    
    var time: Int = 0
    var minionNumber: Int = 0
    var minionAlive: [Minion] = []
    var timer: Timer?
    var myChampion: Champion
    
    init(myChampion: Champion) {
        self.myChampion = myChampion
    }
    
    var nexus: Nexus = .init()
    
    func startGame() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(giveGold), userInfo: nil, repeats: true)
        showGametime()
        spawnMinionOn30sec()
    }
    
    @objc func giveGold() {
        myChampion.gold += 5
        print("\(myChampion.name)(이)가 초당 5의 골드를 자동으로 얻습니다.")
        print("\(myChampion.gold)골드가 있습니다.")
        // 내 남자친구가 챔피언이 가진 골드를 인게임 뷰컨의 골드 라벨에 표시한대 그러니까 나는 챔피언 한테 3초마다 5골드만 주면 됨
        self.delegate?.showGold()
    }
    
    // 여기서 확인해야 될게 미이언이 생성되고 30초마다 미니언 배열에 요소로 미니언이 3마리씩 들어가는지 확인
    func spawnMinionOn30sec() {
        // 이렇게 하면 타이머가 겹치거나 충돌이 일어나지 않는가?
        timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(spawnMinion), userInfo: nil, repeats: true)
        print(minionAlive)
    }
    
    @objc func spawnMinion() {
        // createMinion 메서드가 뱉어내는 걸 array에 추가해야함
        minionAlive.append(contentsOf: nexus.createMinion())
        //이건 아마 미니언 누적 수 표현을 위한 메서드 인듯?
        minionNumber = minionAlive.count
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
    }
    
//    func countMinionNumber() {
//        minionNumber = minionAlive.count
//        print("미니언이 \(minionNumber)마리가 있습니다")
//    }
    
    //아이템을 사고
    func shopping(item: ItemList) {
        myChampion.buyItem(item: item)
    }
    
    // 아이템 배열을 콘솔에 프린트 할 수 있는 방법?
    func showMyStatus() {
        print("\(myChampion.name)(은)는 \(myChampion.gold)를 갖고 있고, 공격력은 \(myChampion.offensePower)이며, 아이템으로 \(myChampion.itemArray)를 갖고 있습니다.")
    }
    
    //    => 'champAttackMinion'와 'champAttackNexus'는 공격하기 버튼을 누르면 작동
    
    func champAttackMinion() {
        print("champAttackMinion 실행됨")
        // 이 메서드의 실행 조건은 'if minionAlive.count != 0 { .champAttackMinion }' 이렇게 되어야함
        if minionAlive[0].hp >= 0 {
            minionAlive[0].hp -= myChampion.offensePower
            print("\(myChampion.name)이 미니언을 공격해 \(myChampion.offensePower)의 데미지를 줬습니다. 미니언의 체력이 \(minionAlive[0].hp) 남았습니다")
        } else {
            minionAlive.remove(at: 0)
            myChampion.gold += 20
            print("미니언 한 마리가 처치되었습니다.")
        }
    }
    
    func champAttackNexus() {
        print("champAttackNexus 실행됨!")
        // 이 함수의 실행 조건은 ' if minionAlive.count == 0 { .cahmpAttack. }'이렇게 되어야함
        if nexus.hp > 0 {
            nexus.hp -= myChampion.offensePower
            print("\(myChampion.name)이 넥서스를 공격해 \(myChampion.offensePower)의 데미지를 줬습니다. 넥서스의 체력이 \(nexus.hp)남았습니다.")
        } else {
            gameFinished()
        }
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
        // 넥서스 체력이 0이 되면 시간이 멈추고 게임이 끝났다는 화면이 떠야함
        // 제어문 같은거(아마 챔피언의 공격 메서드 내부의 제어문 일듯?)에서 'if nexus.hp < 0 { .gameFinished() }'로 이 메서드가 호출 될 듯 => 이 메서드는 꼭 여기에 위치할 필요가 없음
        timer?.invalidate()
        print("게임이 끝났습니다.")
    }
}
