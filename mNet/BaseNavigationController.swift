//
//  BaseNavigationController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 13/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpNavigationBarForLargeTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpNavigationBarForLargeTitle() {
        
        let titleAttributes:[NSAttributedStringKey:Any] = [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue):UIFont.boldAppFont(fontSize: 20),NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue):ColorConstants.kBrownColor]
        
        if #available(iOS 11.0, *) {
            self.navigationBar.largeTitleTextAttributes = titleAttributes
        } else {
            navigationBar.titleTextAttributes = titleAttributes
        }
    }
    
    func showLargeTitles() {

        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = true
        }
    }
    
    func hideLargeTitles() {
        
        if #available(iOS 11.0, *) {
                self.navigationBar.prefersLargeTitles = false
        }
    }
}
