//
//  UserListViewModel.swift
//  BasicFeatures
//
//  Created by Arshdeep on 2022-10-17.
//

import Foundation
import UIKit

class UserListViewModel {
    var users:[User]
    var genders:[String]
    var usersCellViewModel:[UserCellViewModel] {
        didSet {
            usersByGenderCellViewModel = []
            for gender in genders {
                usersByGenderCellViewModel.append(usersCellViewModel.filter({$0.gender == gender}))
            }
        }
    }
    
    var usersByGenderCellViewModel:[[UserCellViewModel]] {
        didSet {
            reloadTableViewClosure?()
        }
    }
    
    var reloadTableViewClosure: (() -> ())?
    
    init() {
        users = []
        usersCellViewModel = []
        usersByGenderCellViewModel = []
        genders = []
        
        //mockUsers()
        self.fetchUsers()
    }
    
    func mockUsers() {
        let name1:Name = Name(firstName: "John", lastName: "Clark", title: "Mr")
        let name2:Name = Name(firstName: "Arsh", lastName: "Kaur", title: "Mrs")
        let name3:Name = Name(firstName: "Johnson", lastName: "Mathew", title: "Mr")

        users = [User(name: name1, gender: Gender.male.rawValue, userImageUrl: "https://images.dog.ceo//breeds//borzoi//n02090622_9662.jpg"),
                 User(name: name2, gender: Gender.female.rawValue, userImageUrl: "https://images.dog.ceo//breeds//borzoi//n02090622_9662.jpg"),
                 User(name: name3, gender: Gender.male.rawValue, userImageUrl: "https://images.dog.ceo//breeds//borzoi//n02090622_9662.jpg")]
//       users = [User(firstName: "John", lastName: "Clark", gender: "Male", userImageUrl: "https://images.dog.ceo//breeds//borzoi//n02090622_9662.jpg"),
//                User(firstName: "Arsh", lastName: "Kaur", gender: "Female", userImageUrl: "https://images.dog.ceo//breeds//borzoi//n02090622_9662.jpg"),
//                User(firstName: "Johnson", lastName: "Mathew", gender: "Male", userImageUrl: "https://images.dog.ceo//breeds//borzoi//n02090622_9662.jpg")]
        
        parseUsers()
    }
    
    func parseUsers() {
        let genders = Set(users.map({$0.gender!}))
         self.genders = Array(genders)
         createUsersByGender()
    }
    
    func fetchUsers() {
        Request().perform(for: UserResponse.self, url: Request.APIUrl.userList.rawValue) { result in
           /* if let users = responseData["results"] as? [String:Any] {
            }*/
            switch result {
            case let .success(userResponse):
                self.users = userResponse.users ?? []
                self.parseUsers()
            case let .failure(error):
                print("localizedDescription: \(error.localizedDescription)")
            }
        }
    }
    
    func createUsersByGender() {
        for user in users {
            createUserViewModel(user: user) { userCellViewModel in
                self.usersCellViewModel.append(userCellViewModel)
            }
        }
    }
    
    func createUserViewModel(user:User, completion: @escaping (UserCellViewModel) ->  Void) {
        let fullName = (user.name?.firstName ?? "") + " " + (user.name?.lastName ?? "")
        let gender = user.gender ?? Gender.male.rawValue
        let genderColor = user.gender == Gender.male.rawValue ? UIColor.blue : UIColor.systemPink
        let url = "https://images.dog.ceo//breeds//borzoi//n02090622_9662.jpg"
       // if let imageUrl = user.userImageUrl {
            Request().downloadData(url: url) { data in
                var image = UIImage()
                if let data = data {
                    image = UIImage(data: data)!
                }
                completion (UserCellViewModel(fullName: fullName, gender: gender, genderColor: genderColor, image: image))
            }
//        }
//        else {
//            completion (UserCellViewModel(fullName: fullName, gender: gender, genderColor: genderColor, image: UIImage()))
//        }
    }
    
   
    
    func numberOfSections() -> Int {
        return usersByGenderCellViewModel.count
    }
    
    func numberOfRows(in section:Int) -> Int {
        return usersByGenderCellViewModel[section].count
    }
    
    func dataForRow(at indexPath:IndexPath) -> UserCellViewModel {
        let user = usersByGenderCellViewModel[indexPath.section][indexPath.row]
        return user
    }
    
    func heightForRow() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func titleForHeader(in section:Int) -> String {
        return genders[section]
    }
}

struct UserCellViewModel {
    let fullName:String
    let gender:String
    let genderColor:UIColor
    let image:UIImage
}
