//
//  InfoViewController.swift
//  NewsTech
//
//  Created by Karizma LTD on 14/08/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit
import Parse
import SlideMenuControllerSwift
class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func skip(_ sender: Any) {
        if PFUser.current() != nil {
            
            let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainPostViewNavigation") as! UINavigationController
            let menu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            
            let slideMenuController = SlideMenuController(mainViewController: main , rightMenuViewController: menu)
            
            SlideMenuOptions.leftViewWidth = UIScreen.main.bounds.width - 70
            SlideMenuOptions.contentViewScale = 1
            
            self.present(slideMenuController, animated: true, completion: nil)
            
        }
        else {
            let logInView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
            self.present(logInView, animated: true, completion: nil)
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
