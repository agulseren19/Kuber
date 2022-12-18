//
//  HistoryOfHitchhikesTableViewCell.swift
//  Kuber
//
//  Created by Arda Aliz on 14.12.2022.
//

import UIKit

class HistoryOfHitchhikesTableViewCell: UITableViewCell {

    @IBOutlet weak var hitchesView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var toLocationLabel: UILabel!
    @IBOutlet weak var fromLocationLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
