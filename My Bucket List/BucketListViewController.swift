//
//  ViewController.swift
//  My Bucket List
//
//  Created by Ian Yang on 3/18/18.
//  Copyright © 2018 Ian Yang. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
    var items = [BucketListItem]()
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        manageObjectContext.delete(item)
        items.remove(at: indexPath.row)
        tableView.reloadData()
        appDelegate.saveContext()
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "AddItemSegue", sender: indexPath)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
        addItemTableViewController.delegate = self
        
        if let indexPath = sender as? NSIndexPath {
            let item = items[indexPath.row]
            addItemTableViewController.item = item.text!
            addItemTableViewController.indexPath = indexPath
        }
    }
    
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        
        do {
            let result = try manageObjectContext.fetch(request)
            items = result as! [BucketListItem]
        } catch {
            print("\(error)")
        }
    }
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        
        if let ip = indexPath {
            let item = items[ip.row]
            item.text = text
            
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: manageObjectContext) as! BucketListItem
            item.text = text
            items.append(item)
            appDelegate.saveContext()
            
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }
    
}

