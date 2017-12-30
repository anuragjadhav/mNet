//
//  NewConversationViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 30/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class NewConversationViewController: BaseViewController {

    //MARK: Outlets and Properties
    
    @IBOutlet weak var toLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var toPlusLabel: CustomBlueTextColorLabel!
    @IBOutlet weak var toPlusButton: UIButton!
    
    @IBOutlet weak var bccLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var bccPlusLabel: UILabel!
    @IBOutlet weak var bccPlusButton: UIButton!
    
    @IBOutlet weak var approvalLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var approvalPlusLabel: CustomBlueTextColorLabel!
    @IBOutlet weak var approvalButton: UIButton!
    
    @IBOutlet weak var verificationLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var verificationPlusLabel: CustomBlueTextColorLabel!
    @IBOutlet weak var verificationButton: UIButton!
    
    @IBOutlet weak var subjectLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var subjectTextField: CustomBrownTextColorTextfield!
    
    @IBOutlet weak var attachmentLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var attachmentTextField: CustomBrownTextColorTextfield!
    
    @IBOutlet weak var messageLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var messageTextField: CustomBrownTextColorTextfield!
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    @IBOutlet weak var startConversationLabel: CustomBlueTextColorLabel!
    @IBOutlet weak var startConversationButton: UIButton!
    
    @IBOutlet weak var tickButton: UIBarButtonItem!
    
    @IBOutlet weak var crossButton: UIBarButtonItem!
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Setup
    func setUpViewController() {
        
        
    }
    

    //MARK: Button Actions
    
    @IBAction func toButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func bccButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func approvalButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func verificationButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func tickButtonAction(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func crossButtonAction(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func startConversationButtonAction(_ sender: UIButton) {
    }
}
