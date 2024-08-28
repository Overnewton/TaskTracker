//
//  Sort.swift
//  SAC1c-2024-solution
//
//  Created by Michael Robertson on 26/7/2024.
//

import Foundation


/*
 Sort functions
 */

//Selection Sort
func selectionSort(array: [Task], sortBy: String) -> [Task] {
    if array.count > 1 {
        var arr = array
        for x in 0 ..< arr.count - 1 {
            var lowest = x
            for y in x + 1 ..< arr.count {
                if (sortBy == "date"){
                    if arr[y].dueDate < arr[lowest].dueDate {
                        lowest = y
                    }
                }
                else {
                    if arr[y].priority < arr[lowest].priority {
                        lowest = y
                    }
                }
            }
            if x != lowest {
                arr.swapAt(x, lowest)
            }
        }
        return arr
    } else {
        return array
    }
}

//Quick sort
func quickSort(array: [Task], sortBy: String) -> [Task] {
    var less: [Task] = []
    var equal: [Task] = []
    var greater: [Task] = []
    if array.count > 1 {
        let pivot = array[array.count - 1]
        for x in array {
            if (sortBy == "date") {
                if x.dueDate < pivot.dueDate {
                    less.append(x)
                }
                if x.dueDate == pivot.dueDate {
                    equal.append(x)
                }
                if x.dueDate > pivot.dueDate {
                    greater.append(x)
                }
            }
            
            else {
                if x.priority < pivot.priority {
                    less.append(x)
                }
                if x.priority == pivot.priority {
                    equal.append(x)
                }
                if x.priority > pivot.priority {
                    greater.append(x)
                }
            }
        }
        return (quickSort(array: less,sortBy: sortBy) + equal + quickSort(array: greater,sortBy: sortBy))
    } else {
        return array
    }
}
