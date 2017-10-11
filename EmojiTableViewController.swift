//
//  EmojiTableViewController.swift
//  Emoji-AppDevWSwift
//
//  Created by Admin on 25.09.17.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var emojis: [Emoji] = [
        Emoji(symbol:"🍋", name: "Lemon", description: "It is a fruit", usage: "Add to tea"),
        Emoji(symbol:"🥑", name: "Avocado", description: "It is a vegetable", usage: "Add to salads"),
        Emoji(symbol:"🥕", name: "Carrot", description: "It is a vegetable", usage: "Add to soup"),
        Emoji(symbol:"🍌", name: "Banana", description: "It is a fruit", usage: "Eat on breakfast"),
        Emoji(symbol:"🧀", name: "Cheese", description: "It is a food", usage: "Add to spagetty")
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        
        // row height should be determined automatically (also compression resistance should be changed in storyboard to 751 and 572 for name and descr)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
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
        return emojis.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell

        let emoji = emojis[indexPath.row]
                
        //cell.textLabel?.text = "\(emoji.symbol) - \(emoji.name)"
        //cell.detailTextLabel?.text = emoji.description

        cell.update(with: emoji)
        cell.showsReorderControl = true // reorder cells

        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let emoji = emojis[indexPath.row]
        print("\(emoji.symbol) \(indexPath)")
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(movedEmoji, at: to.row)
        tableView.reloadData()
        
    }
    
// in storyboard change the Refresh to "Enabled", refr controll will appear. then connect it to this method
    @IBAction func refreshControlActivated(_ sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing() // this line ends the animation
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditEmomji" {
            let indexPath = tableView.indexPathForSelectedRow!
            let emoji = emojis[indexPath.row]
            let addEditEmojiTableViewController = segue.destination as! AddEditEmojiTableViewController
            addEditEmojiTableViewController.emoji = emoji
        }
    }
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! AddEditEmojiTableViewController
        
        if let emoji = sourceViewController.emoji {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                emojis[selectedIndexPath.row] = emoji
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: emojis.count, section: 0)
                emojis.append(emoji)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    

}
