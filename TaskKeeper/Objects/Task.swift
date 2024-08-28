//
//  Task.swift
//  SAC1c-2024-solution
//
//  Created by Michael Robertson on 24/6/2024.
//

import Foundation

class Task: Codable {
    
    var taskName: String = ""
    var dueDate: String = ""
    var completionTime: Int = 0
    var priority: Int = 0
        
        //Method: prints all values to a string that is displayed in the tableview cell
        func toString() -> String {
            var priorString: String = "high"
            var timeHours: Int = 0
            var timeMinutes: Int = 0
            
            if (priority == 1) {
                priorString = "med"
            }
            else if (priority == 2) {
                priorString = "low"
            }
            
            if (completionTime >= 60) {
                timeHours = completionTime / 60
                timeMinutes = completionTime % 60
                return "\(taskName) | Due: \(dueDate) |  \(timeHours)h \(timeMinutes)m | \(priorString)"
            }
            else {
                return "\(taskName) | Due: \(dueDate) |  \(completionTime)m | \(priorString)"
            }
        }
    }


var taskList: [Task] = []

