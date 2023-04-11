//
//  champListTableViewCell.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/04/07.
//

import UIKit

class ChampListTableViewCell: UITableViewCell {

    @IBOutlet weak var champName : UILabel!
    @IBOutlet weak var champHP : UILabel!
    @IBOutlet weak var champOffensePower : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
