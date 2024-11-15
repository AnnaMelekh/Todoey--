//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Anna Melekhina on 15.11.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
    }

  

   
    
    // MARK: TableView Datasourse methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        print("cell for row at")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel!.text = categoryArray[indexPath.row].name
        
        
//        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    
    
    // MARK: TableView Delegate methods
    
    
    
    // MARK: Data manipulation methods
    func saveItems() {
        do {
            
            try context.save()
        } catch {
            print("error saving context \(error.localizedDescription)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
 
        do {
           categoryArray = try context.fetch(request)
        
        } catch {
            print("error fetching (loading) context \(error)")
        }
        tableView.reloadData()

        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { action in
            print("success")
            
            
            let categor = Category(context: self.context)
            categor.name = textField.text!
            self.categoryArray.append(categor)
            
            self.saveItems()
            
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new  item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}
