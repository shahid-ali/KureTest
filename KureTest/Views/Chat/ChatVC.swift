//
//  ChatVC.swift
//  KureTest
//
//  Created by Shahid Ali on 7/23/21.
//

import UIKit

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
			  let type=message.customType else {return UITableViewCell()}
		
		
		if type == MessageSource.incoming.rawValue,
		   let  incomingCell=tableView.dequeueReusableCell(withIdentifier:"TextMessageIncomingCell", for: indexPath) as? TextMessageIncomingCell
		{
			incomingCell.message=message
			return incomingCell
		}
		else if type == MessageSource.outgoing.rawValue,
		let  outgoingCell=tableView.dequeueReusableCell(withIdentifier:"TextMessageOutgoingCell", for: indexPath) as? TextMessageOutgoingCell
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

