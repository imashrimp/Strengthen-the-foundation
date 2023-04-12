//
//  ItemShopViewController.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/04/11.
//

//그냥 테이블 뷰가 문제인 듯 => 셀 생성 자체가 안 됨
import UIKit

class ItemShopViewController: UIViewController {
    
    var selectedItem: [Item] = []
    
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var extraOffensePowerLabel: UILabel!
    @IBOutlet weak var itemExpenseLabel: UILabel!
    @IBOutlet weak var buyItemButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        itemNameLabel.text = "아이템"
        extraOffensePowerLabel.text = "추가 공격력"
        itemExpenseLabel.text = "가격(골드)"
        
        buyItemButton.setTitle("아이템 구매", for: .normal)
        buyItemButton.setTitleColor(.white, for: .normal)
        buyItemButton.backgroundColor = .black
                
        itemTableView.delegate = self
        itemTableView.dataSource = self
        let itemNib = UINib(nibName: "ItemTableViewCell", bundle: nil)
        itemTableView.register(itemNib, forCellReuseIdentifier: "ItemTableViewCell")
    }
}

// 일단 uibutton이라 치고 ㅋㅋ
func button() {
    // selectedItem 배열에 추가된 아이템을 받아와서 아이템 구입 버튼을 누르면, InGame 클래스에 있는 shopping()메서드가 호출되어야함 => 이 메서드는 아이템을 구입하면 아이템에 해당하는 골드만큼 챔피언이 소유한 골드에서 차감되고 인게임 화면에 설정된 챔피언의 공격력이 추가되면 됨
}


// 아래 두 메서드가 실행이 안됨 => 셀 등록에 문제가 있음
extension ItemShopViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemListNumber = ItemList.allCases.count
        return itemListNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        
        cell.itemNameLabel.text = ItemList.allCases[indexPath.row].itemIBought.name
        cell.extraOffensePowerLabel.text = String(ItemList.allCases[indexPath.row].itemIBought.extraPower)
        cell.itemExpenseLabel.text = String(ItemList.allCases[indexPath.row].itemIBought.expense)
        return cell
    }
    
    
}

extension ItemShopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedItem.append(ItemList.allCases[indexPath.row].itemIBought)
    }
}
