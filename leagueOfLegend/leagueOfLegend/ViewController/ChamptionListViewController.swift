//
//  ChamptionListViewController.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/04/07.
//

import UIKit

class ChampionListViewController: UIViewController {

    var selectedChampion: [Champion] = []
    
    @IBOutlet weak var champListTableView: UITableView!
    @IBOutlet weak var champNameHeader: UILabel!
    @IBOutlet weak var champHPHeader: UILabel!
    @IBOutlet weak var champOffensePowerHeader: UILabel!
    @IBOutlet weak var champSelectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 아래의 delegate => 'champListTableView'의 위임자는 바로 나(ChampionListViewController)입니다. 그래서 'champListTableView'가 뭘 하면 내가 그걸 처리할거야
        champListTableView.delegate = self
        champListTableView.dataSource = self
        
        champNameHeader.text = "챔피언"
        champHPHeader.text = "HP"
        champOffensePowerHeader.text = "공격력"
        champSelectButton.setTitle("챔피언 선택", for: .normal)
        champSelectButton.setTitleColor(.white, for: .normal)
        champSelectButton.backgroundColor = .black
                
        let championNib = UINib(nibName: "ChampionTableViewCell", bundle: nil)
        champListTableView.register(championNib, forCellReuseIdentifier: "ChampionTableViewCell")
        champSelectButton.addTarget(self, action: #selector(pushToInGame), for: .touchUpInside)
    }
    
    @objc func pushToInGame() {
        // 스토리보드 파일 불러오기
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // 해당 스토리 보드의 뷰컨트롤러 불러오기
        let vc = storyboard.instantiateViewController(withIdentifier: "InGame") as! InGameViewController
        // 화면 그리기
        vc.loadView()
        // 인게임 뷰컨(불러온 뷰컨)에 테이블 뷰에서 선택된 챔피언의 인스턴스 추가하기
        vc.setChampion(champion: selectedChampion[0])
        
        // 네비게이션 컨트롤러로 화면 'push' 전환하기
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension ChampionListViewController: UITableViewDataSource {
    // 섹션 숫자를 안 정하면 그냥 하나로 보는건가?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         챔피언 리스트 열거형의 케이스 숫자를 받아와 케이스의 숫자만큼 행을 생성
        let championListNumber = ChampionList.allCases.count
        return championListNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChampionTableViewCell", for: indexPath) as! ChampionTableViewCell

        // 챔피언 목록 위에 표처럼 챔피언이름, HP, 공격력 이렇게 표시하고 싶은데 어떻게 해야하지?
        cell.champNameLabel.text = ChampionList.allCases[indexPath.row].champion.name
        cell.champHPLabel.text = "\(ChampionList.allCases[indexPath.row].champion.hp)"
        cell.champOffensePowerLabel.text = "\(ChampionList.allCases[indexPath.row].champion.offensePower)"

        return cell
    }
}

extension ChampionListViewController: UITableViewDelegate {
    // 테이블 뷰의 선택된 셀의 정보를 받아오기 위한 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 매개변수 indexPath를 사용해 열거형으로 표현된 챔피언을 'allCases' 메서드를 통해 배열형태로 받아와 배열에 추가함
        self.selectedChampion.append(ChampionList.allCases[indexPath.row].champion)
    }
}
