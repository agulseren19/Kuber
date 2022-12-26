//
//  RidesAfterSearchTableViewCell.swift
//  Kuber
//
//  Created by Arda Aliz on 1.12.2022.
//

import UIKit

class RidesAfterSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var ridesAfterSearchView: UIView!
    @IBOutlet weak var fromLocationLabel: UILabel!
    @IBOutlet weak var toLocationLabel: UILabel!
    @IBOutlet weak var sendHitchButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    var hitchARideBtn: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func sendHitchButtonTapped(_ sender: Any) {
        hitchARideBtn?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
