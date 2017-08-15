//
//  SplashViewController.swift
//  NewsTech
//
//  Created by Karizma LTD on 19/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SlideMenuControllerSwift
import XLPagerTabStrip
import Parse


class SplashViewController: UIViewController , NVActivityIndicatorViewable  {

   

    @IBOutlet var loadingView: NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadingView.type = .ballSpinFadeLoader
        loadingView.color = UIColor.white
        loadingView.startAnimating()
    }
    override func viewDidAppear(_ animated: Bool) {
        Thread.sleep(forTimeInterval: 2.0)
        
        if UserDefaults.standard.bool(forKey: "firstLaunch") {
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
            
        } else {
            let infoView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
            self.present(infoView, animated: true, completion: nil)
        }
      
       

    }
 

}
