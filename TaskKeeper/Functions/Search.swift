//
//  Search.swift
//  SAC1c-2024-solution
//
//  Created by Michael Robertson on 26/7/2024.
//

import Foundation


/*
 Function: Linear search for login to check if given username and password matches one within a file.
If it matches, the ID is returned. Else, -1 is returned
 */
func linearSearchLogin(array: [User], searchFor: User) -> Int {
    
    for currentValue in array {
        if searchFor.userName == currentValue.userName && searchFor.passWord == currentValue.passWord
             {
            return currentValue.userId
            }
        }
    return -1
}
