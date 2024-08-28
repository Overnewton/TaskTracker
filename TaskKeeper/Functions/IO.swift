//
//  IO.swift
//  SAC1c-2024-solution
//
//  Created by Michael Robertson on 24/6/2024.
//

import Foundation


/*
 Function: Loads the task list
 Loads the task list depending on the user ID that is currently logged in
 */

func taskListLoad() {
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    do {
       let decoder = JSONDecoder()
//       let jsonURL = URL(fileURLWithPath: "taskList.json", relativeTo: directoryURL)
        let jsonURL = URL(fileURLWithPath: "\(currentUser.userId)-taskList.json", relativeTo: directoryURL)
        let jsonData = try Data(contentsOf: jsonURL)
       taskList = try decoder.decode([Task].self, from: jsonData)
       print("json file was successfully imported")
    } catch {
       print("file could not be imported")
    }
    
}

/*
 Function: Saves the task list
 Loads the task list depending on the user ID that is currently logged in
 */

func taskListSave() {
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    do {
       let encoder = JSONEncoder()
       encoder.outputFormatting = .prettyPrinted
       let jsonData = try! encoder.encode(taskList)
       let jsonString: String = String(data: jsonData, encoding: .utf8)!
       let jsonURL: URL = URL(fileURLWithPath: "\(currentUser.userId)-taskList.json", relativeTo: directoryURL)
       try jsonString.write(to: jsonURL, atomically: true, encoding: .utf8)
       print("file was successfully exported")
    } catch {
       print("file could not be exported")
    }
}

/*
 Function: Saves the user list
 */

func userRegisterSave() {
    
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    do {
       let encoder = JSONEncoder()
       encoder.outputFormatting = .prettyPrinted
       let jsonData = try! encoder.encode(userList)
       let jsonString: String = String(data: jsonData, encoding: .utf8)!
       let jsonURL: URL = URL(fileURLWithPath: "userList.json", relativeTo: directoryURL)
       try jsonString.write(to: jsonURL, atomically: true, encoding: .utf8)
       print("file was successfully exported")
        print(directoryURL)
    } catch {
       print("file could not be exported")
    }
}



/*
 Function: Loads the user list
 */

func userListLoad() {
    let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    do {
       let decoder = JSONDecoder()
       let jsonURL = URL(fileURLWithPath: "userList.json", relativeTo: directoryURL)
       let jsonData = try Data(contentsOf: jsonURL)
       userList = try decoder.decode([User].self, from: jsonData)
       print("json file was successfully imported")
        print(directoryURL)
    } catch {
       print("file could not be imported")
    }
    
}


func cipherText(message: String, shift: Int) -> String {
   let encrypt = message.unicodeScalars.map {
      //loop through each character in message
      //identify number representation
      //add shift to number
      UnicodeScalar(Int($0.value) + shift)!
   }

   //return shifted message
   return String(String.UnicodeScalarView(encrypt))
}
