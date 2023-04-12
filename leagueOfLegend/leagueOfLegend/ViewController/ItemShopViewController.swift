//
//  ItemShopViewController.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/04/11.
//

// 여기서 해야할 거
// 1. 인게임에 이미 받아져 있는 챔피언을 가져와서 아이템을 추가해 다시 인게임으로 보내면 됨

import UIKit

class ItemShopViewController: UIViewController {
    
    var selectedItem: Item = .init(expense: 0, extraPower: 0, name: "")
//    var selectedItem: [Item] = []
    var inGame = InGame(myChampion: .init(name: "", hp: 0, offensePower: 0, gold: 0))

    
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
    
    @IBAction func buyItemPressed(_ sender: UIButton) {
        // 미니언 공격이나 챔피언 공격 모두 InGame 클래스의 프로퍼티인 myChampion을 사용하고 있음 그게 챔피언의 골드를 받아오니까 myChampion을 사용해보자
//        여기서 골드가 왜 0인데? => 왜냐? 여기있는 inGame의 챔피언 인스턴스는 인게임뷰컨의 챔피언 인스턴스가 아니거든
//        그러면 상점으로 가기 버튼을 누르면 
        print("내 챔피언이 가진 골드는 \(inGame.myChampion.gold)입니다!!!!!!!!!!!")
        inGame.shopping(item: selectedItem)

    }
}

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
//        self.selectedItem.append(ItemList.allCases[indexPath.row].itemIBought)
        self.selectedItem = ItemList.allCases[indexPath.row].itemIBought
    }
}
