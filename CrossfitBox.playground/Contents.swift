import Foundation
// 크로스핏 선수 키우기 해보자
// 내일 할거 Athlete 클래스에 역도 메서드 완성(바벨 데이터 타입 설정 잘 해보기), 유산소 머신 클래스에 zone2 메서드 완성

//MARK: - 프로토콜

protocol Human {
    var name: String { get set }
    var shoes: ShoesType { get set }
    var bodyWeight: Int { get set }
}

// 아마 총 무게 설정하는 기능 추가 필요할 수도 있음
protocol WeightEqupiment {
    var material: [String]  { get set }
    var weight: Int { get set }
    var brand: EquipmentBrand { get set }
}

// 유산소 머신 탔을 때 기능도 추가해야 할 듯
protocol CardioMachine {
    var rpm: Int { get set }
    var damp: Int { get set }
    var cal: Int { get set }
    var min: Int { get set }
    var meter: Int { get set }
    
    func zone2Training()
}

protocol WarmUpEquipment {
    var color: String { get set }
    var material: String { get set }
    
    func warmingUp()
}

protocol Facilities {
    var numberOfPeople: Int { get set }
}

//MARK: - 열거형

enum ShoesType {
    case nike
    case nobull
    case tyr
    case reebok
}

// 아래 열거형의 이름을 원래는 '45lb', '35lb'로 하고 싶었으나 => 열거형의 케이스 이름으로 숫자가 처음에 올 수 없으므로 남자, 여자 바벨을 구분해 무게를 원시값으로 설정함 => 나중에 발벨 총 무게 계산시 사용 가능 할 듯
// => ⚠️ 바벨, 덤벨, 플레이트의 프로토콜의 공통 프로퍼티로 자체 무게를 만들기 위해 우선은 해당 열거형 보류!!!!!
enum BarbellType: Int {
    case forMen = 45
    case forWomen = 35
}

enum EquipmentBrand {
    case rogue
    case metkon
    case eleiko
    case wodFriends
}

// 운동 도구의 재료를 표현하려면, 열거형으로 둘게 아니라 재료 종류를 배열로 둬야하나?
//enum Material {
//    case steel
//    case rubber
//}

//MARK: - 워밍업 도구
class foamRoller: WarmUpEquipment {
    var color: String
    var material: String // 재료 특성을 enum으로 만들어볼까?
    
    init(color: String, material: String) {
        self.color = color
        self.material = material
    }
    
    func warmingUp() {
        // 정강이, 종아리, 허벅지 앞과 뒤, 엉덩이, 광배를 마사지함
    }
}

class massageBall: WarmUpEquipment {
    var color: String
    var material: String
    
    init(color: String, material: String) {
        self.color = color
        self.material = material
    }
    
    func warmingUp() {
        // 전완, 승모근 마사지
    }
}

class rubberBand: WarmUpEquipment {
    var color: String
    var material: String
    
    init(color: String, material: String) {
        self.color = color
        self.material = material
    }
    
    func warmingUp() {
        // 발목, 손목 그리고 가슴 스트레칭
    }
    
    
}

class pvcPipe: WarmUpEquipment {
    var color: String
    var material: String
    
    init(color: String, material: String) {
        self.color = color
        self.material = material
    }
    
    func warmingUp() {
        // 역도 동작 스트레칭
    }
}

//MARK: - 유산소 머신
//    zone 2 트레이닝
//    => 바이크 에르그(damp를 몇으로 설정해, rpm 몇으로 몇 분 탄다) => 바이크 에르그에는 시간, rpm, damp가 프로퍼티로 있어야함

class RowingMachine: CardioMachine {
    var rpm: Int
    var damp: Int
    var cal: Int
    var min: Int
    var meter: Int
    
    init(rpm: Int, damp: Int, cal: Int, min: Int, meter: Int) {
        self.rpm = rpm
        self.damp = damp
        self.cal = cal
        self.min = min
        self.meter = meter
    }
    
    func zone2Training() {
        // 어떤 머신으로 얼마의 시간동안 얼마의 rpm을 유지해서 몇 미터를 갔는가?
    }
}

class AssaultBike: CardioMachine {
    var rpm: Int
    var damp: Int
    var cal: Int
    var min: Int
    var meter: Int
    
    init(rpm: Int, damp: Int, cal: Int, min: Int, meter: Int) {
        self.rpm = rpm
        self.damp = damp
        self.cal = cal
        self.min = min
        self.meter = meter
    }
    
    func zone2Training() {
    }
}

class SkiErg: CardioMachine {
    var rpm: Int
    var damp: Int
    var cal: Int
    var min: Int
    var meter: Int
    
    init(rpm: Int, damp: Int, cal: Int, min: Int, meter: Int) {
        self.rpm = rpm
        self.damp = damp
        self.cal = cal
        self.min = min
        self.meter = meter
    }
    
    func zone2Training() {
    }
}

class BikeErg: CardioMachine {
    var rpm: Int
    var damp: Int
    var cal: Int
    var min: Int
    var meter: Int
    
    init(rpm: Int, damp: Int, cal: Int, min: Int, meter: Int) {
        self.rpm = rpm
        self.damp = damp
        self.cal = cal
        self.min = min
        self.meter = meter
    }
    
    func zone2Training() {
    }
}

//MARK: - 사람

class Coach: Human {
    var name: String // 코치 두 분으로 할 수 있으면 해보자
    var shoes: ShoesType // 신발 브랜드를 노불, 나이키, tyr이렇게 세개로 선택 할 수 있게 해보자
    var bodyWeight: Int
    
    init(name: String, shoes: ShoesType, bodyWeight: Int) {
        self.name = name
        self.shoes = shoes
        self.bodyWeight = bodyWeight
    }
    
    func buildAWOD() {
        //      임의로 두 배열(동작, 횟수)를 조합하는 메서드 작성해보자
    }
    
    func runAClass() {
        //  조건 생각해보자
    }
    
    func cleanGym() {
        //  마지막 수업이 끝나면 바닥 청소(진공청소기, 물걸레질)
    }
}

class Athlete: Human {
    // 나중에 여기에 snatchPR, cleanPR을 넣어서 에슬릿 키우기 때 써보자
    var name: String // 회원별로 이름 다르게 3명 정도? 만들어보기
    var bodyWeight: Int
    var shoes: ShoesType
    var gears: [String]

    init(name: String, bodyWeight: Int, shoes: ShoesType, gears: [String]) {
        self.name = name
        self.bodyWeight = bodyWeight
        self.shoes = shoes
        self.gears = gears
    }
    
    func takeAClass() {
        
    }
    
    // 이거를 숫자가 1,2로 임의 뽑기를 해서 성공 실패로 다음 도전무게를 10lb 추가하는걸로
// 여기서 인자의 값 타입을 이렇게 주면 안 될 듯 정확하게 클래스틔 프로퍼티나 열거형의 케이스 타입을 받아야 할 듯
    func doWeightLifting(session: String, athleteName: String, barbellWeight: Int) {
        //1.  워밍업 도구로 워밍업
        //2. pvc파이프로 동작 연습
        
// 이 메서드 안에서 에슬릿 인스턴스를 만들면, 인스턴스가 중복 생성됨 => 인스턴스를 인자로 받자
//        let myAthlete = Member(name: "권현석", bodyWeight: 66, shoes: .nike, gears: ["wrist guards", "knee sleeves"])
        
        if session == "snatch" {
            print("\(athleteName)이 \(barbellWeight)스내치를 성공했습니다")
        } else if session == "clean" {
            print("\(athleteName)이 클린을 성공했습니다")
        }
        // 스내치, 클린에 대한 선택권을 제어문을 통해 주고, 바벨무게 계산이 되어야하며 그 바벨로 수행한 훈련 메세지가 떠야함
    }
}


let alex: Athlete = .init(name: "권현석", bodyWeight: 66, shoes: .nike, gears: ["wrist band", "knee sleeves", "lifting belt"])
// session을 싱글톤 패턴으로 사용하자 아니면 열거형으로, barbell을 어떻게 인스턴스 생성을 해야하지?
//alex.doWeightLifting(session: "snatch", athleteName: alex.name, barbellWeight: .)

//MARK: - 시설
//    시설
//    샤워실
//    화장실
//    리셉션

class ShowerRoom: Facilities {
    var numberOfShowerBooth: Int
    var numberOfPeople: Int
    
    init(numberOfShowerBooth: Int, numberOfPeople: Int) {
        self.numberOfShowerBooth = numberOfShowerBooth
        self.numberOfPeople = numberOfPeople
    }

    // 차가운물: true, 뜨거운 물: false
    func takeAShower(waterTemp: Bool) {
        if waterTemp == true {
            print("찬물 샤워는 염증완화에 좋습니다")
            if numberOfShowerBooth > numberOfPeople {
                print("샤워실 자리가 \(numberOfShowerBooth - numberOfPeople)개 남았습니다.")
            } else {
                print("샤워실 자리가 없습니다")
            }
        } else {
            print("뜨거운 물 샤워는 근육통 회복에 좋습니다.")
            if numberOfShowerBooth > numberOfPeople {
                print("샤워실 자리가 \(numberOfShowerBooth - numberOfPeople)개 남았습니다.")
            } else {
                print("샤워실 자리가 없습니다")
            }
        }
    }
}

class Toilet: Facilities {
    var numberOfToilet: Int
    var numberOfPeople: Int
    
    init(numberOfToilet: Int, numerOfPeople: Int) {
        self.numberOfToilet = numberOfToilet
        self.numberOfPeople = numerOfPeople
    }
    
    func useToilet() {
        if numberOfToilet > numberOfPeople {
            print("화장실 자리가 \(numberOfToilet - numberOfPeople)개 남았습니다.")
        } else {
            print("화장실 자리가 없습니다")
        }
    }
}

class Reception: Facilities {
    var numberOfCoach: Int
    var numberOfPeople: Int
    
    init(numberOfCoach: Int, numberOfPeople: Int) {
        self.numberOfCoach = numberOfCoach
        self.numberOfPeople = numberOfPeople
    }
    
    func consult() {
        if numberOfPeople == 0 {
            print("상담중인 회원이 없습니다")
        } else {
            print("\(numberOfPeople)명이 상담중 입니다")
        }
    }
    
//MARK: - 운동기구
    
    // 해당 클래스는 바벨 하나의 특성을 나타내므로 바벨 하나의 특성만 나타낼 수 있도록 함
    class Barbell: WeightEqupiment {
        // material 프로퍼티가 여러종류의 재료를 String 타입의 배열로 받아올 수 있도록 하고 싶음
        var material: [String]
        var weight: Int
        var brand: EquipmentBrand
        
        init(weight: Int, brand: EquipmentBrand, material: [String]) {
            self.weight = weight
            self.brand = brand
            self.material = material
        }
    }
    
    
    class Dumbbell: WeightEqupiment {
        var material: [String] // Material을 열거형으로 만든 후 배열에 넣어 해당 운동 기구의 재료를 열거형으로 나타내보자
        var weight: Int
        var brand: EquipmentBrand
        
        init(bodyWeight: Int, brand: EquipmentBrand, material: [String]) {
            self.weight = bodyWeight
            self.brand = brand
            self.material = material
        }
    }
    
    
    class Plate: WeightEqupiment {
        var material: [String] // Material을 열거형으로 만든 후 배열에 넣어 해당 운동 기구의 재료를 열거형으로 나타내보자
        var weight: Int
        var brand: EquipmentBrand
        
        init(weight: Int, brand: EquipmentBrand, material: [String]) {
            self.weight = weight
            self.brand = brand
            self.material = material
        }
    }
}
