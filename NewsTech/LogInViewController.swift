//
//  LogInViewController.swift
//  NewsTech
//
//  Created by Karizma LTD on 02/08/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit
import Parse
import SlideMenuControllerSwift

class LogInViewController: UIViewController {
    var user = PFUser()
    @IBOutlet var passwordLabel: UITextField!
    @IBOutlet var usernameLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "firstLaunch")

    }

    @IBAction func skipAsVisitor(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainPostViewNavigation") as! UINavigationController
        let menu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        
        let slideMenuController = SlideMenuController(mainViewController: main , rightMenuViewController: menu)
        
        SlideMenuOptions.leftViewWidth = UIScreen.main.bounds.width - 70
        SlideMenuOptions.contentViewScale = 1
        
        self.present(slideMenuController, animated: true, completion: nil)
    }
    
    @IBAction func logInAction(_ sender: Any) {
        
        
        user.username = usernameLabel.text
        user.password = passwordLabel.text
        
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150)) as UIActivityIndicatorView
        spinner.startAnimating()
        
        // Send a request to login
        PFUser.logInWithUsername(inBackground: usernameLabel.text!, password: passwordLabel.text!, block: { (user, error) -> Void in
            
            // Stop the spinner
            spinner.stopAnimating()
            
            if ((user) != nil) {
                DispatchQueue.main.async(execute: { () -> Void in
                    let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainPostViewNavigation") as! UINavigationController
                    let menu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                    
                    let slideMenuController = SlideMenuController(mainViewController: main , rightMenuViewController: menu)
                    
                    SlideMenuOptions.leftViewWidth = UIScreen.main.bounds.width - 70
                    SlideMenuOptions.contentViewScale = 1
                    
                    self.present(slideMenuController, animated: true, completion: nil)
                })
                
            } else {
                let alert = UIAlertView(title: "Error", message: "\(error.debugDescription)", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
        })
    }

}
