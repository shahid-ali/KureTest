//
//  UserListVM.swift
//  KureTest
//
//  Created by Shahid Ali on 7/23/21.
//

class UserListVM
{
	private var users:[User]=[]
	
	func fetchUsers(completion:@escaping([User],Error?) -> Void)
	{
		FirestoreManager.shared.db.collection("/usersContacts/2gyQ7XUMuxZx3OCoqmivOdjLMFK2/2gyQ7XUMuxZx3OCoqmivOdjLMFK2").limit(to:20).addSnapshotListener(includeMetadataChanges:false) {[weak self] snapShot, error in
			
			if let error=error
			{
				completion([],error)
			}
			else
			{
				guard let strongSelf=self else {
					completion([],nil)
					return
				}
				
				if let snapShot=snapShot
				{
					for doc in snapShot.documents
					{
						let user=User(data:doc.data())
						strongSelf.users.append(user)
						
					}
				}
				completion(strongSelf.users,nil)
			}
		}
	}
	
	func getUserCount() -> Int
	{
		users.count
	}
	
	func getUser(index:Int) -> User?
	{
		if users.count > index
		{
			return users[index]
		}
		else
		{
			return nil
		}
	}
	
	
}
