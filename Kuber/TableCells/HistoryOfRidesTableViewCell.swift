//
//  HistoryOfRidesTableViewCell.swift
//  Kuber
//
//  Created by Arda Aliz on 14.12.2022.
//

import UIKit

class HistoryOfRidesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fromLocationLabel: UILabel!
    @IBOutlet weak var toLocationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var availableSeatLabel: UILabel!
    
    @IBOutlet weak var historyRideView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
