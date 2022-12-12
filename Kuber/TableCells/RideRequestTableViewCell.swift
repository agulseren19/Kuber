//
//  RideRequestTableViewCell.swift
//  Kuber
//
//  Created by Begum Sen on 13.12.2022.
//

import UIKit

class RideRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var rideRequestView: UIView!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var gradeLevelLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
