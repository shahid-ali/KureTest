//
//  UserCell.swift
//  KureTest
//
//  Created by Shahid Ali on 7/23/21.
//

import UIKit

class UserCell: UITableViewCell {

	@IBOutlet weak var nameLable: UILabel!
	@IBOutlet weak var mobileNumberLabel: UILabel!
	
	
	var user:User?{
		
		didSet{
			
			if let user=user
			{
				nameLable.text=user.name
				mobileNumberLabel.text=user.mobileNumber
			}
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
