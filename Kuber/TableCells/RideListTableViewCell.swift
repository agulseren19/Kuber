//
//  RideListTableViewCell.swift
//  Kuber
//
//  Created by Begum Sen on 24.11.2022.
//

import UIKit

class RideListTableViewCell: UITableViewCell {

    @IBOutlet weak var myRideView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var availableSeatLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var fromLocationLabel: UILabel!
    @IBOutlet weak var toLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
