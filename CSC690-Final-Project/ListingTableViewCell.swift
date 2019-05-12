//
//  ListtingTableViewCell.swift
//  CSC690-Final-Project
//
//  Created by Alex Sergeev on 5/9/19.
//  Copyright © 2019 Alex Sergeev. All rights reserved.
//

import UIKit

class ListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var housingType: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var roomsBathsInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
