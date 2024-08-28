//
//  ViewController.swift
//  SAC1c-2024-solution
//
//  Created by Michael Robertson on 3/4/2024.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //inputs
    @IBOutlet weak var txtTaskName: UITextField!
    @IBOutlet weak var txtDueDate: UITextField!
    @IBOutlet weak var txtCompletionTime: UITextField!
    @IBOutlet weak var segPriority: UISegmentedControl!
    @IBOutlet weak var segSortType: UISegmentedControl!
    
    //outputs
    @IBOutlet weak var lblPriorityTaskCount: UILabel!
    @IBOutlet weak var lblAverageTime: UILabel!
    @IBOutlet weak var tblTaskList: UITableView!
    @IBOutlet weak var lblUserName: UILabel!
    
    //global data
    
    /*
     ------------------------------------------------------------
     Task Struct now made as a class in "Task.swift"
     ------------------------------------------------------------
     */
    
    var sortType: String = "date"
    let red: UIColor = UIColor(red: 255/255, green: 20/255, blue: 20/255, alpha: 0.8)
    let orange: UIColor = UIColor(red: 255/255, green: 177/255, blue: 69/255, alpha: 0.8)
    let teal: UIColor = UIColor(red: 100/255, green: 255/255, blue: 255/255, alpha: 0.8)
    
    
    
    /*
     ----------- Button Actions and Functions -----------
     */
    
    
    /*Function: When add task button is pressed:
     - Add a task to the taskList array if no fields are empty
     - Sort the array as required
     - Update and calculate the required values for priority tasks and average time
     */
    @IBAction func btnAddTask(_ sender: Any) {
        
        if (txtDueDate.text != "" && txtTaskName.text != "" && txtCompletionTime.text != "") {
            
            let newTask: Task = Task.init()
            newTask.dueDate = txtDueDate.text!
            newTask.taskName = txtTaskName.text!
            newTask.completionTime = Int(txtCompletionTime.text!)!
            newTask.priority = segPriority.selectedSegmentIndex
            
            taskList.append(newTask)
            sort()
            clear()
            updateValues()
            tblTaskList.reloadData()
            
            
        }
        else {
            //TODO ALERT HERE!
        }
        
        
    }
    
    
    //Function: When clear button is pressed: clears all fields and emptys taskList array
    @IBAction func btnClear(_ sender: Any) {
        clear()
        
    }
    
    //Function: When save button is pressed: saves all data to file
    @IBAction func btnSave(_ sender: Any) {
        taskListSave()
    }
    
    
    @IBAction func segChangeSort(_ sender: Any) {
        if (segSortType.selectedSegmentIndex == 1) {
            sortType = "priority"
        }
        else {
            sortType = "date"
        }
        sort()
    }
    
    /*
     ----------- General Functions -----------
     */
    
    //Function: update values after calculating average time for a task and the amount of priority tasks to all tasks
    func updateValues() {
        
        var highPriorityCount: Int = 0
        var timeCount: Int = 0
        var timeHours: Int = 0
        var timeMinutes: Int = 0
        
        for eachTask in taskList {
            if (eachTask.priority == 0) {
                highPriorityCount += 1
            }
            timeCount += eachTask.completionTime
        }
        
        let averageTime: Float = Float(timeCount / taskList.count)
        
        let priorityTaskRatio: Float = Float(highPriorityCount) / Float(taskList.count)
        
        var x: Float = 12.9
        x.round(.down)
        let y: Int = Int(x)
        print(y)
        
        let hour: Int = 60
        if (averageTime >= 60) {
            timeHours = Int(averageTime) / hour
            timeMinutes = Int(averageTime) % hour
            lblAverageTime.text = "\(timeHours) h \(timeMinutes) m"
        }
        else {
            timeMinutes = Int(averageTime) % hour
            lblAverageTime.text = "\(timeMinutes) m"
        }
        
        if (priorityTaskRatio > 0.5) {
            lblPriorityTaskCount.backgroundColor = red
        }
        else if (priorityTaskRatio > 0.3) {
            lblPriorityTaskCount.backgroundColor = orange
        }
        else {
            lblPriorityTaskCount.backgroundColor = teal
        }
        
        lblPriorityTaskCount.text = "\(highPriorityCount) / \(taskList.count)"
        
    }
    
    
    func clear() {
        lblAverageTime.text = ""
        lblPriorityTaskCount.text = ""
        txtDueDate.text = ""
        txtTaskName.text = ""
        txtCompletionTime.text = ""
        segPriority.selectedSegmentIndex = 0
        segSortType.selectedSegmentIndex = 0
    }
    
    
    @IBAction func btnLogout(_ sender: Any) {
        
        currentUser.userName = ""
        currentUser.passWord = ""
        currentUser.userId = -1
        
        performSegue(withIdentifier: "logoutSegue", sender: nil)
        
        //Confirmation for alert given here
        
        
    }
    
    
    
    
    /*
     
     IO FUNCTIONS NOW MOVED TO "IO.SWIFT"
     
     */

    
    func sort() {
        if (taskList.count < 10) {
            taskList = selectionSort(array: taskList, sortBy: sortType)
        }
        else {
            taskList = selectionSort(array: taskList, sortBy: sortType)
        }
        tblTaskList.reloadData()
    }
    
    /*
     ----------- Tableview Functions -----------
     */
    
    //Function: Creates tableview with rows equal to the tasklist amount
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    //Function: Fills tableview with required string from array
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let priority = taskList[indexPath.row].priority
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = taskList[indexPath.row].toString()
        
        if (priority == 0) {
            cell.backgroundColor = red
        }
        else if (priority == 1) {
            cell.backgroundColor = orange
        }
        else {
            cell.backgroundColor = teal
        }
        
        return cell
    }
    
    //Function: Swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            taskList.remove(at: indexPath.row)
            tblTaskList.reloadData()
        }

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblTaskList.dataSource = self
        tblTaskList.delegate = self
        taskListLoad()
        
        
        //This will take a user object and grab the username
        lblUserName.text = String(currentUser.userName)
        
        if taskList.count > 0 {
            updateValues()
        }
        
        tblTaskList.reloadData()
    }
    
    
}

