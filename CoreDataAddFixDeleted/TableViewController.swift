//
//  TableViewController.swift
//  CoreDataAddFixDeleted
//
//  Created by Vu on 5/9/19.
//  Copyright © 2019 Vu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var imageData: [Entity] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 135

     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchObject()
    }
    func fetchObject() {
        if let data = (try? AppDelegate.context.fetch(Entity.fetchRequest()) as [Entity]) {
            imageData = data

            tableView.reloadData()
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageData.count
    }
    
    // MARK: Navigation

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.imageCell.image = imageData[indexPath.row].imageCoreData as? UIImage
        cell.nameCell.text = imageData[indexPath.row].nameCoreData
        cell.ageCell.text = String(imageData[indexPath.row].ageCoreData)

        // Configure the cell...

        return cell
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let bucket = segue.destination as? ViewController
            bucket?.data = imageData[indexPath.row]
                        bucket?.index = indexPath.row
        }
    }

 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
//            imageData.remove(at: indexPath.row)
            AppDelegate.context.delete(imageData[indexPath.row])
            AppDelegate.saveContext()
            imageData.remove(at: indexPath.row)
           
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
    }
    

    }
    
    @IBAction func onClickRemoveAll(_ sender: UIBarButtonItem) {
    }
    
}
