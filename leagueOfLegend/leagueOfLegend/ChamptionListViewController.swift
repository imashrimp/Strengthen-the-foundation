//
//  ChamptionListViewController.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/04/07.
//

import UIKit

// 여기서 테이블 뷰 컨트롤러 사용해 챔피언 목록 불러오고(이거 하려면 챔피언 클래스 필요함) 버튼 연결해서 다음 화면으로 연결 될 수 있도록
class ChampionListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var champListTableView: UITableView!
    @IBOutlet weak var champNameHeader: UILabel!
    @IBOutlet weak var champHPHeader: UILabel!
    @IBOutlet weak var champOffensePowerHeader: UILabel!
    @IBOutlet weak var champSelectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 아래 두 줄 왜 적는 거지? => UITableViewDataSource, UITableViewDelegate 프로토콜을 사용해 프로토콜이 가진 메서드를 작동시키기 위해 필요한 코드라고 생각하면 되는건가요? / 제가 본 블로그에서는 화면에 표현하기 위해 아래 두줄을 적어준다고 적혀있었습니다.
        champListTableView.delegate = self
        champListTableView.dataSource = self
        
        champNameHeader.text = "챔피언"
        champHPHeader.text = "HP"
        champOffensePowerHeader.text = "공격력"
        champSelectButton.setTitle("챔피언 선택", for: .normal)
        champSelectButton.setTitleColor(.white, for: .normal)
        champSelectButton.backgroundColor = .black
    }
    // 섹션 숫자를 안 정하면 그냥 하나로 보는건가?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 챔피언 리스트 열거형의 케이스 숫자를 받아와 케이스의 숫자만큼 행을 생성
        let championListNumber = ChampionList.allCases.count
        return championListNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "championCell", for: indexPath) as! champListTableViewCell
        
        // 챔피언 목록 위에 표처럼 챔피언이름, HP, 공격력 이렇게 표시하고 싶은데 어떻게 해야하지?
        cell.champName.text = ChampionList.allCases[indexPath.row].champion.name
        cell.champHP.text = "\(ChampionList.allCases[indexPath.row].champion.hp)"
        cell.champOffensePower.text = "\(ChampionList.allCases[indexPath.row].champion.offensePower)"
        
        return cell
    }
}

