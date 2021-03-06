//
//  TabBarController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/31/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTabBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: Configure the tab bar
    func configureTabBar() {
        
        self.tabBar.tintColor = ColorConstants.kBlueColor
        
        //Configure the View controllers
        let dashboardViewController:UIViewController = UIStoryboard.dashboard.instantiateInitialViewController()!
        dashboardViewController.tabBarItem = UITabBarItem(title:TabNames.dashboard , image: #imageLiteral(resourceName: "dashboard"), tag: 1)
        
        let conversationsViewController:UIViewController = UIStoryboard.conversations.instantiateInitialViewController()!
        conversationsViewController.tabBarItem = UITabBarItem(title:TabNames.conversations , image: #imageLiteral(resourceName: "conversationIcon"), tag: 2)
        
        let settingsViewController:UIViewController = UIStoryboard.settings.instantiateInitialViewController()!
        settingsViewController.tabBarItem = UITabBarItem(title:TabNames.settings , image: #imageLiteral(resourceName: "infoIcon"), tag: 3)
        
        let notificationsViewController:UIViewController = UIStoryboard.notifications.instantiateInitialViewController()!
        notificationsViewController.tabBarItem = UITabBarItem(title:TabNames.notifications , image: #imageLiteral(resourceName: "notification"), tag: 4)
        
        self.setViewControllers([dashboardViewController,conversationsViewController,notificationsViewController,settingsViewController], animated: true)
    }

}
