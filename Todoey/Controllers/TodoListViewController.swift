//
//  ViewController.swift
//  Todoey
//
//  Created by Ruth Lycke on 4/22/19.
//  Copyright © 2019 tcmrestoration. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item .plist")
// var itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon"]
//    let defaults = UserDefaults()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        print(dataFilePath)
        
        
//        let newItem = Item ()
//        newItem.title = "Find Mike"
////        newItem.done = true
//        itemArray.append(newItem)
//
//        let newItem2 = Item ()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item ()
//        newItem3.title = "Destory Demogorgon"
//        itemArray.append(newItem3)
        
        
        loadItems()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        
        // Do any additional setup after loading the view.
    }
    // Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
//        cell.textLabel?.text = itemArray[indexPath.row]
         cell.textLabel?.text = item.title
        //cell.textLabel?.text = itemArray[indexPath.row].title
        
        //Ternary operator==>
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
//        if item.done == true {
//            //if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
    return cell
        
    }
    //Tableview Delegete Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if  itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
//
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        } else {
//             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        saveItems()
//        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Mark - Add new Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
       let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once user clicks the Add Item button on our UIAlter
//            print("Success")
//            print(textField.text)
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
//          self.itemArray.append(textField.text!)
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
           
//            let encoder = PropertyListEncoder()
//
////            let data = encoder.encode(itemArray)
//            do {
//                let data = try encoder.encode(self.itemArray)
//
//                try data.write(to: self.dataFilePath!)
//            } catch {
//                print("Error endcoding item array, \(error)")
//            }
////            do {
////            let data = try encoder.encode(self.itemArray)
////                try data.write(to: self.dataFilePath!)
////
//           self.tableView.reloadData()
//            // after add this code reloaddata the new item we add will appear to the tableview
//            } catch {
//
            }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
//            print(alertTextField.text)
            textField = alertTextField
            
//            print(alertTextField)
//            print("now")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
            
        
    }
    
    //MARK -Model Manuplation Methods
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        //            let data = encoder.encode(itemArray)
        do {
            let data = try encoder.encode(itemArray)
            
            try data.write(to: dataFilePath!)
        } catch {
            print("Error endcoding item array, \(error)")
        }
         self.tableView.reloadData()
    }
    
    
    func loadItems() {
      if  let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
        do {
        itemArray = try decoder.decode([Item].self, from: data)
        } catch {
            print("Error decoding item array, \(error)")
        }
    }
}
    
}


