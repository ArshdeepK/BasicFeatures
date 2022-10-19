//
//  User.swift
//  BasicFeatures
//
//  Created by Arshdeep on 2022-10-17.
//

import Foundation


/*
 struct ServerResponse<T:Codable>:Codable {
      var results:T? = nil
 }
 */
struct UserResponse:Codable {
     var users:[User]? = nil
}

extension UserResponse {
    enum CodingKeys: String, CodingKey {
        case users = "results"
    }
}

struct User:Codable {
    let name:Name?
    let gender:String?
    var userImageUrl:String?
    
    init (name:Name, gender:String, userImageUrl:String) {
        self.name = name
        self.gender = gender
        self.userImageUrl = userImageUrl
    }
}

extension User {
    enum CodingKeys: String, CodingKey {
        case name
        case gender
        case userImageUrl
    }
}

struct Name: Codable {
    let firstName:String?
    let lastName:String?
    let title:String?
}

extension Name {
    enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
        case title
    }
}

enum Gender:String {
    case male = "male"
    case female = "female"
}


/*
 {
     "results": [{
         "gender": "male",
         "name": {
             "title": "Mr",
             "first": "Harry",
             "last": "Wilson"
         },
         "location": {
             "street": {
                 "number": 2871,
                 "name": "North Road"
             },
             "city": "Nelson",
             "state": "Marlborough",
             "country": "New Zealand",
             "postcode": 60441,
             "coordinates": {
                 "latitude": "55.0412",
                 "longitude": "-145.6227"
             },
             "timezone": {
                 "offset": "+5:30",
                 "description": "Bombay, Calcutta, Madras, New Delhi"
             }
         },
         "email": "harry.wilson@example.com",
         "login": {
             "uuid": "6eb49868-06aa-4570-8db8-2f402be684ec",
             "username": "sadlion242",
             "password": "star69",
             "salt": "cxQMvBcp",
             "md5": "16d95d657568817c15b463d5c5f4b8fb",
             "sha1": "8d908a0d7a0c20cae8e544433ed61cd0a6080629",
             "sha256": "e963d25d0472043b2952d6d7c6d9218acb886321104242f0ec9bab85dec68b94"
         },
         "dob": {
             "date": "1999-05-31T20:17:36.674Z",
             "age": 23
         },
         "registered": {
             "date": "2008-04-28T11:56:28.512Z",
             "age": 14
         },
         "phone": "(179)-452-8777",
         "cell": "(101)-720-5834",
         "id": {
             "name": "",
             "value": null
         },
         "picture": {
             "large": "https://randomuser.me/api/portraits/men/3.jpg",
             "medium": "https://randomuser.me/api/portraits/med/men/3.jpg",
             "thumbnail": "https://randomuser.me/api/portraits/thumb/men/3.jpg"
         },
         "nat": "NZ"
     }],
     "info": {
         "seed": "67e16e4c4ef632c3",
         "results": 1,
         "page": 1,
         "version": "1.4"
     }
 }
 */
