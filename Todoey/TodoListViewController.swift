//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    //    let defaults = UserDefaults.standard
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
        
    }
    
    
    // MARK: TableView Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        print("cell for row at")
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel!.text = item.title
        
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    // MARK: TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        itemArray[indexPath.row].setValue("completed", forKey: "title")   // changing the title inside the table
        
        itemArray[indexPath.row].done.toggle()
        
        
//  MARK: DELETING and saving the changes
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { action in
            print("success")
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new  item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        do {
            
            try context.save()
        } catch {
            print("error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {     // у функции есть аргумент и сразу дефолтное значение аргумента
 
        do {
           itemArray = try context.fetch(request)
        
        } catch {
            print("error fetching (loading) context \(error)")
        }
        tableView.reloadData()

        
    }
    
}
  
// MARK: SearchBar methods

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()     //создаем запрос

        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)   //фильтры запроса. тайтл содержит "фильтр", cd = case, diactric insensitive
                
          //вывести результаты тайтл в восходящем (алфавитном) порядке
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        // + перезагрузить таблицу (внутри лоад айтемс)

        loadItems(with: request)
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()   // убирает клавиатуру, серч бар неактивный
            }
        }
    }
    
   
    
        
    
}
