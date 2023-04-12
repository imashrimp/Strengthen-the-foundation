//
//  GameDoneViewController.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/04/13.
//

import UIKit

class GameDoneViewController: UIViewController {

    @IBOutlet weak var gameDoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        gameDoneLabel.text = "게임이 끝났습니다."
    }
}
