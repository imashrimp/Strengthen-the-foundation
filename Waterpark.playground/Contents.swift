// foundation, uikit 차이 찾아보기
import Foundation

//MARK: - 프로토콜 모음

// @objc 키워드를 붙여줌으로써 '@objc option' 키워드가 붙은 프로토콜을 사용해 해당 프로토콜을 채택하는 클래스에서 선택적으로 사용할 수 있는 프로퍼티를 생성함 => 해당 키워드를 사용한 프로토콜은 클래스에서만 채택가능
@objc protocol Material {
    var percent: Int { get set }
    var color: String { get set }
    @objc optional var waterproof: Bool { get set }
}

protocol Facilities {
    var body: Material { get set }
    var clerk: String { get set }
    
    //⭐️ 이 프로토콜의 경우 함수가 리턴 타입이 있는 경우와 없는 경우 두 가지로 나뉘는데 이때 '@objc'키워드 사용하니까 경고 메세지가 뜨더라 안 뜨게 하는 방법이 있는가?
      func runIt(visitorNumber: Int) -> Int
}

protocol Attraction {
    //    var water: Bool { get set }  // 물이 깨끗한가 아닌가로 해서 물을 가는 함수생성?
    //    lifeGuard와 visitor의 특성을 설정 할 프로토콜이던 열거형이던 하나를 만들어서 설정해볼까? => lifeGuardForWavePool이렇게
    var tube: Bool? { get set } // 유무에 따라 true false
    var power: Bool? { get set }
    
    // 전원과 튜브의 유무에 따라 메세지를 보내고 어트렉션에 몇 명이 해당 어트렉션을 탑승 중이며 몇 명의 안전요원이 근무중인지 알리기 위한 메서드
    func play(power: Bool, tube: Bool, visitorNumber: Int, lifeGuardNumber: Int)
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

class Flour: Material {
    var percent: Int
    var color: String = "white"
    
    init(percent: Int) {
        self.percent = percent
    }
}

class Rice: Material {
    var percent: Int
    var color: String = "white"
    
    init(percent: Int) {
        self.percent = percent
    }
}

class Sauce: Material {
    var percent: Int
    var color: String = "red"
    var chiliType: String
    
    init(chiliType: String, percent: Int) {
        self.chiliType = chiliType
        self.percent = percent
    }
    
}


//MARK: - 열거형

// 라면의 맵기를 나타내기 위한 열거형
enum HotLevel {
    case mild
    case spicy
    case crazy
    
    var hotLevel: Material {
        switch self {
        case .mild:
            return Sauce(chiliType: "청양고추", percent: 15)
        case .spicy:
            return Sauce(chiliType: "청양고추", percent: 40)
        case .crazy:
            return Sauce(chiliType: "청양고추", percent: 85)
        }
    }
}

// 편의시설 및 어트렉션을 짓는데 필요한 자재
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


//MARK: - 편의 시설
// 좀더 간단하게 만들자 기능을 위한 함수를 제외하고, 구성품만 넣어서 만들어보자

class TicketBox: Facilities {
    
    var body: Material
    var ticketPrice: Int = 8000// 티켓 가격에 차이를 두지 말고, 하나로 통일
    var clerk: String = "Ticket Man"// 직원의 이름
    var totalMoney: Int = 0
    
    
    init(body: MaterialGroup) {
        self.body = body.material // wood, steel, plastic, cotton 중 하나를 인스턴스 생성 시 고를 수 있음
    }
    
    // 이용객이 티켓맨에서 돈을 내고 이용객 수 만큼 totalMoney를 가진다
    // 여기서 더 발전하려면 함수에서 파라미터로 연령대별 이용객(어린이, 성인, 노인)이렇게 나누고, 클래스에 연령대별 티켓값을 프로퍼터로 각각 생성해야함
    func runIt(visitorNumber: Int) -> Int {
        //         어린이, 청소년, 성인 각각의 ticketPrice에 따른 totalMoney 구하기
        self.totalMoney = ticketPrice * visitorNumber
        return totalMoney
    }
}

class ChangingRoom: Facilities {
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
    
    // 총 라커가 몇 개고, 사용 중인 라커 몇개, 남은 라커는 몇개이다. 그리고 if구문 사용해서 라커 수 보다 이용자가 많으면 '라커가 모자랍니다' 메세지 띄워보자
    func runIt(visitorNumber: Int) {
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

class SnackBar: Facilities {
    var body: Material
    var ramen: Material
    var clerk: String = "Snack Boy"
    var ramenPrice: Int = 4000
    var tteokbokkiPrice: Int = 3000
    
    init(body: MaterialGroup, ramen: HotLevel) {
        self.body = body.material
        self.ramen = ramen.hotLevel
    }
    
    // 라면을 팔어서 번 총 수익을 구하기 위한 메서드
    func runIt(visitorNum: Int) -> Int {
        let totalMoney = visitorNum * self.ramenPrice
        return totalMoney
    }
    
}

//MARK: - 어트렉션

class WavePool: Attraction {
    var tube: Bool?
    var power: Bool?
    
    init() { }
    
    func play(power: Bool, tube: Bool, visitorNumber: Int, lifeGuardNumber: Int) {
        if power == true, tube == true {
            print("\(visitorNumber)이 파도풀을 이용중이며, 안전요원 \(lifeGuardNumber)명이 근무 중입니다.")
        } else if power == true, tube == false {
            print("튜브가 없는 이용자는 파도풀에 입장 할 수 없습니다.")
        } else {
            print("파도풀이 작동하지 않습니다.")
        }
    }
}

class LazyRiver: Attraction {
    var tube: Bool?
    var power: Bool?
    
    init() { }
    
    func play(power: Bool, tube: Bool, visitorNumber: Int, lifeGuardNumber: Int) {
        if power == true, tube == true {
            print("\(visitorNumber)이 유수풀을 이용중이며, 안전요원 \(lifeGuardNumber)명이 근무 중입니다.")
        } else if power == true, tube == false {
            print("튜브가 없는 이용자는 유수풀에 입장 할 수 없습니다.")
        } else {
            print("유수풀이 작동하지 않습니다.")
        }
    }
}

class WaterSlide: Attraction {
    var tube: Bool?
    var power: Bool?
    
    
    init() { }
    
    func play(power: Bool, tube: Bool, visitorNumber: Int, lifeGuardNumber: Int) {
        if power == true, tube == true {
            print("\(visitorNumber)이 워터슬라이드 이용을 위해 대기중이며, 안전요원 \(lifeGuardNumber)명이 근무 중입니다.")
        } else if power == true, tube == false {
            print("튜브가 없는 이용자는 워터슬라이드를 사용할 수 없습니다.")
        } else {
            print("워터슬라이드가 작동하지 않습니다.")
        }
    }
}


//MARK: - 워터파크 클래스
// 시설에서 얻은 수익을 총 합계내는 함수를 워터파크 클래스 내부에 만들어 보자
class WaterPark {
    let visitorNumber = 160
    
    let snackBar : SnackBar = .init(body: .steel, ramen: .spicy)
    let changingRoom: ChangingRoom = .init(body: .wood, locker: .wood, clothes: .cotton)
    let ticketBox: TicketBox = .init(body: .steel)
    
    let wavePool: WavePool = .init()
    let lazyRiver: LazyRiver = .init()
    let waterSlide: WaterSlide = .init()
    
    // 오늘수익 총액 구하기
    func calcTotalMoney(completion: @escaping (Int) -> Void) -> Int {
        let totalRevenue = ticketBox.runIt(visitorNumber: visitorNumber) + snackBar.runIt(visitorNum: visitorNumber)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(totalRevenue)
        }
        return totalRevenue
    }
    
    // 각 어트렉션별 전원상태와 이용자의 튜브소지 여부에 따른 어트렉션별 이용자 및 안전요원 수 현황과 경고문구 나타내기 위한 메서드
    func runAttraction(power: Bool, tube: Bool) {
        if power == true, tube == true {
            wavePool.play(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuardNumber: 3)
            lazyRiver.play(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuardNumber: 8)
            waterSlide.play(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuardNumber: 3)
        } else if power == true, tube == false {
            wavePool.play(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuardNumber: 3)
            lazyRiver.play(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuardNumber: 8)
            waterSlide.play(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuardNumber: 3)
        } else {
            wavePool.play(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuardNumber: 3)
            lazyRiver.play(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuardNumber: 8)
            waterSlide.play(power: power, tube: tube, visitorNumber: visitorNumber, lifeGuardNumber: 3)
        }
    }
}

// 이제 Escaping closure를 사용해서
let myWaterpark: WaterPark = .init()
myWaterpark.calcTotalMoney { totalRevenue in
    print("오늘 총 수익은 \(totalRevenue)입니다!")
}
myWaterpark.runAttraction(power: true, tube: true)
