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
        
        //Existence check: If username and password isn't blank, then check login
        if txtUserName.text! != "" && txtPassword.text! != "" {
            
            //Initiate a new user object and save the username and ciphertext password to it
            let newUser: User = User.init()
            newUser.passWord = cipherText(message: txtPassword.text!, shift: 3)
            newUser.userName = txtUserName.text!
            
            
            //Search for user from text boxes in the created JSON file
            let searchedUserId = linearSearchLogin(array: userList, searchFor: newUser)
            
            //If the user is found then the currentUser is saved with the attempted login credentials & goes to the next screen
            if searchedUserId != -1 {
                
                newUser.userId = searchedUserId
                currentUser = newUser
                
                print("\(newUser.userId) is the currently logged in ID")
                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            //Else an alert is displayed to state that details are incorrect
            else {
                alert(message: "Username or password is incorrect")
            }
        }
        
        //Else if a field is blank, tell the user
        else {
            alert(message: "Username or password is empty")
        }
    }
    
    /*
     Function: Registers the user from the entered details.
     The details are searched for in the search. 
     If it's not found then a new user is created
     Else, an alert is displayed
     */
    
    @IBAction func btnRegisterUser(_ sender: Any) {
        
        //Existence check: If username and password isn't blank, then check login
        if txtUserName.text! != "" && txtPassword.text! != "" {
            
            let newUser: User = User.init()
            newUser.passWord = txtPassword.text!
            newUser.userName = txtUserName.text!
            print("password before cipher: " + newUser.passWord)
            newUser.passWord = cipherText(message: newUser.passWord, shift: 3)
            print("password after cipher: " + newUser.passWord)
            
            print(newUser.passWord)
            print(newUser.userName)
            
            //Linear search algorithm to see if user exists in the file
            if linearSearchLogin(array: userList, searchFor: newUser) == -1 {
                
                //If they don't exist and there's at least 1 user in the loaded array, then their ID is the amount of users +1
                if (userList.count > 0) {
                    newUser.userId = userList.last!.userId + 1
                }
                //else their ID is one. Lucky!
                else {
                    newUser.userId = 1
                }
                
                //Add the user to the user list
                userList.append(newUser)
                
                //Save the userList to a JSON file to load and save to later
                userRegisterSave()
                
                //Reset the text fields to be blank
                txtPassword.text = ""
                txtUserName.text = ""
                
                //Show the alert message that the user has been registered.
                alert(message: "\(newUser.userName) has successfully been registered")
            }
            
            //If the user is found in the array, state the user is already registered
            else {
                alert(message: "The user is already registered")
            }
        }
        
        //Else if a field is blank, tell the user
        else {
            alert(message: "Username or password is empty")
        }
    }
  
    
    /*
     Function: Alert for user information and errors.
     A message is passed to the alert.
     A warning is given with the given message shown to the user
     */
    
    func alert(message: String) {
        //position attribute is only used when an reading is deleted
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(yesButton)
        self.present(alert, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //remove all tasks from task list that may have been loaded previously
        ///NOTE: This may be a great lesson as to why we have methods, functions and data that is PUBLIC or PRIVATE.
        ///Being able to modify this array from here rather than through an intended method or class is normally bad practice and NotGood™
        taskList.removeAll()
        
        //load user list to array
        userListLoad()
        // Do any additional setup after loading the view.
    }
    

}
