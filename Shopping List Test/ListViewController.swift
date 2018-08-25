//
//  ListViewController.swift
//  Shopping List Test
//
//  Created by Junlin Mo on 8/24/18.
//  Copyright © 2018 Junlin Mo. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, AddItemViewControllerDelegate {
    
    let CellIdentifier = "Cell identifier"
    
    var items = [Item]()
    
    // MARK: -
    // MARK: Add Item View Controller Delegate Methods
    func controller(controller: AddItemViewController, didSaveItemWithName name: String, andPrice price: Float) {
        // Create Item
        let item = Item(name: name, price: price)
        
        // Add Item to Items
        items.append(item)
        
        // Add Row to Table View
        tableView.insertRows(at: [NSIndexPath(row: (items.count - 1), section: 0) as IndexPath], with: .none)
        
        // Save Items
        saveItems()
    }
    // MARK: -
    // MARK: INITIALIZATION
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        // Load Items
        loadItems()
    }
    
    private func loadItems() {
        if let filePath = pathForItems(), FileManager.default.fileExists(atPath: filePath) {
            
            if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Item]{
                items = archivedItems
            }
            
        }
    }
    
    private func pathForItems() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        if let documents = paths.first, let documentsURL = NSURL(string: documents) {
            return documentsURL.appendingPathComponent("items.plist")?.path
        }
        
        return nil
    }
    
    private func saveItems() {
        if let filePath = pathForItems() {
            NSKeyedArchiver.archiveRootObject(items, toFile: filePath)
        }
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        // let item = Item()
        // print(item.uuid)
        title = "Items"
        
        // Register Class
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: CellIdentifier)

        // Create Add Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: "addItem:")
        
        // Create Edit Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: "editItems:")
        
        print(items)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func addItem(sender: UIBarButtonItem) {
        func addItem(sender: UIBarButtonItem) {
            performSegue(withIdentifier: "AddItemViewController", sender: self)
        }
        print("Button was tapped.")
    }
    
    func editItems(sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        
        // Fetch Item
        let item = items[indexPath.row]
        
        // Configure Table View Cell
        cell.textLabel?.text = item.name
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete Item from Items
            items.remove(at: indexPath.row)
            
            // Update Table View
            tableView.deleteRows(at: [indexPath], with: .right)
            
            // Save Changes
            saveItems()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemViewController" {
            if let navigationController = segue.destination as? UINavigationController,
                let addItemViewController = navigationController.viewControllers.first as? AddItemViewController {
                addItemViewController.delegate = self
            }
        }
    }
    

}
