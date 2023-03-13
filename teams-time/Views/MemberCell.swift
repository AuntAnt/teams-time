//
//  MemberCell.swift
//  teams-time
//
//  Created by Bektemur Mamashayev on 11/03/23.
//

import UIKit

class MemberCell: UITableViewCell {
    @IBOutlet var memberImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
