//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Anna Melekhina on 15.11.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    var categories: Results<Category>?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
    }

    // MARK: TableView Datasourse methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        print("cell for row at")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel!.text = categories?[indexPath.row].name ?? "No categories"
        
        
//        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    
    
    // MARK: TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
    
    // MARK: Data manipulation methods
    func save(category: Category) {
        do {
            
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error saving context \(error.localizedDescription)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
 
        categories = realm.objects(Category.self)
         
        tableView.reloadData()

        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { action in
            print("success")
            
            
            let categor = Category()
            categor.name = textField.text!
            
            self.save(category: categor)
            
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new  item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}
