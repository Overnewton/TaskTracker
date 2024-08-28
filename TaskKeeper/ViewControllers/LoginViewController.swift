//
//  LoginViewController.swift
//  SAC1c-2024-solution
//
//  Created by Michael Robertson on 19/7/2024.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtUserName: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    /*
     Function: Logs the user in from the entered details.
     The details are searched for in the search.
     If it's found then the user is logged in and currentUser is updated to the found details.
     Else, an alert is displayed
     */
    
    @IBAction func btnLogin(_ sender: Any) {
        
        let newUser: User = User.init()
        newUser.passWord = txtPassword.text!
        newUser.userName = txtUserName.text!
        
        
        
        //TODO - Write function to encrypt password through a cipher given in previous lessons
        
        let searchedUserId = linearSearchLogin(array: userList, searchFor: newUser)
        
        if searchedUserId != -1 {
            
            newUser.userId = searchedUserId
            currentUser = newUser
    
            print("\(newUser.userId) is the currently logged in ID")
            
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
        else {
            alert(message: "Username or password is incorrect")
        }
        
    }
    
    /*
     Function: Registers the user from the entered details.
     The details are searched for in the search. 
     If it's not found then a new user is created
     Else, an alert is displayed
     */
    
    @IBAction func btnRegisterUser(_ sender: Any) {
        
        let newUser: User = User.init()
        newUser.passWord = txtPassword.text!
        newUser.userName = txtUserName.text!
        newUser.passWord = cipherText(message: newUser.passWord, shift: 16)
        
        //TODO - Write function to encrypt password through a cipher given in previous lessons
        
        if linearSearchLogin(array: userList, searchFor: newUser) == -1 {
            if (userList.count > 0) {
                newUser.userId = userList.last!.userId + 1
            }
            else {
                newUser.userId = 1
            }
            userList.append(newUser)
            
            userRegisterSave()
            txtPassword.text = ""
            txtUserName.text = ""
            
            alert(message: "\(newUser.userName) has successfully been registered")
        }
        else {
            alert(message: "The user is already registered")
        }
    }
  
    func alert(message: String) {
        //position attribute is only used when an reading is deleted
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(yesButton)
        self.present(alert, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        userListLoad()
        // Do any additional setup after loading the view.
    }
    

}
