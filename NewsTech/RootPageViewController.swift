//
//  RootPageViewController.swift
//  NewsTech
//
//  Created by Karizma LTD on 19/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SlideMenuControllerSwift
class RootPageViewController: ButtonBarPagerTabStripViewController {
    
    
    var childControllers = [UIViewController]()
    var categoriesGetted = false
    override func viewDidLoad() {
        
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = UIColorFromRGB(rgbValue: 0x0D5BE9)
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        settings.style.buttonBarItemFont = UIFont(name: "JannaLT-Regular", size: 20)!
        settings.style.buttonBarItemLeftRightMargin = 8
        settings.style.selectedBarBackgroundColor = .clear
        containerView.backgroundColor = UIColorFromRGB(rgbValue: 0xeeecf6)
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColorFromRGB(rgbValue: 0x0D5BE9)
            newCell?.label.textColor = UIColorFromRGB(rgbValue: 0xff0038)
        }
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.white

        
    }
    
    @IBAction func openMenu(_ sender: Any) {
        slideMenuController()?.toggleRight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moveToViewController(at: childControllers.count - 1)

    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    
            let stb = UIStoryboard(name: "Main", bundle: nil)
            //var child : UIViewController
            let child_1 = stb.instantiateViewController(withIdentifier: "TestMainTableViewController") as! TestMainTableViewController
            child_1.itemInfo = IndicatorInfo(title: "الرئيسية")
            childControllers.insert(child_1, at: 0)
        
        let child_2 = stb.instantiateViewController(withIdentifier: "TestMainTableViewController") as! TestMainTableViewController
        child_2.itemInfo = IndicatorInfo(title: "فيديوهات")
        childControllers.insert(child_2, at: 0)
        
        let child_3 = stb.instantiateViewController(withIdentifier: "TestMainTableViewController") as! TestMainTableViewController
        child_3.itemInfo = IndicatorInfo(title: "تقارير")
        childControllers.insert(child_3, at: 0)


        
        return childControllers
    }
    
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
    }
    
    
}
