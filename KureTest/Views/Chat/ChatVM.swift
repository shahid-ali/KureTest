//
//  ChatVM.swift
//  KureTest
//
//  Created by Shahid Ali on 7/23/21.
//

import SendBirdSDK

class ChatVM {

	private var receiverUser:User
	private var currentUserId:String
	private var channel:SBDGroupChannel?
	
	private var messages:[SBDUserMessage]=[]
	
	init(user:User)
	{
		self.receiverUser=user
		self.currentUserId=Literals.currentUserId
	}
	
	func openChannel(completionHandler:@escaping(Error?) -> Void)
	{
		SBDGroupChannel.createChannel(withUserIds: [currentUserId,receiverUser.mobileNumber], isDistinct: true, completionHandler: {[weak self] (groupChannel, error) in
			guard error == nil else {
				completionHandler(error)
				return
			}
			self?.channel=groupChannel
			completionHandler(nil)
		})
	}
	
	func sendText(message:String,completion:@escaping(Error?)->Void)
	{
		
		if let message=SBDUserMessageParams(message:message)
		{
		message.customType=MessageSource.outgoing.rawValue
		
		channel?.sendUserMessage(with: message, completionHandler: {[weak self] sbdMessage, sbdError in
			if let error=sbdError
			{
			completion(error)
			}
			else if let sbdMessage=sbdMessage
			{
			self?.messages.append(sbdMessage)
			}
			completion(nil)
		})
		}
	}
	
	func getMessageCount() -> Int
	{
		return messages.count
	}
	
	
	func getMessage(at:Int) -> SBDUserMessage?
	{
		if messages.count > at
		{
			return messages[at]
		}
		return nil
	}
	
}
