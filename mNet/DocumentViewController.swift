//
//  DocumentViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/31/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let documentDetailsVC = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "DocumentDetailsViewController")
        
        self.addChildViewController(documentDetailsVC)
        
        documentDetailsVC.view.frame = CGRect(x:0, y:0, width:self.containerView.frame.size.width, height:self.containerView.frame.size.height);
        self.containerView.addSubview(documentDetailsVC.view)
        documentDetailsVC.didMove(toParentViewController: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar()
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    


    // MARK: - Button Action

    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
 
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        
        if(sender.selectedSegmentIndex == 0){
            
            let documentDetailsVC = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "DocumentDetailsViewController")
            
            self.addChildViewController(documentDetailsVC)
            
            documentDetailsVC.view.frame = CGRect(x:0, y:0, width:self.containerView.frame.size.width, height:self.containerView.frame.size.height);
            self.containerView.addSubview(documentDetailsVC.view)
            documentDetailsVC.didMove(toParentViewController: self)
        }
        else if (sender.selectedSegmentIndex == 1)
        {
            let attachmentsVC = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "AttachmentsViewController")
            
            self.addChildViewController(attachmentsVC)
            
            attachmentsVC.view.frame = CGRect(x:0, y:0, width:self.containerView.frame.size.width, height:self.containerView.frame.size.height);
            self.containerView.addSubview(attachmentsVC.view)
            attachmentsVC.didMove(toParentViewController: self)
        }
    }
}
