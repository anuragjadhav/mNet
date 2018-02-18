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
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var rejectButton: UIButton!
    
    @IBOutlet weak var approveButton: CustomBlueTextColorButton!
    
    var dataController:ApprovalsDataController = ApprovalsDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let documentDetailsVC = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "DocumentDetailsViewController")
        
        self.addChildViewController(documentDetailsVC)
        
        documentDetailsVC.view.frame = CGRect(x:0, y:0, width:self.containerView.frame.size.width, height:self.containerView.frame.size.height);
        self.containerView.addSubview(documentDetailsVC.view)
        documentDetailsVC.didMove(toParentViewController: self)
        
        setData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar()
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = dataController.selectedApproval?.documentDetailsScreenName
    }
    
    func setData() {
        
        let approval:Approval? = dataController.selectedApproval
        
        self.navigationItem.title = approval?.documentDetailsScreenName
        
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: approval?.documentDetailsTab1Name ?? "Details", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Attachments", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        showDetailsScreen()
    }
    
    // MARK: - Button Action

    @IBAction func approveButtonAction(_ sender: Any) {
    }
    
    @IBAction func rejectButtonAction(_ sender: Any) {
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
 
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        
        if(sender.selectedSegmentIndex == 0){
            
            showDetailsScreen()
        }
            
        else if (sender.selectedSegmentIndex == 1)
        {
            showAttachmentsScreen()
        }
    }
    
    func showDetailsScreen() {
        
        let documentDetailsVC:DocumentDetailsViewController = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "DocumentDetailsViewController") as! DocumentDetailsViewController
        documentDetailsVC.dataController = self.dataController
        
        self.addChildViewController(documentDetailsVC)
        
        documentDetailsVC.view.frame = CGRect(x:0, y:0, width:self.containerView.frame.size.width, height:self.containerView.frame.size.height);
        self.containerView.addSubview(documentDetailsVC.view)
        documentDetailsVC.didMove(toParentViewController: self)
    }
    
    func showAttachmentsScreen() {
        
        let attachmentsVC:AttachmentsViewController = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "AttachmentsViewController") as! AttachmentsViewController
        attachmentsVC.documentVC = self
        attachmentsVC.documents = dataController.selectedApproval?.otherDocument ?? [String]()
        
        self.addChildViewController(attachmentsVC)
        
        attachmentsVC.view.frame = CGRect(x:0, y:0, width:self.containerView.frame.size.width, height:self.containerView.frame.size.height);
        self.containerView.addSubview(attachmentsVC.view)
        attachmentsVC.didMove(toParentViewController: self)
    }
}
