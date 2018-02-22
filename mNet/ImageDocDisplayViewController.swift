//
//  ImageDocDisplayViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 2/22/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

protocol ImageDocDisplayDelegate:class {
    
    func didEnterReplyMessageOnDocument()
}

class ImageDocDisplayViewController: BaseViewController {

    @IBOutlet weak var displayImageView: UIImageView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendButton: CustomBlueTextColorButton!
    @IBOutlet weak var inputViewBottomConstraint: NSLayoutConstraint!
    
    var dataCtrl:ConversationsDataController?
    var isDocument:Bool? = false
    var docUrl:URL?
    var image:UIImage?
    weak var delegate:ImageDocDisplayDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addkeyBoardListners()
        
        if(isDocument == true)
        {
            displayImageView.isHidden = true
            webView.loadRequest(URLRequest.init(url: docUrl!))
        }
        else
        {
            webView.isHidden = true
            displayImageView.image = image
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        messageTextView.becomeFirstResponder()
    }
    
    //Mark: Keyboard handling
    
    override func keyBoardWillShow(notification: NSNotification) {
        
        super.keyBoardWillShow(notification: notification)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        {
            inputViewBottomConstraint.constant = keyboardSize.height
            self.view.layoutIfNeeded()
        }
    }
    
    override func keyBoardWillHide(notification: NSNotification) {
        
        super.keyBoardWillHide(notification: notification)
        
        inputViewBottomConstraint.constant = 0
        self.view.layoutIfNeeded()
        
    }
    
    // MARK: - Button Actions
    @IBAction func closeButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        
        if(messageTextView.text.count > 0)
        {
            dataCtrl?.messageForNewReply = messageTextView.text
            self.dismiss(animated: true, completion: {
                
                self.delegate?.didEnterReplyMessageOnDocument()
            })
        }
        else
        {
            let alert = UIAlertController(title:AlertMessages.sorry, message:"Please enter message", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
