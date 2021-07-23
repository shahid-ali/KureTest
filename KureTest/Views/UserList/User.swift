//
//  User.swift
//  KureTest
//
//  Created by Shahid Ali on 7/23/21.
//

//mobile number
//name

class User
{
	var mobileNumber:String
	var name:String
	
	
	init(data:[String:Any])
	{
		if let number=data["mobileNumber"] as? String
		{
		mobileNumber=number
		}
		else
		{
			mobileNumber=""
		}
		
		
		if let firstName=data["firstName"] as? String,
		   let lastName=data["lastName"] as? String
		{
		name="\(firstName) \(lastName)"
		}
		else
		{
		name=""
		}
	 }
}


