//
//  ChatVC.swift
//  KureTest
//
//  Created by Shahid Ali on 7/23/21.
//

import UIKit
import SendBirdSDK

class ChatVC: UIViewController {
  
	var user:User?
	var viewModel:ChatVM?
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var textTF: UITextField!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
    }
    
	
	
	private func setup()
	{
		if let user=user
		{
			title=user.name
			
			tableView.register(UINib(nibName:"TextMessageIncomingCell", bundle:nil), forCellReuseIdentifier: "TextMessageIncomingCell")
			
			tableView.register(UINib(nibName:"TextMessageOutgoingCell", bundle:nil), forCellReuseIdentifier: "TextMessageOutgoingCell")
			
			viewModel=ChatVM(user:user)
			viewModel?.openChannel(completionHandler: { error in
				if let error=error
				{
				//show error message
				}
				else
				{
					print("channel opened")
				}
				
			})
			
			SBDMain.add(self as SBDChannelDelegate, identifier: Literals.currentUserId)
		}
	}
	
	@IBAction func sendButtonTapped(_ sender: Any) {
		 if !(textTF.text?.isEmpty ?? true)
		{
			viewModel?.sendText(message:textTF.text ?? "", completion: {[weak self] error in
				if let error=error
				{
					//sending message error, show error to user
				}
				else
				{
					print("message sent")
					self?.textTF.text=""
					self?.tableView.reloadData()
				}
			})
		}
	}
}

extension ChatVC:UITableViewDataSource
{
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return viewModel?.getMessageCount() ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		guard let message=viewModel?.getMessage(at:indexPath.row),
			  let mobileNumber=user?.mobileNumber,
			  let senderId=message.sender?.userId
			  else {return UITableViewCell()}
		
		
		
		
		if mobileNumber == senderId,
		   let  incomingCell=tableView.dequeueReusableCell(withIdentifier:"TextMessageIncomingCell", for: indexPath) as? TextMessageIncomingCell
		{
			incomingCell.message=message
			return incomingCell
		}
		else if let  outgoingCell=tableView.dequeueReusableCell(withIdentifier:"TextMessageOutgoingCell", for: indexPath) as? TextMessageOutgoingCell
		{
			outgoingCell.message=message
			return outgoingCell
		}
		else
		{
			return UITableViewCell()
		}
		
		
	}

}

extension ChatVC:UITableViewDelegate
{
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
	return 80
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		
		
	}

}

// ViewController.swift
extension ChatVC:SBDChannelDelegate {
	
	func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage) {
		if let message=message as? SBDUserMessage
		{
			viewModel?.addMessage(message:message)
			tableView.reloadData()
		}
	}

	func channel(_ sender: SBDBaseChannel, didUpdate message: SBDBaseMessage) {
	}

	func channel(_ sender: SBDBaseChannel, messageWasDeleted messageId: Int64) {
	}

	func channel(_ channel: SBDBaseChannel, didReceiveMention message: SBDBaseMessage) {
	}

	
}
