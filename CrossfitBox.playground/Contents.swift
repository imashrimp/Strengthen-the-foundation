import Foundation

// 내일 할 일
// 현재 Athlete 클래스 내부에 있는 doSnatch나 doClean 메서드가 작동될 때 콘솔에 표시되는 메세지도 escaping closure를 사용해서 늦게 나오면 좋겠음

//MARK: - 프로토콜

// 코치, 에슬릿의 특징을 나타내기 위한 프로토콜
protocol Human {
    var name: String { get set }
    var shoes: ShoesType { get set }
    var bodyWeight: Int { get set }
}

// 장비의 재료, 무게, 브랜드, 보유 갯수를 표현하기 위한 프로토콜
protocol WeightEqupiment {
    var material: [Material]  { get set }
    var weight: WeightInPound { get set }
    var brand: EquipmentBrand { get set }
    var number: Int { get set }
}

// 장비 인스턴스를 생성하면 메세지로 장비 정보를 나타내기 위한 메서드, 프로토콜의 익스텐션을 사용해 클래스에서 해당 메서드를 구현하지 않아도 메서드가 실행되게함
extension WeightEqupiment {
    func informEquipment() {
        print("\(brand)사의 \(weight.rawValue)lb \(String(describing: type(of: self)))을(를) \(number)개 갖고 있습니다.")
    }
}

// 유산소 머신을 탈 때 필요한 요소와 아래 익스텐션에서 메세지를 보낼때 필요한 요소를 프로퍼티로 나타냄
protocol CardioMachine {
    var rpm: Int { get set }
    var damp: Int { get set } // 저항도, 강도라고 볼 수 있음, 보통 1~10 까지 있으며, 숫자가 높을 수록 저항도가 높음
    var min: Int { get set }
    var number: Int { get set }
}

// 유산소 머신을 어느정도 타라는 알림
extension CardioMachine {
    func zone2Training() {
        print("\(String(describing: type(of: self)))의 댐퍼를 \(damp)(으)로 설정해 \(min)분 동안 \(rpm)rpm을 유지해서 타세요")
    }
}

// 워밍업 도구를 사용할 신체부위와 시간을 나타내기 위해 아래의 프로퍼티가 필요함
protocol WarmUpEquipment {
    var targetToMassage: [bodyPart] { get set }
    var minutes: Int { get set }
    var number: Int { get set }
}

// 마시지를 어느정도 하라는 알림
extension WarmUpEquipment {
    func warmingUp() {
        print("\(targetToMassage)을(를) \(minutes)분 동안 마사지하세요.")
    }
}

// 편의 시설을 사용하는 사람의 수를 알리고, 편의 시설이 가득 찬 경우 사용할 수 없음을 알리기 위해 아래의 프로퍼티가 필요함
protocol Facilities {
    var numberOfPeople: Int { get set }
}

//MARK: - 열거형

// 코치 및 에슬릿이 신는 신발의 브랜드를 한정함
enum ShoesType {
    case nike
    case nobull
    case tyr
    case reebok
}

// 덤벨, 플레이트의 무게(파운드) 설정을 위해 만든 열거형
enum WeightInPound: Int {
    case ten = 10
    case fifteen = 15
    case twentyfive = 25
    case thirtyfive = 35
    case fortyfive = 45
}

// 에슬릿의 성별에 따라 바벨 종류(무게)의 차이를 주기 위해 만듦
enum Sex {
    case Male
    case Female
}

// 성별에 따라 바벨 무게 다르게 설정해주기 위함
enum BarbellWeightOnSex: Int {
    case forMen = 45
    case forWomen = 35
}

// 에슬릿의 역도 세션 구분을 위해 만듦
enum WeightLiftingSession {
    case snatch
    case clean
}

// 덤벨, 바벨, 플레이트 제작 브랜드 제한을 주기 위해 설정
enum EquipmentBrand {
    case rogue
    case metkon
    case eleiko
    case wodFriends
}

// 워밍업 도구 사용을 할 신체부위
enum bodyPart {
    case backNeck
    case back
    case shoulder
    case foreArm
    case chest
    case glute
    case leg
    case ankle
    case wrist
}

enum Material {
    case steel
    case rubber
}

enum Gears {
    case wristBand
    case kneeSleeve
    case liftingBelt
}
//MARK: - 워밍업 도구
// 폼롤러, 마사지볼, 고무밴드, pvc파이프 등 마사지 도구를 만들어 줌. 해당 프로퍼티 및 인스턴스 생성시 표시되는 메세지를 실행시키는 메서드는 위에서 프로토콜과 익스텐션에서 설명함

// 도구 갯수를 위해 number: Int 프로퍼티를 추가해볼까?
class FoamRoller: WarmUpEquipment {
    var targetToMassage: [bodyPart]
    var minutes: Int
    var number: Int
    
    
    init(targetToMassage: [bodyPart], minutes: Int, number: Int) {
        self.targetToMassage = targetToMassage
        self.minutes = minutes
        self.number = number
    }
}

class MassageBall: WarmUpEquipment {
    var targetToMassage: [bodyPart]
    var minutes: Int
    var number: Int
    
    init(targetToMassage: [bodyPart], minutes: Int, number: Int) {
        self.targetToMassage = targetToMassage
        self.minutes = minutes
        self.number = number
    }
}

class RubberBand: WarmUpEquipment {
    var targetToMassage: [bodyPart]
    var minutes: Int
    var number: Int
    
    init(targetToMassage: [bodyPart], minutes: Int, number: Int) {
        self.targetToMassage = targetToMassage
        self.minutes = minutes
        self.number = number
    }
}

class PvcPipe: WarmUpEquipment {
    var targetToMassage: [bodyPart]
    var minutes: Int
    var number: Int
    
    init(targetToMassage: [bodyPart], minutes: Int, number: Int) {
        self.targetToMassage = targetToMassage
        self.minutes = minutes
        self.number = number
    }
}

//MARK: - 운동 도구

class Barbell: WeightEqupiment {
    // material 프로퍼티가 여러 종류의 재료를 String 타입의 배열로 받아올 수 있도록 하고 싶음 => 인스턴스 생성시 (material: [.steel, .rubber]) 이런 식으로
    var material: [Material]
    var weight: WeightInPound
    var brand: EquipmentBrand
    var number: Int
    
    init(weight: WeightInPound, brand: EquipmentBrand, material: [Material], number: Int) {
        self.weight = weight
        self.brand = brand
        self.material = material
        self.number = number
    }
}

class Dumbbell: WeightEqupiment {
    var material: [Material] // Material을 열거형으로 만든 후 배열에 넣어 해당 운동 기구의 재료를 열거형으로 나타내보자
    var weight: WeightInPound
    var brand: EquipmentBrand
    var number: Int
    
    init(weight: WeightInPound, brand: EquipmentBrand, material: [Material], number: Int) {
        self.weight = weight
        self.brand = brand
        self.material = material
        self.number = number
    }
}

class Plate: WeightEqupiment {
    var material: [Material] // Material을 열거형으로 만든 후 배열에 넣어 해당 운동 기구의 재료를 열거형으로 나타내보자
    var weight: WeightInPound
    var brand: EquipmentBrand
    var number: Int
    
    init(weight: WeightInPound, brand: EquipmentBrand, material: [Material], number: Int) {
        self.weight = weight
        self.brand = brand
        self.material = material
        self.number = number
    }
}

//MARK: - 유산소 머신

// 여기도 머신 대수를 나타내기 위해 number: Int 이거를 써보자
class RowingMachine: CardioMachine {
    var rpm: Int
    var damp: Int
    var min: Int
    var number: Int
    
    init(rpm: Int, damp: Int, min: Int, number: Int) {
        self.rpm = rpm
        self.damp = damp
        self.min = min
        self.number = number
    }
}

class AssaultBike: CardioMachine {
    var rpm: Int
    var damp: Int
    var min: Int
    var number: Int
    
    init(rpm: Int, damp: Int, min: Int, number: Int) {
        self.rpm = rpm
        self.damp = damp
        self.min = min
        self.number = number
    }
}

class SkiErg: CardioMachine {
    var rpm: Int
    var damp: Int
    var min: Int
    var number: Int
    
    init(rpm: Int, damp: Int, min: Int, number: Int) {
        self.rpm = rpm
        self.damp = damp
        self.min = min
        self.number = number
    }
}

class BikeErg: CardioMachine {
    var rpm: Int
    var damp: Int
    var min: Int
    var number: Int
    
    init(rpm: Int, damp: Int, min: Int, number: Int) {
        self.rpm = rpm
        self.damp = damp
        self.min = min
        self.number = number
    }
}

//MARK: - 사람

class Coach: Human {
    var name: String
    var shoes: ShoesType
    var bodyWeight: Int
    
    init(name: String, shoes: ShoesType, bodyWeight: Int) {
        self.name = name
        self.shoes = shoes
        self.bodyWeight = bodyWeight
    }
    
    func buildAWOD() {
        //      임의로 두 배열(동작, 횟수)를 조합해 dictionary 형태로 나타내면 되려나? => 1번동작 : x회, 2번 동작: y회, 3번 동작: z회
    }
    
    func runAClass() {
        //  조건 생각해보자
    }
    
    func cleanGym() {
        //  마지막 수업이 끝나면 바닥 청소
    }
}



class Athlete: Human {
    var name: String
    var bodyWeight: Int
    var shoes: ShoesType
    var gears: [Gears]
    var barbellWeight: Int // rawValue를 붙여서 원시값을 사용하려고 하니까 인스턴스 생성에서 문제가 생김
    var sex: Sex
    
    init(name: String, bodyWeight: Int, shoes: ShoesType, gears: [Gears], sex: Sex, barbellWeight: Int) {
        self.name = name
        self.bodyWeight = bodyWeight
        self.shoes = shoes
        self.gears = gears
        self.sex = sex
        self.barbellWeight = barbellWeight
    }
    
    //  성별에 따른 메서드를 만들고 'private'키워드를 사용해 인스턴스 생성 시 성별에 따라 구분한 아래의 두 메서드(ForMen, ForWomen)를 해당 클래스 밖에서 부르지 못하도록 함
    
    // ⭐️ 이스케이핑 클로저를 사용하기 위해서는 함수를 다시 짜야함 dispatchque이거를 'crossfitSwift'클래스 내부에서 작성해 박스에 대한 인스턴스 생성 후 인스턴스를 사용해 박스 클래스에서 리프팅 세션을 진행하는 메서드를 호출할 때 escaping closure로 받아온 값을 표현할 수 있도록 실행해야함(waterpark)연습한거 참조
    // 위의 참조를 구현하기 위해서는
    
    func doSnatch() -> Int {
        let result = Int.random(in: 1...2)
        
        if sex == .Male {
            if result == 1, barbellWeight == 45 {
                print("\(name)(이)가 \(barbellWeight)lb 스내치를 성공했습니다. \(name)의 스내치 PR은 \(barbellWeight)입니다.")
                barbellWeight += 10
                print("다음번에는 \(barbellWeight)lb 스내치에 도전해보세요")
            } else if result == 1, barbellWeight > 45 {
                print("\(name)(이)가 \(barbellWeight)lb 스내치를 성공했습니다. \(name)의 스내치 PR은 \(barbellWeight)입니다.")
                barbellWeight += 10
                print("다음번에는 \(barbellWeight)lb 스내치에 도전해보세요")
            } else {
                barbellWeight
                print("\(name)(이)가 \(barbellWeight)lb 스내치를 실패했습니다. 좀 더 집중해서 다시 해봅시다.")
            }
        } else {
            if result == 1, barbellWeight == 35 {
                print("\(name)(이)가 \(barbellWeight)lb 스내치를 성공했습니다. \(name)의 스내치 PR은 \(barbellWeight)입니다.")
                barbellWeight += 10
                print("다음번에는 \(barbellWeight)lb 스내치에 도전해보세요")
            } else if result == 1, barbellWeight > 35 {
                print("\(name)(이)가 \(barbellWeight)lb 스내치를 성공했습니다. \(name)의 스내치 PR은 \(barbellWeight)입니다.")
                barbellWeight += 10
                print("다음번에는 \(barbellWeight)lb 스내치에 도전해보세요")
            } else {
                barbellWeight
                print("\(name)(이)가 \(barbellWeight)lb 스내치를 실패했습니다. 좀 더 집중해서 다시 해봅시다.")
            }
        }
        return barbellWeight
    }
    
    private func doClean() -> Int {
        let result = Int.random(in: 1...2)
        
        if sex == .Male {
            if result == 1, barbellWeight == 45 {
                print("\(name)(이)가 \(barbellWeight)lb 클린을 성공했습니다. \(name)의 클린 PR은 \(barbellWeight)입니다.")
                barbellWeight += 10
                print("다음번에는 \(barbellWeight)lb 클린에 도전해보세요")
            } else if result == 1, barbellWeight > 45 {
                print("\(name)(이)가 \(barbellWeight)lb 클린을 성공했습니다. \(name)의 클린 PR은 \(barbellWeight)입니다.")
                barbellWeight += 10
                print("다음번에는 \(barbellWeight)lb 클린에 도전해보세요")
            } else {
                barbellWeight
                print("\(name)(이)가 \(barbellWeight)lb 클린에 실패했습니다. 좀 더 집중해서 다시 해봅시다.")
            }
        } else {
            if result == 1, barbellWeight == 35 {
                print("\(name)(이)가 \(barbellWeight)lb 클린을 성공했습니다. \(name)의 클린 PR은 \(barbellWeight)입니다.")
                barbellWeight += 10
                print("다음번에는 \(barbellWeight)lb 클린에 도전해보세요")
            } else if result == 1, barbellWeight > 35 {
                print("\(name)(이)가 \(barbellWeight)lb 클린을 성공했습니다. \(name)의 클린 PR은 \(barbellWeight)입니다.")
                barbellWeight += 10
                print("다음번에는 \(barbellWeight)lb 클린에 도전해보세요")
            } else {
                barbellWeight
                print("\(name)(이)가 \(barbellWeight)lb 클린에 실패했습니다. 좀 더 집중해서 다시 해봅시다.")
            }
        }
        return barbellWeight
    }
}

//MARK: - 시설

class ShowerRoom: Facilities {
    var numberOfShowerBooth: Int
    var numberOfPeople: Int
    
    init(numberOfShowerBooth: Int, numberOfPeople: Int) {
        self.numberOfShowerBooth = numberOfShowerBooth
        self.numberOfPeople = numberOfPeople
    }
    
    // 차가운물: true, 뜨거운 물: false로 설정하고, 물 온도에 따른 메세지 표현, 샤워실 남은 자리를 메세지로 나타냄
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
    
    // 화장실 남은 자리 알림을 위한 메세드
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
    
    // 상담중인지 아닌지 알림을 위한 메서드
    func consult() {
        if numberOfPeople == 0 {
            print("상담중인 회원이 없습니다")
        } else {
            print("\(numberOfPeople)명이 상담중 입니다")
        }
    }
}

//MARK: - 크로스핏 박스

let joosh: Coach

class CrossfitSwift {
    let joosh: Coach = .init(name: "Elon Musk", shoes: .tyr, bodyWeight: 90)
    
    let steve: Athlete = .init(name: "Steve Jobs", bodyWeight: 74, shoes: .nike, gears: [.kneeSleeve, .wristBand, .liftingBelt], sex: .Male, barbellWeight: BarbellWeightOnSex.forMen.rawValue)
    
    let rougeBarbell: Barbell = .init(weight: .fortyfive, brand: .rogue, material: [.steel], number: 2)
    let rougeBarbellWomen: Barbell = .init(weight: .thirtyfive, brand: .rogue, material: [.steel], number: 2)
    let metkonBarbell: Barbell = .init(weight: .fortyfive, brand: .metkon, material: [.steel], number: 3)
    let metkonBarbellWomen: Barbell = .init(weight: .thirtyfive, brand: .metkon, material: [.steel], number: 3)
    let eleikoBarbell: Barbell = .init(weight: .fortyfive, brand: .eleiko, material: [.steel], number: 1)
    let eleikoBarbellWomen: Barbell = .init(weight: .thirtyfive, brand: .eleiko, material: [.steel], number: 1)
    let wodFriendsBarbell: Barbell = .init(weight: .fortyfive, brand: .wodFriends, material: [.steel], number: 3)
    let wodFriendsBarbellWomen: Barbell = .init(weight: .thirtyfive, brand: .wodFriends, material: [.steel], number: 3)
    
    let dumbbell15LB: Dumbbell = .init(weight: .fifteen, brand: .rogue, material: [.steel, .rubber], number: 6)
    let dumbbell25LB: Dumbbell = .init(weight: .twentyfive, brand: .rogue, material: [.steel, .rubber], number: 4)
    let dumbbell35LB: Dumbbell = .init(weight: .thirtyfive, brand: .rogue, material: [.steel, .rubber], number: 4)
    let dumbbell45LB: Dumbbell = .init(weight: .fortyfive, brand: .rogue, material: [.steel, .rubber], number: 4)
    
    let plate10LB: Plate = .init(weight: .ten, brand: .wodFriends, material: [.rubber], number: 8)
    let plate15LB: Plate = .init(weight: .fifteen, brand: .wodFriends, material: [.rubber], number: 4)
    let plate25LB: Plate = .init(weight: .twentyfive, brand: .wodFriends, material: [.rubber], number: 4)
    let plate35LB: Plate = .init(weight: .thirtyfive, brand: .wodFriends, material: [.rubber], number: 4)
    let plate45LB: Plate = .init(weight: .fortyfive, brand: .wodFriends, material: [.rubber], number: 4)
    
    let foamRoller: FoamRoller = .init(targetToMassage: [.leg, .glute, .back, .backNeck], minutes: 3, number: 5)
    let massageBall: MassageBall = .init(targetToMassage: [.back, .glute, .chest, .foreArm], minutes: 3, number: 3)
    let rubberBand: RubberBand = .init(targetToMassage: [.ankle, .wrist], minutes: 3, number: 6)
    let pvcPipe: PvcPipe = .init(targetToMassage: [.shoulder], minutes: 3, number: 8)
    
    let rowingMachine: RowingMachine = .init(rpm: 23, damp: 6, min: 30, number: 8)
    let skiErg: SkiErg = .init(rpm: 23, damp: 4, min: 35, number: 2)
    let assaultBike: AssaultBike = .init(rpm: 35, damp: 0, min: 40, number: 2)
    let bikeErg: BikeErg = .init(rpm: 70, damp: 3, min: 50, number: 1)
    
    let showerRoom: ShowerRoom = .init(numberOfShowerBooth: 3, numberOfPeople: 0)
    let toilet: Toilet = .init(numberOfToilet: 2, numerOfPeople: 0)
    let reception: Reception = .init(numberOfCoach: 2, numberOfPeople: 0)
    
    func introduceEquipment() {
        rougeBarbell.informEquipment()
        rougeBarbellWomen.informEquipment()
        metkonBarbell.informEquipment()
        metkonBarbellWomen.informEquipment()
        eleikoBarbell.informEquipment()
        eleikoBarbellWomen.informEquipment()
        wodFriendsBarbell.informEquipment()
        wodFriendsBarbellWomen.informEquipment()
        
        dumbbell15LB.informEquipment()
        dumbbell25LB.informEquipment()
        dumbbell35LB.informEquipment()
        dumbbell45LB.informEquipment()
        
        plate10LB.informEquipment()
        plate15LB.informEquipment()
        plate25LB.informEquipment()
        plate35LB.informEquipment()
        plate45LB.informEquipment()
    }
    
    func doWarmingUp() {
        foamRoller.warmingUp()
        massageBall.warmingUp()
        rubberBand.warmingUp()
        pvcPipe.warmingUp()
    }
    
    func trainZone2() {
        rowingMachine.zone2Training()
        skiErg.zone2Training()
        assaultBike.zone2Training()
        bikeErg.zone2Training()
    }
    func recordSnatch(completion: @escaping (Int) -> Void) {
        print("\(steve.name)(이)가 스내치를 시도합니다")
        // 반복문 사용해 doSnatch함수 또는 doClean 함수가 n회 실행되도록 하기
        var snatchRecord = steve.doSnatch()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(snatchRecord)
        }
    }
}

let crossfitSwift: CrossfitSwift = .init()
crossfitSwift.recordSnatch { snatchRecord in
    print("\(crossfitSwift.steve.name)의 스내치 기록은 \(snatchRecord)입니다!")
}
