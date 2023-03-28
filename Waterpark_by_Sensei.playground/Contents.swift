// foundation, uikit 차이 찾아보기
import Foundation

//MARK: - 프로토콜 모음

// 프로토콜 익스텐션 관련해서 질문
protocol Material {
    var percent: Int { get set }
    var color: String { get set }
    var waterproof: Bool { get set }
}

extension Material {
    var waterproof: Bool {
        get {
            return self.waterproof
        }
        set {
            self.waterproof = newValue
        }
    }
}

protocol ChargeFacilities {
    var body: Material { get set }
    var clerk: String { get set }
    
    func totalRevenue(visitorNumber: Int) -> Int
}

protocol FreeFacilities {
    var body: Material { get set }
    var clerk: String { get set }
}

protocol Attraction {
    var isClear: Bool? { get set }
//    var lifeGuardType: String { get set }
    var tube: Bool? { get set }
    var power: Bool? { get set }
//    var lifeGuardNumber: Int { get set }
    var lifeGuard: InfoOfLifeGuard { get set }
    
    // 전원과 튜브의 유무에 따라 메세지를 보내고 어트렉션에 몇 명이 해당 어트렉션을 탑승 중이며 몇 명의 안전요원이 근무중인지 알리기 위한 메서드
    func boardRides(power: Bool, tube: Bool, visitorNumber: Int, lifeGuard: LifeGuardType)
    func changeWater(isClear: Bool)
}

//MARK: - 재료

class Plastic: Material {
    var percent: Int
    var color: String
    var waterproof: Bool
    
    init(percent: Int, color: String, waterproof: Bool) {
        self.percent = percent
        self.color = color
        self.waterproof = waterproof
    }
}

class Cotton: Material {
    var percent: Int
    var color: String
    var waterproof: Bool
    
    init(percent: Int, color: String, waterproof: Bool) {
        self.percent = percent
        self.color = color
        self.waterproof = waterproof
    }
}

class Wood: Material {
    var percent: Int
    var color: String
    var waterproof: Bool
    
    init(percent: Int, color: String, waterproof: Bool) {
        self.percent = percent
        self.color = color
        self.waterproof = waterproof
    }
}

class Steel: Material {
    var percent: Int
    var color: String
    var waterproof: Bool
    
    init(percent: Int, color: String, waterproof: Bool) {
        self.percent = percent
        self.color = color
        self.waterproof = waterproof
    }
}

class RamenInfo {
    var price: Int
    var ingredient: String
    var spicyLevel: Int
    
    init(price: Int, ingredient: String, spicyLevel: Int) {
        self.price = price
        self.ingredient = ingredient
        self.spicyLevel = spicyLevel
    }
}

class InfoOfLifeGuard {
    var attraction: String
    var numberOfLifeGuard: Int
    
    init(attraction: String, numberOfLifeGuard: Int) {
        self.attraction = attraction
        self.numberOfLifeGuard = numberOfLifeGuard
    }
}
//MARK: - 열거형

enum RamenType {
    case normal
    case cheongyang
    case ghostpepper
    
    var ramenInfo: RamenInfo {
        switch self {
        case .normal:
            // 튜플을 사용하면 더 쉽게 나타낼 수 있나?
            return RamenInfo(price: 4000, ingredient: "red pepper", spicyLevel: 2)
        case .cheongyang:
            return RamenInfo(price: 4300, ingredient: "cheongyang", spicyLevel: 5)
        case .ghostpepper:
            return RamenInfo(price: 4500, ingredient: "ghost pepper", spicyLevel: 8)
        }
    }
}

enum MaterialGroup {
    case steel
    case wood
    case plastic
    case cotton
    
    var material: Material {
        switch self {
        case .steel:
            return Steel(percent: 100, color: "steel", waterproof: true)
        case .wood:
            return Wood(percent: 100, color: "light-brown", waterproof: true)
        case .plastic:
            return Plastic(percent: 100, color: "cobalt-blue", waterproof: true)
        case .cotton:
            return Cotton(percent: 100, color: "sky-blue", waterproof: true)
        }
    }
}

enum LifeGuardType {
    case lifeGuardForWavePool
    case lifeGuardForLazyRiver
    case lifeGuardForWaterSlide
    
    var lifeGuardInfo: InfoOfLifeGuard {
        switch self {
        case .lifeGuardForWavePool:
            return InfoOfLifeGuard(attraction: "파도풀 안전요원", numberOfLifeGuard: 4)
        case .lifeGuardForLazyRiver:
            return InfoOfLifeGuard(attraction: "유수풀 안전요원", numberOfLifeGuard: 8)
        case .lifeGuardForWaterSlide:
            return InfoOfLifeGuard(attraction: "워터슬라이드 안전요원", numberOfLifeGuard: 4)
        }
    }
}
//MARK: - 편의 시설
// 편의시설을 수익이 나는 시설과 아닌 시설로 구분했고, 탈의실은 수익이 나지 않는 편의시설임
class ChangingRoom: FreeFacilities {
    var body: Material
    var locker: Material
    var clothes: Material
    var clerk: String = "Manager"
    var totalLocker: Int = 70
    
    init(body: MaterialGroup, locker: MaterialGroup, clothes: MaterialGroup) {
        self.body = body.material
        self.locker = locker.material
        self.clothes = clothes.material
    }
    
    func summaryVancancy(visitorNumber: Int) {
        let emptyLocker = self.totalLocker - visitorNumber
        if emptyLocker >= 1 {
            print("\(clerk): 남은 라커의 수는 \(emptyLocker)입니다!")
        } else if emptyLocker == 0 {
            print("\(clerk): 라커가 꽉 찼습니다!")
        } else {
            print("\(clerk): 라커가 모자랍니다!")
        }
    }
}

class TicketBox: ChargeFacilities {
    var body: Material
    var ticketPrice: Int = 8000
    var clerk: String = "Ticket Man"
    var totalMoney: Int = 0
    
    init(body: MaterialGroup) {
        self.body = body.material // wood, steel, plastic, cotton 중 하나를 인스턴스 생성 시 고를 수 있음
    }
    
    // 이용객이 티켓맨에서 돈을 내고 이용객 수 만큼 totalMoney를 가진다
    // 여기서 더 발전하려면 함수에서 파라미터로 연령대별 이용객(어린이, 성인, 노인)이렇게 나누고, 클래스에 연령대별 티켓값을 프로퍼터로 각각 생성해야함
    func totalRevenue(visitorNumber: Int) -> Int {
        //         어린이, 청소년, 성인 각각의 ticketPrice에 따른 totalMoney 구하기
        self.totalMoney = ticketPrice * visitorNumber
        return totalMoney
    }
}

class SnackBar: ChargeFacilities {
    var body: Material
    var clerk: String = "Snack Boy"
    
    init(body: MaterialGroup) {
        self.body = body.material
    }
    
    func totalRevenue(visitorNumber visitorNum: Int) -> Int {
        let cheongyangRevenue = RamenType.cheongyang.ramenInfo.price
        let totalMoney = cheongyangRevenue * visitorNum
        return totalMoney
    }
}

//MARK: - 어트렉션

class WavePool: Attraction {
//    var lifeGuardType: String = "파도풀 안전요원"
    var lifeGuardNumber: Int = 4
    var isClear: Bool?
    var tube: Bool?
    var power: Bool?
    var lifeGuard: InfoOfLifeGuard
    
    init(lifeGuard: LifeGuardType) {
        self.lifeGuard = lifeGuard.lifeGuardInfo
    }
    
    func boardRides(power: Bool, tube: Bool, visitorNumber: Int, lifeGuard: LifeGuardType) {
        if power == true, tube == true {
            print("\(visitorNumber)명이 파도풀을 이용중이며, \(lifeGuard.lifeGuardInfo.attraction) \(lifeGuard.lifeGuardInfo.numberOfLifeGuard)명이 근무 중입니다.")
        } else if power == true, tube == false {
            print("튜브가 없는 이용자는 파도풀에 입장 할 수 없습니다.")
        } else {
            print("파도풀이 작동하지 않습니다.")
        }
    }
    
    func changeWater(isClear: Bool) {
        if isClear == false {
            print("파도풀의 물을 교체하고 있습니다")
        } else {
            print("파도풀의 물이 깨끗합니다.")
        }
    }
}

//let wavePool1 :WavePool = .init(lifeGuard: .lifeGuardForWavePool)
//print(wavePool1.lifeGuard.attraction)
//wavePool1.boardRides(power: true, tube: true, visitorNumber: 80, lifeGuard: .lifeGuardForWavePool)

class LazyRiver: Attraction {
    var lifeGuard: InfoOfLifeGuard
//    var lifeGuardType: String = "유수풀 안전요원"
//    var lifeGuardNumber: Int = 8
    var isClear: Bool?
    var tube: Bool?
    var power: Bool?
    
    init(lifeGuard: LifeGuardType) {
        self.lifeGuard = lifeGuard.lifeGuardInfo
    }
    
    func boardRides(power: Bool, tube: Bool, visitorNumber: Int, lifeGuard: LifeGuardType) {
        if power == true, tube == true {
            print("\(visitorNumber)명이 유수풀을 이용중이며, \(lifeGuard.lifeGuardInfo.attraction) \(lifeGuard.lifeGuardInfo.numberOfLifeGuard)명이 근무 중입니다.")
        } else if power == true, tube == false {
            print("튜브가 없는 이용자는 유수풀에 입장 할 수 없습니다.")
        } else {
            print("유수풀이 작동하지 않습니다.")
        }
    }
    
    func changeWater(isClear: Bool) {
        if isClear == false {
            print("유수풀의 물을 교체하고 있습니다")
        } else {
            print("유수풀의 물이 깨끗합니다.")
        }
    }
}

class WaterSlide: Attraction {
    var lifeGuard: InfoOfLifeGuard
//    var lifeGuardType: String = "워터슬라이드 안전요원"
//    var lifeGuardNumber: Int = 4
    var isClear: Bool?
    var tube: Bool?
    var power: Bool?
    
    init(lifeGuard: LifeGuardType) {
        self.lifeGuard = lifeGuard.lifeGuardInfo
    }
    
    
    func boardRides(power: Bool, tube: Bool, visitorNumber: Int, lifeGuard: LifeGuardType) {
        if power == true, tube == true {
            print("\(visitorNumber)명이 워터슬라이드 이용을 위해 대기중이며, \(lifeGuard.lifeGuardInfo.attraction) \(lifeGuard.lifeGuardInfo.numberOfLifeGuard)명이 근무 중입니다.")
        } else if power == true, tube == false {
            print("튜브가 없는 이용자는 워터슬라이드를 사용할 수 없습니다.")
        } else {
            print("워터슬라이드가 작동하지 않습니다.")
        }
    }
    
    func changeWater(isClear: Bool) {
        if isClear == false {
            print("워터슬라이드의 물을 교체하고 있습니다")
        } else {
            print("워터슬라이드의 물이 깨끗합니다.")
        }
    }
}


//MARK: - 워터파크 클래스
// 시설에서 얻은 수익을 총 합계내는 함수를 워터파크 클래스 내부에 만들어 보자
class WaterPark {
    let visitorNumber = 70
    let snackBar : SnackBar = .init(body: .steel)
    let changingRoom: ChangingRoom = .init(body: .wood, locker: .wood, clothes: .cotton)
    let ticketBox: TicketBox = .init(body: .steel)

    let wavePool: WavePool = .init(lifeGuard: .lifeGuardForWavePool)
    let lazyRiver: LazyRiver = .init(lifeGuard: .lifeGuardForLazyRiver)
    let waterSlide: WaterSlide = .init(lifeGuard: .lifeGuardForWaterSlide)

    func calcTotalMoney(completion: @escaping (Int) -> Void) -> Int {
        let totalRevenue = ticketBox.totalRevenue(visitorNumber: visitorNumber) + snackBar.totalRevenue(visitorNumber: visitorNumber)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(totalRevenue)
        }
        return totalRevenue
    }

    // 라커 사용현황 알람을 위한 메서드
    func alarmEmptyLockers() {
        changingRoom.summaryVancancy(visitorNumber: visitorNumber)
    }

    func checkWater(waterQuality: Bool) {
        if waterQuality == true {
            wavePool.changeWater(isClear: waterQuality)
            lazyRiver.changeWater(isClear: waterQuality)
            waterSlide.changeWater(isClear: waterQuality)
        } else {
            wavePool.changeWater(isClear: waterQuality)
            lazyRiver.changeWater(isClear: waterQuality)
            waterSlide.changeWater(isClear: waterQuality)
        }
    }

    // 각 어트렉션별 전원상태와 이용자의 튜브소지 여부에 따른 어트렉션별 이용자 및 안전요원 수 현황과 경고문구 나타내기 위한 메서드
    func runAttraction(power: Bool, tube: Bool) {
        if power == true, tube == true {
            wavePool.boardRides(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuard: .lifeGuardForWavePool)
            lazyRiver.boardRides(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuard: .lifeGuardForLazyRiver)
            waterSlide.boardRides(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuard: .lifeGuardForWaterSlide)
        } else if power == true, tube == false {
            wavePool.boardRides(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuard: .lifeGuardForWavePool)
            lazyRiver.boardRides(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuard: .lifeGuardForLazyRiver)
            waterSlide.boardRides(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuard: .lifeGuardForWaterSlide)
        } else {
            wavePool.boardRides(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuard: .lifeGuardForWavePool)
            lazyRiver.boardRides(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuard: .lifeGuardForLazyRiver)
            waterSlide.boardRides(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuard: .lifeGuardForWaterSlide)
        }
    }
}

// 이제 Escaping closure를 사용해서
let myWaterpark: WaterPark = .init()
myWaterpark.calcTotalMoney { totalRevenue in
    print("오늘 총 수익은 \(totalRevenue)원 입니다!")
}
myWaterpark.checkWater(waterQuality: false)
myWaterpark.alarmEmptyLockers()
myWaterpark.runAttraction(power: true, tube: true)
