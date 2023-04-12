//
//  MainViewController.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/03/30.
//

//3. 아이템 구입 메서드가 실행되도록 할 것  => 인게임 인스턴스 생성을 통한 아이템 구입 메서드 호출 시 인자로 아이템 리스트 열거형의 아이템을 받아 올 수 있도록

import Foundation

enum ChampionList: CaseIterable {
    case jinx
    case sivir
    case ashe
    case ezreal
    case jhin
    case kaisa
    
    var champion: Champion {
        switch self {
        case .jinx:
            return .init(name: "징크스", hp: 250, offensePower: 70, gold: 0)
        case .sivir:
            return .init(name: "시비르", hp: 270, offensePower: 75, gold: 0)
        case .ashe:
            return .init(name: "애쉬", hp: 280, offensePower: 68, gold: 0)
        case .ezreal:
            return .init(name: "이즈리얼", hp: 260, offensePower: 70, gold: 0)
        case .jhin:
            return .init(name: "진", hp: 280, offensePower: 78, gold: 0)
        case .kaisa:
            return .init(name: "카이사", hp: 270, offensePower: 72, gold: 0)
        }
    }
}

enum ItemList: CaseIterable {
    case longSword
    case bfSword
    case trinityForce
    case krakenSlayer
    case infinityEdge
    case bloodthirster
    
    var itemIBought: Item {
        switch self {
        case .longSword:
            return .init(expense: 200, extraPower: 10, name: "롱소드")
        case .bfSword:
            return .init(expense: 700, extraPower: 35, name: "BF 대검")
        case .trinityForce:
            return .init(expense: 2500, extraPower: 70, name: "삼위일체")
        case .krakenSlayer:
            return .init(expense: 3000, extraPower: 80, name: "크라켄 학살자")
        case .infinityEdge:
            return .init(expense: 3500, extraPower: 100, name: "무한의 대검")
        case .bloodthirster:
            return .init(expense: 3700, extraPower: 130, name: "피바라기")
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
    
//    func buyItem(item: ItemList) {
//        if gold >= item.itemIBought.expense {
//            itemArray.append(item.itemIBought)
//            offensePower += item.itemIBought.extraPower
//            gold -= item.itemIBought.expense
//            print("\(name)(이)가 \(item.itemIBought.name)을 구입했습니다. 공격력이 \(item.itemIBought.extraPower)(이)가 추가되어 \(offensePower)가 되었습니다.")
//        } else {
//            print("골드가 부족합니다")
//        }
//    }
    
//    func buyItem(item: Item) {
//        if gold >= item.expense {
//            itemArray.append(item)
//            offensePower += item.extraPower
//            gold -= item.expense
//        } else {
//            print("골드가 부족합니다.")
//        }
//    }
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
    
    // 이 메서드는 'Champ'타입을 반환해야 하는가?
    // 반환해야 한다면? => 해당 메서드 실행 완료 후 인게임 화면을 구성하는 클래스의 프로퍼티 중 선택된 챔피언을 나타내기 위한 프로퍼티에 바로 그 값이 할당되어야 함
    // 반환하지 않아도 된다면? => 인게임 화면을 구성하는 클래스에서 변수에 'SelectCahmpScreen.selectChampion'과 같은 식으로 할당해야함
    
    // => 반환하는게 좋을 듯 바로 할당되면 편하니까 => 조금 더 생각해보자
//    아래 메서드가 인게임 클래스 내에서 호출되어 챔피언 타입의 프로퍼티에 할당되어야함
    func selectChampion(selected: ChampionList) -> Champion {
        let myChampion = selected.champion
        print("플레이할 챔피언은 \(myChampion.name)입니다!")
        return myChampion
    }
    
}

