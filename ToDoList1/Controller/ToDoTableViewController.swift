//
//  ToDoTableViewController.swift
//  ToDoList1
//
//  Created by anna.zubakina on 01/11/2023.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController {
    
    @IBOutlet weak var addNewItemTapped: UIBarButtonItem!
    @IBOutlet weak var deleteAllButton: UIBarButtonItem!
    
    var managedObjectContext: NSManagedObjectContext?
    //    var toDos: [String] = []
    var toDoLists = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedObjectContext = appDelegate.persistentContainer.viewContext
        loadCoreData()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    @IBAction func addNewItemTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "To Do List", message: "Do you want to add new item?", preferredStyle: .alert)
        
        alertController.addTextField { titleTextField in
            titleTextField.placeholder = "Your title here..."
        }
        
        alertController.addTextField { subtitleFieldValue in
            subtitleFieldValue.placeholder = "Your subtitle here..."
        }
        
        
        
        let addActionButton = UIAlertAction(title: "Add", style: .default) { addActions in
            
            
            guard let titleTextField = alertController.textFields?.first?.text, !titleTextField.isEmpty else { return }
            let subtitleTextField = alertController.textFields?[1].text ?? ""
            
            let entity = NSEntityDescription.entity(forEntityName: "ToDo", in: self.managedObjectContext!)
            let list = NSManagedObject(entity: entity!, insertInto: self.managedObjectContext)
            
            list.setValue(titleTextField, forKey: "item")
            if !subtitleTextField.isEmpty {
                list.setValue(subtitleTextField, forKey: "item2")
            }
            self.saveCoreData()
            
        }
        
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(addActionButton)
        alertController.addAction(cancelActionButton)
        
        present(alertController, animated: true)
        
        
    }
    
    
    @IBAction func deleteAllButtonTapped(_ sender: Any) {
        deleteAllCoreData()
    }
    
}

   // MARK: - CoreData logic

extension ToDoTableViewController {
    func loadCoreData(){
        let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        
        do {
            let result = try managedObjectContext?.fetch(request)
            toDoLists = result ?? []
            self.tableView.reloadData()
        } catch {
            fatalError("Error in loading item into core data")
        }
    }
    
    func saveCoreData(){
        do {
            try managedObjectContext?.save()
            print("Data saved")
        } catch {
            fatalError("Error in saving item into core data")
        }
        loadCoreData()
    }
    
    
    func deleteAllCoreData() {
        let alertController = UIAlertController(title: "Delete All Records", message: "Do you really want to delete all the records?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ToDo")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try self.managedObjectContext?.execute(deleteRequest)
                try self.managedObjectContext?.save()
                self.loadCoreData()
            } catch {
                print("Error deleting all items: \(error)")
            }
        }
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - Table view data source
    
  //  extension ToDoTableViewController {
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return toDoLists.count
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
            
            let toDoList = toDoLists[indexPath.row]
            cell.textLabel?.text = toDoList.item
            cell.detailTextLabel?.text = toDoList.item2
            cell.accessoryType = toDoList.completed ? .checkmark : .none
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            toDoLists[indexPath.row].completed = !toDoLists[indexPath.row].completed
            saveCoreData()
        }
        
        /*
         // Override to support conditional editing of the table view.
         override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
         }
         */
        
        
        // Override to support editing the table view.
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Delete the row from the data source
                managedObjectContext?.delete(toDoLists[indexPath.row])
            }
            saveCoreData()
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
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
    }

