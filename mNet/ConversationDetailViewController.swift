//
//  ConversationDetailViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/11/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary
import Photos

class ConversationDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ImageDocDisplayDelegate {

    @IBOutlet weak var conversationTableView: UITableView!
    @IBOutlet weak var sendButton: CustomBlueTextColorButton!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var user1Label: CustomBrownTextColorLabel!
    @IBOutlet weak var user2Label: CustomBrownTextColorLabel!
    
    var dataCtrl:ConversationsDataController?
    let imagePicker = UIImagePickerController()
    var documentController:UIDocumentMenuViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conversationTableView.estimatedRowHeight = 66
        conversationTableView.rowHeight = UITableViewAutomaticDimension
        
        sendButton.isEnabled = false
        sendButton.titleLabel?.textColor = UIColor.gray
        
        // add long press gesture recognizer on table view
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(longPress(gesture:)))
        self.conversationTableView.addGestureRecognizer(longPressRecognizer)
        
        // add tap gesture on from to label
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action:#selector(fromTolabelClicked(gesture:)))
        self.user1Label.addGestureRecognizer(tapGestureRecognizer1)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action:#selector(fromTolabelClicked(gesture:)))
        self.user2Label.addGestureRecognizer(tapGestureRecognizer2)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.setupNavigationBar()
        
        self.navigationItem.title = dataCtrl?.selectedCoversation?.postTitle
        
        if((dataCtrl?.selectedCoversation?.membersList.count)! > 2)
        {
            let memberCount:Int = (dataCtrl?.selectedCoversation?.membersList.count)!
            
            let member1:ConversationMember =  (dataCtrl?.selectedCoversation?.membersList.first)!
            user1Label.text = member1.userName
            
            let member2:ConversationMember =  (dataCtrl?.selectedCoversation?.membersList.last)!
            user2Label.text = "\(member2.userName) and \(memberCount - 2)"
        }
        else
        {
            let member1:ConversationMember =  (dataCtrl?.selectedCoversation?.membersList.first)!
            user1Label.text = member1.userName
            
            let member2:ConversationMember =  (dataCtrl?.selectedCoversation?.membersList.last)!
            user2Label.text = member2.userName
        }
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let latestReplyDate:Date = dateFormatter.date(from:(dataCtrl?.selectedCoversation?.latestReplierDate)!)!
        
        let dateFormatterToShow : DateFormatter = DateFormatter()
        dateFormatterToShow.dateFormat = "h:mm a yy MMM dd"
        let dateTimeString:String = dateFormatterToShow.string(from: latestReplyDate) + " " + dateFormatterToShow.weekdaySymbols[Calendar.current.component(.weekday, from: latestReplyDate)]
        
        dateTimeLabel.text = dateTimeString
        
        conversationTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if((dataCtrl?.selectedCoversation?.reply.count)! > 0)
        {
            let indexPath = IndexPath(row: (dataCtrl?.selectedCoversation?.reply.count)! - 1, section: 0)
            self.conversationTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //Mark: Keyboard handling
    
    override func keyBoardWillShow(notification: NSNotification) {
        
        super.keyBoardWillShow(notification: notification)
        
         if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
         {
            messageViewBottomConstraint.constant = keyboardSize.height
            self.view.layoutIfNeeded()
            
            if((dataCtrl?.selectedCoversation?.reply.count)! > 0)
            {
                let indexPath = IndexPath(row: (dataCtrl?.selectedCoversation?.reply.count)! - 1, section: 0)
                self.conversationTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
         }
    }
    
    override func keyBoardWillHide(notification: NSNotification) {
        
        super.keyBoardWillHide(notification: notification)
        
        messageViewBottomConstraint.constant = 0
        self.view.layoutIfNeeded()

    }
    
    
    //Mark: tableview delegates and data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (dataCtrl?.selectedCoversation?.reply.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let conversationReply:ConversationReply = (dataCtrl?.selectedCoversation?.reply[indexPath.row])!
        
        let user:User = User.loggedInUser()!

        var link:String?
        
        if(indexPath.row == 0 && conversationReply.replyLink == "")
        {
            link = dataCtrl?.selectedCoversation?.postLink
        }
        else
        {
            link = conversationReply.replyLink
        }
        
        if(user.userId == conversationReply.userId)
        {
           let cell:SentMessageTableViewCell = tableView.dequeueReusableCell(withIdentifier:"SentMessageTableViewCell") as! SentMessageTableViewCell
            
             cell.loadCellWithConversationReply(reply: conversationReply, link: link)
             cell.isHidden = false
            
            return cell
        }
        else
        {
            let cell:ReceivedMessageTableViewCell = tableView.dequeueReusableCell(withIdentifier:"ReceivedMessageTableViewCell") as! ReceivedMessageTableViewCell
            
            cell.loadCellWithConversationReply(reply: conversationReply, link: link)
            
            return cell
        }        
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }

    
    //Mark: Textview Delegates
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        guard let text = textView.text else { return true }
        let newLength = text.count + text.count - range.length
        
        if(newLength > 0 && Reachability.isConnectedToNetwork())
        {
            sendButton.isEnabled = true
            sendButton.titleLabel?.textColor = ColorConstants.kBlueColor
        }
        else
        {
            sendButton.isEnabled = false
            sendButton.titleLabel?.textColor = UIColor.gray
        }
        
        return true
    }
    
    //MARK: Image Picker Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let currentTimeStamp:String = String(UInt64((Date.init().timeIntervalSince1970 + 62_135_596_800) * 10_000_000)) + "_doc.jpg"
        
        dataCtrl?.selectedFilenameForNewReply = currentTimeStamp
        dataCtrl?.selectedFileDataForNewReply =
        UIImageJPEGRepresentation(chosenImage,0.9)
                
        picker.dismiss(animated: true, completion: nil)
        
        let imageDocDisplayVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ImageDocDisplayViewController") as! ImageDocDisplayViewController
        imageDocDisplayVC.dataCtrl = dataCtrl
        imageDocDisplayVC.prefilledText = self.messageTextView.text
        imageDocDisplayVC.isDocument = false
        imageDocDisplayVC.image = chosenImage
        imageDocDisplayVC.delegate = self
        imageDocDisplayVC.modalPresentationStyle = .overFullScreen
        self.present(imageDocDisplayVC, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Document Picker Delegates
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        dataCtrl?.selectedFilenameForNewReply = (url.absoluteString as NSString).lastPathComponent
        
        do
        {
            try self.dataCtrl?.selectedFileDataForNewReply = Data(contentsOf: url)
        }
        catch
        {
            self.dataCtrl?.selectedFileDataForNewReply = nil
        }
        
        let imageDocDisplayVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ImageDocDisplayViewController") as! ImageDocDisplayViewController
        imageDocDisplayVC.dataCtrl = dataCtrl
        imageDocDisplayVC.prefilledText = self.messageTextView.text
        imageDocDisplayVC.isDocument = true
        imageDocDisplayVC.docUrl = url
        imageDocDisplayVC.delegate = self
        imageDocDisplayVC.modalPresentationStyle = .overFullScreen
        self.present(imageDocDisplayVC, animated: true, completion: nil)
        
    }
    
    public func documentMenu(_ documentMenu:     UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Open Camera and Gallery
    
    func openPhotoLibrary()
    {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: Open Document Menu
    
    func openDocuments()
    {
        documentController = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        documentController?.delegate = self
        documentController?.modalPresentationStyle = .formSheet
        present(documentController!, animated: true, completion: nil)
    }
    
     //MARK: UserName Label Clicked
    
    @objc func fromTolabelClicked(gesture:UITapGestureRecognizer)
    {
        let conversationInfoVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ConversationInfoViewController") as! ConversationInfoViewController
        conversationInfoVC.dataCtrl = dataCtrl
        self.navigationController?.pushViewController(conversationInfoVC, animated: true)
    }
    
    
    //MARK: Delete Reply only if reply added by logged in user
    
   @objc func longPress(gesture:UILongPressGestureRecognizer)
    {
        if (gesture.state == UIGestureRecognizerState.began) {
            
            let touchPoint = gesture.location(in:self.conversationTableView)
            
            guard let indexPath = conversationTableView.indexPathForRow(at: touchPoint) else
            {
                return
            }
            
            let conversationReply:ConversationReply = (dataCtrl?.selectedCoversation?.reply[indexPath.row])!
            
            let user:User = User.loggedInUser()!
            if(user.userId == conversationReply.userId)
            {
                let alert = UIAlertController(title:"Select Action", message: "Are you sure you want to delete this reply?", preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "Yes", style: .default , handler:{ (UIAlertAction)in
                    
                    self.deleteReply(reply: conversationReply, At: (indexPath.row))
                }))
                
                alert.addAction(UIAlertAction(title: "No", style: .default , handler:{ (UIAlertAction)in
                }))
                
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func deleteReply(reply:ConversationReply,At index:Int)
    {
        if Reachability.isConnectedToNetwork(){
            
            self.showTransperantLoadingOnViewController()
            
            dataCtrl?.deleteConversationReply(reply:reply,Atindex:index,onSuccess: { [unowned self] in
                
                DispatchQueue.main.async {
                    
                    self.removeTransperantLoadingFromViewController()
                    self.conversationTableView.reloadData()
                }
                }, onFailure: { [unowned self] (errorMessage) in
                    
                    DispatchQueue.main.async {
                        
                        self.removeTransperantLoadingFromViewController()
                        
                        let alert = UIAlertController(title:AlertMessages.failure, message:errorMessage, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
            })
            
        }else{
            
            let alert = UIAlertController(title:AlertMessages.failure, message:AlertMessages.networkUnavailable, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    
    // MARK: - Button Actions

    @IBAction func infoButtonAction(_ sender: Any) {
        
        let conversationInfoVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ConversationInfoViewController") as! ConversationInfoViewController
        conversationInfoVC.dataCtrl = dataCtrl
        self.navigationController?.pushViewController(conversationInfoVC, animated: true)
    }
 
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
  
    @IBAction func sendButtonAction(_ sender: Any) {
        
        self.showTransperantLoadingOnViewController()
        
        dataCtrl?.setNewReplyWithoutDocumentConversation(replyMessage: messageTextView.text, onSuccess: { [unowned self] in
            
            DispatchQueue.main.async {
                
                self.messageTextView.text = ""
                self.messageTextView.resignFirstResponder()
                self.removeTransperantLoadingFromViewController()
                self.conversationTableView.reloadData()
                
                let indexPath = IndexPath(row: (self.dataCtrl?.selectedCoversation?.reply.count)! - 1, section: 0)
                self.conversationTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
            
        }, onFailure: { [unowned self] (errorMessage) in
            
            DispatchQueue.main.async {
                
                self.removeTransperantLoadingFromViewController()
                
                let alert = UIAlertController(title:AlertMessages.failure, message:errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                }))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }

    @IBAction func uploadButtonAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title:"Select Media", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Take An Image", style: .default , handler:{ (UIAlertAction)in
            self.dataCtrl?.isDocumentSelectedForNewReply = false
            self.messageTextView.resignFirstResponder()
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Open Photo Gallery", style: .default , handler:{ (UIAlertAction)in
            self.dataCtrl?.isDocumentSelectedForNewReply = false
            self.messageTextView.resignFirstResponder()
            self.openPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "Document", style: .default , handler:{ (UIAlertAction)in
            self.dataCtrl?.isDocumentSelectedForNewReply = true
            self.messageTextView.resignFirstResponder()
            self.openDocuments()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler:{ (UIAlertAction)in
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Image Doc Display Delegate
    
    func didEnterReplyMessageOnDocument()
    {
        if Reachability.isConnectedToNetwork(){
            
            self.showTransperantLoadingOnViewController()
            
            dataCtrl?.setNewReplyWithDocumentConversation(onSuccess: { [unowned self] in
                
                DispatchQueue.main.async {
                    
                    self.removeTransperantLoadingFromViewController()
                    self.messageTextView.text = ""
                    self.messageTextView.resignFirstResponder()
                    self.conversationTableView.reloadData()
                    
                    let indexPath = IndexPath(row: (self.dataCtrl?.selectedCoversation?.reply.count)! - 1, section: 0)
                    self.conversationTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
                
                }, onFailure: { [unowned self] (errorMessage) in
                    
                    DispatchQueue.main.async {
                        
                        self.removeTransperantLoadingFromViewController()
                        
                        let alert = UIAlertController(title:AlertMessages.failure, message:errorMessage, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
            })
            
        }else{
            
            let alert = UIAlertController(title:AlertMessages.failure, message:AlertMessages.networkUnavailable, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
