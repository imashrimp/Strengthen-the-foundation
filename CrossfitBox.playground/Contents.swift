import Foundation
// 크로스핏 선수 키우기 해보자
// 'athlete' 클래스에서 'snatchPR', 'cleanPR' 프로퍼티의 값을 인스턴스 생성시 남여 선택에 따라 무게를 다르게 설정할 수 있도록 하기 그리고 Result를 성공확률의 성질을 갖게 하고 싶음 => 숫자가 1,2로 임의 뽑기를 해서 성공 실패로 다음 도전무게를 10lb 추가하는걸로
// => enum barbellOnSex
// // 프로토콜, 익스텐션, 열거형, 클래스, 함수별 작성 이유 및 기능 작성하기

//MARK: - 프로토콜

protocol Human {
    var name: String { get set }
    var shoes: ShoesType { get set }
    var bodyWeight: Int { get set }
}

// 아마 총 무게 설정하는 기능 추가 필요할 수도 있음
protocol WeightEqupiment {
    var material: [String]  { get set }
    var weight: WeightInPound { get set }
    var brand: EquipmentBrand { get set }
    var number: Int { get set }
}

extension WeightEqupiment {
    func countEquipNum() {
        print("\(brand)사의 \(weight.rawValue)lb \(String(describing: type(of: self)))을(를) \(number)개 갖고 있습니다.")
    }
}

// 유산소 머신 탔을 때 기능도 추가해야 할 듯
protocol CardioMachine {
    var rpm: Int { get set }
    var damp: Int { get set }
    var min: Int { get set }
    //    var cal: Int { get set }
    //    var meter: Int { get set }
}

extension CardioMachine {
    func zone2Training() {
        print("\(String(describing: type(of: self)))의 댐퍼를 \(damp)(으)로 설정해 \(min)분 동안 \(rpm)rpm을 유지해서 타세요")
    }
}

protocol WarmUpEquipment {
    var targetToMassage: bodyPart { get set }
    var minutes: Int { get set }
}

extension WarmUpEquipment {
    func warmingUp() {
        print("\(targetToMassage)을(를) \(minutes)분 동안 마사지하세요.")
    }
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
enum WeightInPound: Int {
    case ten = 10
    case fifteen = 15
    case twentyfive = 25
    case thirtyfive = 35
    case fortyfive = 45
}

enum BarbellOnSex: Int {
    case forMen = 45
    case forWomen = 35
}

enum WeightLiftingSession {
    case snatch
    case clean
}

enum EquipmentBrand {
    case rogue
    case metkon
    case eleiko
    case wodFriends
}

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

//MARK: - 워밍업 도구

class FoamRoller: WarmUpEquipment {
    var targetToMassage: bodyPart
    var minutes: Int
    
    init(targetToMassage: bodyPart, minutes: Int) {
        self.targetToMassage = targetToMassage
        self.minutes = minutes
    }
}

class MassageBall: WarmUpEquipment {
    var targetToMassage: bodyPart
    var minutes: Int
    
    init(targetToMassage: bodyPart, minutes: Int) {
        self.targetToMassage = targetToMassage
        self.minutes = minutes
    }
}

class RubberBand: WarmUpEquipment {
    var targetToMassage: bodyPart
    var minutes: Int
    
    init(targetToMassage: bodyPart, minutes: Int) {
        self.targetToMassage = targetToMassage
        self.minutes = minutes
    }
}

class PvcPipe: WarmUpEquipment {
    var targetToMassage: bodyPart
    var minutes: Int
    
    init(targetToMassage: bodyPart, minutes: Int) {
        self.targetToMassage = targetToMassage
        self.minutes = minutes
    }
}

//MARK: - 사람

class Coach: Human {
    var name: String // 코치 두 분으로 할 수 있으면 해보자
    var shoes: ShoesType
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
    var name: String // 회원별로 이름 다르게 3명 정도? 만들어보기
    var bodyWeight: Int
    var shoes: ShoesType
    var gears: [String]
    var snatchPR: Int = 45 // 이거를 성별에 따른 바벨의 무게로 설정할 수 있게 하자
    var cleanPR: Int = 45
    var emptyBar: BarbellOnSex
    
    init(name: String, bodyWeight: Int, shoes: ShoesType, gears: [String], sex: BarbellOnSex) {
        self.name = name
        self.bodyWeight = bodyWeight
        self.shoes = shoes
        self.gears = gears
        self.emptyBar = sex
    }
    
//    성별에 따른 메서드를 만들고 'private'키워드를 사용해 인스턴스 생성 시 성별에 따라 구분한 아래의 두 메서드(ForMen, ForWomen)를 해당 클래스 밖에서 부르지 못하도록 함
    // Result를 성공확률의 성질을 갖게 하고 싶음 => 숫자가 1,2로 임의 뽑기를 해서 성공 실패로 다음 도전무게를 10lb 추가하는걸로
    private func liftingForMen(session: WeightLiftingSession, athleteName: String, result: Bool) {
          if session == .snatch {
              if snatchPR == 45, result == true {
                  print("\(athleteName)(이)가 \(snatchPR)lb 스내치를 성공했습니다. \(athleteName)의 스내치 PR은 \(snatchPR)입니다.")
                  snatchPR += 10
                  print("다음번에는 \(snatchPR)lb 스내치에 도전해보세요")
              } else if snatchPR > 45, result == true {
                  print("\(athleteName)(이)가 \(snatchPR)lb 스내치를 성공했습니다. \(athleteName)의 스내치 PR은 \(snatchPR)입니다.")
                  snatchPR += 10
                  print("다음번에는 \(snatchPR)lb 스내치에 도전해보세요")
              } else if result == false {
                  snatchPR
                  print("\(athleteName)(이)가 \(snatchPR)lb 스내치를 실패했습니다. 좀 더 집중해서 다시 해봅시다.")
              }
          } else {
              if cleanPR == 45, result == true {
                  print("\(athleteName)(이)가 \(cleanPR)lb 클린을 성공했습니다. \(athleteName)의 클린 PR은 \(cleanPR)입니다.")
                  cleanPR += 10
                  print("다음번에는 \(cleanPR)lb 클린에 도전해보세요")
              } else if cleanPR > 45, result == true {
                  print("\(athleteName)(이)가 \(cleanPR)lb 클린을 성공했습니다. \(athleteName)의 클린 PR은 \(cleanPR)입니다.")
                  cleanPR += 10
                  print("다음번에는 \(cleanPR)lb 스내치에 도전해보세요")
              } else if result == false {
                  cleanPR
                  print("\(cleanPR)lb 클린을 실패했습니다. 좀 더 집중해서 다시 해봅시다.")
              }
          }
      }
      
     private func liftingForWomen(session: WeightLiftingSession, athleteName: String, result: Bool) {
          if session == .snatch {
              if snatchPR == 35, result == true {
                  print("\(athleteName)(이)가 \(snatchPR)lb 스내치를 성공했습니다. \(athleteName)의 스내치 PR은 \(snatchPR)입니다.")
                  snatchPR += 10
                  print("다음번에는 \(snatchPR)lb 스내치에 도전해보세요")
              } else if snatchPR > 35, result == true {
                  print("\(athleteName)(이)가 \(snatchPR)lb 스내치를 성공했습니다. \(athleteName)의 스내치 PR은 \(snatchPR)입니다.")
                  snatchPR += 10
                  print("다음번에는 \(snatchPR)lb 스내치에 도전해보세요")
              } else if result == false {
                  snatchPR
                  print("\(athleteName)가 \(snatchPR)lb 스내치를 실패했습니다. 좀 더 집중해서 다시 해봅시다.")
              }
          } else {
              if cleanPR == 35, result == true {
                  print("\(athleteName)(이)가 \(cleanPR)lb 클린을 성공했습니다. \(athleteName)의 클린 PR은 \(cleanPR)입니다.")
                  cleanPR += 10
                  print("다음번에는 \(cleanPR)lb 클린에 도전해보세요")
              } else if cleanPR > 35, result == true {
                  print("\(athleteName)(이)가 \(cleanPR)lb 클린을 성공했습니다. \(athleteName)의 클린 PR은 \(cleanPR)입니다.")
                  cleanPR += 10
                  print("다음번에는 \(cleanPR)lb 스내치에 도전해보세요")
              } else if result == false {
                  cleanPR
                  print("\(athleteName)(이)가 \(cleanPR)lb 클린을 실패했습니다. 좀 더 집중해서 다시 해봅시다.")
              }
          }
      }
      
      // Result를 성공확률의 성질을 갖게 하고 싶음 => 숫자가 1,2로 임의 뽑기를 해서 성공 실패로 다음 도전무게를 10lb 추가하는걸로
// 성별에 따라 다른 함수를 호출하면 실수가 발생할 수 있으므로 아래와 같이 작성
      func doWeightLifting(session: WeightLiftingSession, athleteName: String, result: Bool) {
          if emptyBar == .forMen {
              liftingForMen(session: session, athleteName: athleteName, result: result)
          } else if emptyBar == .forWomen {
              liftingForWomen(session: session, athleteName: athleteName, result: result)
          }
      }
}

let alex: Athlete = .init(name: "권현석", bodyWeight: 66, shoes: .nike, gears: ["손목보호대", "무릎 보호대", "복압 벨트"], sex: .forMen)

alex.doWeightLifting(session: .snatch, athleteName: alex.name, result: true)
alex.doWeightLifting(session: .snatch, athleteName: alex.name, result: true)
alex.doWeightLifting(session: .snatch, athleteName: alex.name, result: true)
alex.doWeightLifting(session: .snatch, athleteName: alex.name, result: true)
alex.doWeightLifting(session: .snatch, athleteName: alex.name, result: true)
alex.doWeightLifting(session: .snatch, athleteName: alex.name, result: true)

//MARK: - 시설

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
}
    
    //MARK: - 운동기구
    
    // 아래의 세 클래스의 운동기구가 각각 박스에 몇개씩 있는지 표현해보자
    
    // 해당 클래스는 바벨 하나의 특성을 나타내므로 바벨 하나의 특성만 나타낼 수 있도록 함
    class Barbell: WeightEqupiment {
        // material 프로퍼티가 여러종류의 재료를 String 타입의 배열로 받아올 수 있도록 하고 싶음
        var material: [String]
        var weight: WeightInPound
        var brand: EquipmentBrand
        var number: Int
        
        init(weight: WeightInPound, brand: EquipmentBrand, material: [String], number: Int) {
            self.weight = weight
            self.brand = brand
            self.material = material
            self.number = number
        }
    }
    
    class Dumbbell: WeightEqupiment {
        var material: [String] // Material을 열거형으로 만든 후 배열에 넣어 해당 운동 기구의 재료를 열거형으로 나타내보자
        var weight: WeightInPound
        var brand: EquipmentBrand
        var number: Int
        
        init(weight: WeightInPound, brand: EquipmentBrand, material: [String], number: Int) {
            self.weight = weight
            self.brand = brand
            self.material = material
            self.number = number
        }
    }
    
    class Plate: WeightEqupiment {
        var material: [String] // Material을 열거형으로 만든 후 배열에 넣어 해당 운동 기구의 재료를 열거형으로 나타내보자
        var weight: WeightInPound
        var brand: EquipmentBrand
        var number: Int
        
        init(weight: WeightInPound, brand: EquipmentBrand, material: [String], number: Int) {
            self.weight = weight
            self.brand = brand
            self.material = material
            self.number = number
        }
    }

//MARK: - 유산소 머신

class RowingMachine: CardioMachine {
    var rpm: Int
    var damp: Int
    var min: Int
    
    init(rpm: Int, damp: Int, min: Int) {
        self.rpm = rpm
        self.damp = damp
        self.min = min
    }
}

class AssaultBike: CardioMachine {
    var rpm: Int
    var damp: Int
    var min: Int
    
    init(rpm: Int, damp: Int, min: Int) {
        self.rpm = rpm
        self.damp = damp
        self.min = min
    }
}

class SkiErg: CardioMachine {
    var rpm: Int
    var damp: Int
    var min: Int
    
    init(rpm: Int, damp: Int, min: Int) {
        self.rpm = rpm
        self.damp = damp
        self.min = min
    }
}

class BikeErg: CardioMachine {
    var rpm: Int
    var damp: Int
    var min: Int
    
    init(rpm: Int, damp: Int, min: Int) {
        self.rpm = rpm
        self.damp = damp
        self.min = min
    }
}


//MARK: - 크로스핏 박스
