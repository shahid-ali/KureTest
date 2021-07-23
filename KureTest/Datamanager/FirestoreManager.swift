//
//  FirestoreManager.swift
//  KureTest
//
//  Created by Shahid Ali on 7/23/21.
//

import Firebase


class FirestoreManager
{
	let db = Firestore.firestore()
	static let shared=FirestoreManager()
	
	private init()
	{}
	
}
