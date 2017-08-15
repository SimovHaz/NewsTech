//
//  FamousTagsTableViewController.swift
//  NewsTech
//
//  Created by Karizma LTD on 31/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit

class FamousTagsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var tagsTable = [Tag]()

        
    @IBAction func openMenu(_ sender: Any) {
        slideMenuController()?.toggleRight()

    }
    
    @IBAction func back(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFamousTags { (tags, error) in
            if error == nil {
                self.tagsTable = tags as! [Tag]
                self.tableView.reloadData()
            }
        }

    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tagsTable.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "famousTag", for: indexPath) as? FamousTagsTableViewCell

        cell?.hashtagNameLabel.text = tagsTable[indexPath.row].name
        cell?.hashtagNbrLabel.text = String(tagsTable[indexPath.row].nbrPosts)

        return cell!
    }
 

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let listPost = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FamousPostViewController") as! FamousPostViewController
        listPost.tag = self.tagsTable[indexPath.row]
        (self.slideMenuController()?.mainViewController as! UINavigationController).pushViewController(listPost, animated: true)
    }

}
