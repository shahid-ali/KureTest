//
//  ViewController.swift
//  KureTest
//
//  Created by Shahid Ali on 7/23/21.
//

import UIKit

class UserListVC: UIViewController {

	private let viewModel=UserListVM()
	
	@IBOutlet weak var tableView: UITableView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		viewModel.fetchUsers {[weak self] users, error in
			if let error=error
			{
				//show error message to user
				return
			}
			
			self?.tableView.reloadData()
		 }
	}
	
	private func setupView()
	{
		title="Users"
		tableView.register(UINib.init(nibName:"UserCell", bundle:nil), forCellReuseIdentifier: "UserCell")
	}
	
	
	
}

extension UserListVC:UITableViewDataSource
{
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return viewModel.getUserCount()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		if let userCell=tableView.dequeueReusableCell(withIdentifier:"UserCell", for: indexPath) as? UserCell,
		   let user=viewModel.getUser(index:indexPath.row)
		{
			userCell.user=user
			return userCell
		}
		else
		{
			return UITableViewCell()
		}
	}

}

extension UserListVC:UITableViewDelegate
{
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
	return 80
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		if let user=viewModel.getUser(index:indexPath.row),
		   let chatVC=UIStoryboard(name:"Chat", bundle: nil).instantiateViewController(identifier:"ChatVC") as? ChatVC,
		   let navVC=self.navigationController
		{
			chatVC.user=user
			navVC.pushViewController(chatVC, animated:true)
		}
		
	}

}


