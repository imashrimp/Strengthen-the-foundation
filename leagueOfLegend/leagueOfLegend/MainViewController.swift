//
//  MainViewController.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/03/30.
//

//3. 아이템 구입 메서드가 실행되도록 할 것  => 인게임 인스턴스 생성을 통한 아이템 구입 메서드 호출 시 인자로 아이템 리스트 열거형의 아이템을 받아 올 수 있도록

import Foundation

enum ChampionList {
    case jinx
    case sivir
    case ashe
    case ezreal
    case jhin
    case kaisa
    
    var champion: Champion {
        switch self {
        case .jinx:
            return .init(name: "Jinx", hp: 250, offensePower: 70, gold: 0)
        case .sivir:
            return .init(name: "Sivir", hp: 270, offensePower: 75, gold: 0)
        case .ashe:
            return .init(name: "Ashe", hp: 280, offensePower: 68, gold: 0)
        case .ezreal:
            return .init(name: "Ezreal", hp: 260, offensePower: 70, gold: 0)
        case .jhin:
            return .init(name: "Jhin", hp: 280, offensePower: 78, gold: 0)
        case .kaisa:
            return .init(name: "Kaisa", hp: 270, offensePower: 72, gold: 0)
        }
    }
}

enum ItemList {
    case longSword
    case bfSword
    case trinityForce
    case krakenSlayer
    case infinityEdge
    case bloodthirster
    
    var itemIBought: Item {
        switch self {
        case .longSword:
            return .init(expense: 200, extraPower: 10, name: "Long Sword")
        case .bfSword:
            return .init(expense: 700, extraPower: 35, name: "B.F Sword")
        case .trinityForce:
            return .init(expense: 2500, extraPower: 70, name: "Trinity Force")
        case .krakenSlayer:
            return .init(expense: 3000, extraPower: 80, name: "Kraken Slayer")
        case .infinityEdge:
            return .init(expense: 3500, extraPower: 100, name: "Infinity Edge")
        case .bloodthirster:
            return .init(expense: 3700, extraPower: 130, name: "Bloodthirster")
        }
    }
}

class Item {
    var expense: Int
    var extraPower: Int
    var name: String
    
    init(expense: Int, extraPower: Int, name: String) {
        self.expense = expense
        self.extraPower = extraPower
        self.name = name
    }
}

class Minion {
    var hp: Int
    var offensePower: Int
    var price: Int
    
    init(hp: Int, offensePower: Int, price: Int) {
        self.hp = hp
        self.offensePower = offensePower
        self.price = price
    }
}

class Champion {
    var name: String
    var hp: Int
    var offensePower: Int
    var gold: Int
    var itemArray: [Item] = [] // 아이템 갯수 제한을 줄 수 있어야함
    
    init(name: String, hp: Int, offensePower: Int, gold: Int) {
        self.name = name
        self.hp = hp
        self.offensePower = offensePower
        self.gold = gold
    }
    
    func buyItem(item: ItemList) {
        offensePower += item.itemIBought.extraPower
        gold -= item.itemIBought.expense
        itemArray.append(item.itemIBought)
        print("\(name)(이)가 \(item.itemIBought.name)을 구입했습니다. 공격력이 \(item.itemIBought.extraPower)(이)가 추가되어 \(offensePower)가 되었습니다.")
        itemArray.append(item.itemIBought)
    }
}

class Nexus {
    var hp: Int = 1000
    
    // 아래의 메서드가 일정 시간마다 실행될 수 있도록 해야함(게임 화면에서 넥서스 인스턴스를 생성 후 아래의 메서드 호출시 골드 자동 수급 메서드처럼 작동되어야 함)
    func createMinion() -> [Minion] {
        var array: [Minion] = []
        
        for _ in 0...2 {
            let minion: Minion = .init(hp: 100, offensePower: 10, price: 20)
            array.append(minion)
        }
        print("미니언 3마리가 생성되었습니다.")
        return array
    }
}

class SelectChampScreen {
    // 여기서는 챔피언 목록(열거형 ChampionList)이 불러와져야함, 챔피언 선택 버튼을 누르면 챔피언 인스턴스가 생성되어야함
    
    // 아래와 같이 프로퍼티의 타입을 옵셔널로 해주면, 챔피언 선택 화면에서 챔피언 선택 전 nil값을 갖는 myChampion이 있는 상태이고, 'selectChampion' 메서드를 실행하고 나면 선택된 챔피언이 생성되고, 이게 인게임 화면으로 넘겨져야함
    
    // 이 메서드는 'Champ'타입을 반환해야 하는가?
    // 반환해야 한다면? => 해당 메서드 실행 완료 후 인게임 화면을 구성하는 클래스의 프로퍼티 중 선택된 챔피언을 나타내기 위한 프로퍼티에 바로 그 값이 할당되어야 함
    // 반환하지 않아도 된다면? => 인게임 화면을 구성하는 클래스에서 변수에 'SelectCahmpScreen.selectChampion'과 같은 식으로 할당해야함
    
    // => 반환하는게 좋을 듯 바로 할당되면 편하니까 => 조금 더 생각해보자
//    아래 메서드가 인게임 클래스 내에서 호출되어 챔피언 타입의 프로퍼티에 할당되어야함
    func selectChampion(selected: ChampionList) -> Champion {
        var myChampion = selected.champion
        print("플레이할 챔피언은 \(myChampion.name)입니다!")
        return myChampion
    }
    
}

class InGame {
// 타임은 시간 표시 하려고 넣었었나? 이유가 기억이 안 나내?
    var time: Int
    var minionNumber: Int
    var minionAlive: [Minion] = []
    var timer: Timer?
    
    init(time: Int, minionNumber: Int) {
        self.time = time
        self.minionNumber = minionNumber
    }
    
    //    챔피언 인스턴스가 하나 있겠지? 왜냐하면 챔피언을 고르고 게임을 시작한 상태가 인게임 상태이니까 => 근데 이 챔피언이 'SelectChampScreen' 클래스의 'selectChampion'에 의해 만들어진 챔피언이야 함
// myChampion은 징크스다
    var nexus: Nexus = .init()
    var myChampion = SelectChampScreen().selectChampion(selected: .jinx)

    
    func startGameTime() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(giveGold), userInfo: nil, repeats: true)
    }
    
    @objc func giveGold() {
        // 챔피언의 골드를 받아와서 +5 씩 주자
        myChampion.gold += 5
        print("\(myChampion.name)(이)가 초당 5의 골드를 자동으로 얻습니다.")
        // 뭔가 골드가 totalgold이런게 있어야 할거 같은 느낌이 드는데 한편으로는 jinx.gold가 징크스 라는 챔피언의 지갑? 같은 개념이라서 괜찮을거 같기도?
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
        print("미니언이 3마리 생성되었습니다.")
    }
    
    func countMinionNumber() {
        minionNumber = minionAlive.count
        print("미니언이 \(minionNumber)마리가 있습니다")
    }
    
    //아이템을 사고
    func shopping(item: ItemList) {
        myChampion.buyItem(item: item)
    }
    
    func showMyStatus() {
        print("\(myChampion.name)(은)는 \(myChampion.gold)를 갖고 있고, 공격력은\(myChampion.offensePower)이며, 아이템으로 \(myChampion.itemArray)를 갖고 있습니다.")
    }
    
//    => 'champAttackMinion'와 'champAttackNexus'는 공격하기 버튼을 누르면 작동
    func champAttackMinion() {
        // 이 메서드의 실행 조건은 'if minionAlive != 0 { .champAttackMinion }' 이렇게 되어야함
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
        // 이 함수의 실행 조건은 ' if minionAlive == 0 { .cahmpAttack. }'이렇게 되어야함
        nexus.hp -= myChampion.offensePower
        print("\(myChampion.name)이 넥서스를 공격해 \(myChampion.offensePower)의 데미지를 줬습니다. 넥서스의 체력이 \(nexus.hp)남았습니다.")
    }
    
    func gameFinished() {
        // 넥서스 체력이 0이 되면 시간이 멈추고 게임이 끝났다는 화면이 떠야함
        // 제어문 같은거(아마 챔피언의 공격 메서드 내부의 제어문 일듯?)에서 'if nexus.hp < 0 { .gameFinished() }'로 이 메서드가 호출 될 듯 => 이 메서드는 꼭 여기에 위치할 필요가 없음
        // 시간이 멈춰야겠지?
        timer?.invalidate()
        print("게임이 끝났습니다.")
    }
}
