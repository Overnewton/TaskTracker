//
//  User.swift
//  SAC1c-2024-solution
//
//  Created by Michael Robertson on 28/6/2024.
//

import Foundation


class User: Codable {
    
    var userId: Int = 0
    var userName: String = ""
    var passWord: String = ""
    
}

var userList: [User] = []

var currentUser: User = User.init()

