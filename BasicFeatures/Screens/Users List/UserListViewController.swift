//
//  UserListViewController.swift
//  BasicFeatures
//
//  Created by Arshdeep on 2022-10-17.
//

import UIKit

class UserListViewController: UIViewController {

    var userListViewModel:UserListViewModel!
    static let reuseIdentifier = "userIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initViewModel()
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UserListViewController {
    func initViewModel(){
        userListViewModel = UserListViewModel()
        
        reloadTableViewClosure()
    }
    
    func reloadTableViewClosure() {
        userListViewModel.reloadTableViewClosure = { [weak self] () in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

extension UserListViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return userListViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListViewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserListViewController.reuseIdentifier, for: indexPath) as! UserListTableViewCell
        let data = userListViewModel.dataForRow(at: indexPath)
        cell.userFullNameLabel.text = data.fullName
        cell.genderLabel.text = data.gender
        cell.genderLabel.textColor = data.genderColor
        cell.userImageView.image = data.image
        return cell
    }
}

extension UserListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return userListViewModel.heightForRow()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return userListViewModel.titleForHeader(in: section)
    }
}

class UserListTableViewCell:UITableViewCell {
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
}
