//
//  ChampionTableViewCell.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/04/08.
//

import UIKit

class ChampionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var champNameLabel: UILabel!
    @IBOutlet weak var champHPLabel: UILabel!
    @IBOutlet weak var champOffensePowerLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
