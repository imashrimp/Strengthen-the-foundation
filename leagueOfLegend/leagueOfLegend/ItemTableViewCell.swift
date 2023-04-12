//
//  ItemTableViewCell.swift
//  leagueOfLegend
//
//  Created by 권현석 on 2023/04/12.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var extraOffensePowerLabel: UILabel!
    @IBOutlet weak var itemExpenseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
