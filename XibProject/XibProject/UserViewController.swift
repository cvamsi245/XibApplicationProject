//
//  UserViewController.swift
//  XibProject
//
//  Created by vamsi on 31/07/24.
//

import UIKit

// userviewcontroller
class UserViewController: UIViewController {
    
    @IBOutlet weak var UserTableView: UITableView!
    
    var users: [User] = []{
        didSet{
            DispatchQueue.main.async {
                self.UserTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserTableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
    
    private func getUsers() {
        let urlString = "https://jsonplaceholder.typicode.com/users"
        NetworkManager.shared.fetchData(from: urlString, ofType: [User].self) { result in
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                print(error)
            }
        }
    }
        override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUsers()
    }
}
extension UserViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = UserTableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.NameLabel.text = users[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsTableViewController") as? UserDetailsTableViewController else { return }
        detailVC.userDetails = users[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
