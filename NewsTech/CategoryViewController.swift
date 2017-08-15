//
//  CategoryViewController.swift
//  NewsTech
//
//  Created by Karizma LTD on 26/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import SDWebImage

class CategoryViewController: UIViewController {

    
    @IBOutlet var categoryTableView: UITableView!
    var categories = [Category]()
    
    @IBAction func openMenu(_ sender: Any) {
        slideMenuController()?.toggleRight()
    }
    
    @IBAction func back(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategories { (categories, error) in
            if error == nil{
               self.categories = categories as! [Category]
                self.categoryTableView.reloadData()
                    
                }
            }
        }

}
extension CategoryViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        
        cell.categoryName.text = categories[indexPath.section].name
        cell.categoryPic.sd_setImage(with: URL(string: "\(categories[indexPath.section].picture)" ), placeholderImage: UIImage(named: "Placeholder"), options: SDWebImageOptions()) { (image, error, cacheType, url) in
            if image != nil {
                cell.categoryPic.image = image
            }
            }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColorFromRGB(rgbValue: 0xeeecf6)
        return header
    }
    
}
extension CategoryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/3
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // space b/w cells
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let listPost = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FamousPostViewController") as! FamousPostViewController
        listPost.category = self.categories[indexPath.section]
        (self.slideMenuController()?.mainViewController as! UINavigationController).pushViewController(listPost, animated: true)
        
    }
    
}
