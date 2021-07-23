//
//  TextMessageOutgoingCell.swift
//  KureTest
//
//  Created by Shahid Ali on 7/23/21.
//

import UIKit
import SendBirdSDK

class TextMessageOutgoingCell: UITableViewCell {

	@IBOutlet weak var senderName: UILabel!
	@IBOutlet weak var textMessageLabel: UILabel!
	
	
	var message:SBDUserMessage?
	{
		didSet
		{
			if let userId=message?.sender?.userId
			{
				senderName.text=userId
			}
			
			
			if let message=message?.message
			{
				textMessageLabel.text=message
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
