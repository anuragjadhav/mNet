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
import SafariServices

protocol HideIgnorePostDelegate : class {
    
    func hideIgnorePostSuccess()
}


class ConversationDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ImageDocDisplayDelegate, UIPopoverPresentationControllerDelegate,PopOverDelegate {

    @IBOutlet weak var conversationTableView: UITableView!
    @IBOutlet weak var sendButton: CustomBlueTextColorButton!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var user1Label: CustomBrownTextColorLabel!
    @IBOutlet weak var user2Label: CustomBrownTextColorLabel!
    
    weak var hideIgnorePostdelegate:HideIgnorePostDelegate?
    var dataCtrl:ConversationsDataController?
    let imagePicker = UIImagePickerController()
    var documentController:UIDocumentMenuViewController?
    var didComeFromNotification:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendButton.isEnabled = false
        sendButton.titleLabel?.textColor = UIColor.gray
        
        // add long press gesture recognizer on table view
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(longPress(gesture:)))
        self.conversationTableView.addGestureRecognizer(longPressRecognizer)
        
        // add tap gesture on from to label
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action:#selector(fromTolabelClicked(gesture:)))
        self.user2Label.addGestureRecognizer(tapGestureRecognizer1)

        if(didComeFromNotification == true)
        {
            getConversation()
        }
        else
        {
            setupData()
            dataCtrl?.checkWhetherSelectedConversationIsVerifyOrApprove()

        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        setupNavigationBar()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(didComeFromNotification == false)
        {
            scrollTableViewToBottom()
        }
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    func setupData()
    {
        self.navigationItem.title = dataCtrl?.selectedCoversation?.postTitle
        
        let filteredMemberArray = dataCtrl?.selectedCoversation?.membersList.filter{$0.memberType == "Owner"}
        
        let member1:ConversationMember? =  (filteredMemberArray?.first) ?? nil
        user1Label.text = member1?.userName
        
        if((dataCtrl?.selectedCoversation?.membersList.count)! > 2)
        {
            let memberCount:Int = (dataCtrl?.selectedCoversation?.membersList.count)!
        
            let member2:ConversationMember =  (dataCtrl?.selectedCoversation?.membersList.last)!
            user2Label.text = "\(member2.userName) + \(memberCount - 2)"
        }
        else
        {
            let filteredArray = dataCtrl?.selectedCoversation?.membersList.filter{$0.memberType != "Owner"}
            
            let member2:ConversationMember? =  (filteredArray?.first) ?? nil
            user2Label.text = member2?.userName
        }
        
        dateTimeLabel.text = dataCtrl?.selectedCoversation?.createdOn.getDisplayFromtDateFromDateString()
        
        conversationTableView.reloadData()
    }
    
    func scrollTableViewToBottom()
    {
        if((dataCtrl?.selectedCoversation?.reply.count)! > 0)
        {
            let indexPath = IndexPath(row: (dataCtrl?.selectedCoversation?.reply.count)! - 1, section: 0)
            self.conversationTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    //Mark: Keyboard handling
    
    override func keyBoardWillShow(notification: NSNotification) {
        
        super.keyBoardWillShow(notification: notification)
        
         if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
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
        
        return (dataCtrl?.selectedCoversation?.reply.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let conversationReply:ConversationReply = (dataCtrl?.selectedCoversation?.reply[indexPath.row])!
        
        let user:User = User.loggedInUser()!

        var link:String?
        
        if(indexPath.row == 0 && conversationReply.replyLink == "")
        {
            if dataCtrl?.selectedCoversation?.postLink.range(of:"&nbsp") != nil {
                
                link = ""
            }
            else
            {
                link = dataCtrl?.selectedCoversation?.postLink
            }
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
        UIImageJPEGRepresentation(chosenImage,0.7)
                
        picker.dismiss(animated: true, completion: nil)
        
        let imageDocDisplayVC = UIStoryboard.conversations.instantiateViewController(withIdentifier: StoryboardIDs.imageDocViewController) as! ImageDocDisplayViewController
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
        
        let imageDocDisplayVC = UIStoryboard.conversations.instantiateViewController(withIdentifier: StoryboardIDs.imageDocViewController) as! ImageDocDisplayViewController
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
        showInfoPopover()
    }
    
    func showInfoPopover() {
        
        let popController:InfoPopoverViewController = UIStoryboard.conversations.instantiateViewController(withIdentifier: StoryboardIDs.infoPopoverViewController) as! InfoPopoverViewController
        
        // set the presentation style
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        // set up the popover presentation controller
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = self.user2Label // button
        
        let filteredMemberArray = dataCtrl?.selectedCoversation?.membersList.filter{$0.memberType != "Owner"} ?? []
        
        popController.dataArray = (dataCtrl?.getPopoverObjectsFromStringArray(stringArray: filteredMemberArray.map{$0.userName}))!
        
        // present the popover
        self.present(popController, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
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
    
    
    //MARK: Hide Ignore Post
    
    func hidePost()
    {
        if Reachability.isConnectedToNetwork(){
            
            self.showTransperantLoadingOnWindow()
            
            dataCtrl?.hideConversation(onSuccess: { [unowned self] in
                
                DispatchQueue.main.async {
                    
                    self.removeTransperantLoadingFromWindow()
                    self.hideIgnorePostdelegate?.hideIgnorePostSuccess()
                    self.navigationController?.popViewController(animated: true)
                }
                }, onFailure: { [unowned self] (errorMessage) in
                    
                    DispatchQueue.main.async {
                        
                        self.removeTransperantLoadingFromWindow()

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
    
    func ignorePost()
    {
        if Reachability.isConnectedToNetwork(){
            
            self.showTransperantLoadingOnWindow()
            
            dataCtrl?.ignoreConversation(onSuccess: { [unowned self] in
                
                DispatchQueue.main.async {
                    
                    self.removeTransperantLoadingFromWindow()
                    self.hideIgnorePostdelegate?.hideIgnorePostSuccess()
                    self.navigationController?.popViewController(animated: true)

                }
                }, onFailure: { [unowned self] (errorMessage) in
                    
                    DispatchQueue.main.async {
                        
                        self.removeTransperantLoadingFromWindow()
                        
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
    
    @IBAction func menuButtonAction(_ sender:Any)
    {
        let popController:InfoPopoverViewController = UIStoryboard.conversations.instantiateViewController(withIdentifier: StoryboardIDs.infoPopoverViewController) as! InfoPopoverViewController
        
        // set the presentation style
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        // set up the popover presentation controller
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popController.popoverPresentationController?.delegate = self
       popController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        popController.delegate = self
        
        popController.dataArray = (dataCtrl?.getPopoverObjectsForMenu())!
        
        // present the popover
        self.present(popController, animated: true, completion: nil)
    }

    func hidePostButtonAction() {
        
        let alert = UIAlertController(title:"Select Action", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Hide Post", style: .default , handler:{ (UIAlertAction)in
            self.hidePost()
        }))
        
        alert.addAction(UIAlertAction(title: "Ignore Post", style: .default , handler:{ (UIAlertAction)in
           self.ignorePost()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler:{ (UIAlertAction)in
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func infoButtonAction() {
        
        let conversationInfoVC = UIStoryboard.conversations.instantiateViewController(withIdentifier: StoryboardIDs.conversationInfoViewController) as! ConversationInfoViewController
        conversationInfoVC.dataCtrl = dataCtrl
        self.navigationController?.pushViewController(conversationInfoVC, animated: true)
    }
 
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func linkButtonAction(_ sender: UIButton) {
        
        let buttonPoint:CGPoint = sender.convert(CGPoint.zero, to: self.conversationTableView)
        let indexPath:IndexPath = self.conversationTableView.indexPathForRow(at: buttonPoint)!
        
        let conversationReply:ConversationReply = (dataCtrl?.selectedCoversation?.reply[indexPath.row])!
        
        guard let linkURL = URL(string: conversationReply.replyLink ?? "") else {
            return
        }
        
        if(linkURL.pathExtension == "jpeg" || linkURL.pathExtension == "jpg" || linkURL.pathExtension == "png")
        {
            let imageDisplayController:ImageDisplayViewController = UIStoryboard.conversations.instantiateViewController(withIdentifier: StoryboardIDs.imageDisaplyViewController) as! ImageDisplayViewController
            imageDisplayController.imageUrl = linkURL
            navigationController?.pushViewController(imageDisplayController, animated: true)
        }
        else
        {
            let webViewController:WebViewController = UIStoryboard.webView.instantiateViewController(withIdentifier: StoryboardIDs.webViewController) as! WebViewController
            webViewController.setData(url: linkURL, header: linkURL.pathComponents.last)
            navigationController?.pushViewController(webViewController, animated: true)
            
        }
    }
    
    func addUsersToExistingConversation() {
        
        if(dataCtrl?.selectedCoversation?.postCreator == User.loggedInUser()?.userId)
        {
            let newConversationVC = UIStoryboard.conversations.instantiateViewController(withIdentifier: StoryboardIDs.newConversationViewController) as! NewConversationViewController
            newConversationVC.dataCtrl = dataCtrl
            newConversationVC.didComeToAddExtraUsers = true
            self.navigationController?.pushViewController(newConversationVC, animated: true)
        }
        else
        {
            let alert = UIAlertController(title:AlertMessages.sorry, message:"You must be owner of the post to add new users to this conversation", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
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
    
    //MARK: Get Post Data
    
    func getConversation()
    {
        if Reachability.isConnectedToNetwork(){
            
            self.showLoadingOnWindow()

            dataCtrl?.getConversation(onSuccess: { [unowned self]  in
                
                DispatchQueue.main.async {
                    
                    self.setupData()
                    self.scrollTableViewToBottom()
                    self.removeLoadingFromWindow()
                    
                }
                
                }, onFailure: { [unowned self] (errorMessage) in
                    
                    DispatchQueue.main.async {
                        
                        self.removeLoadingFromWindow()
                        self.showRetryView(message:errorMessage)
                    }
            })
            
        }else{
            
            self.showRetryView(message: AlertMessages.networkUnavailable)
        }
    }
    
    //MARK: retry view delegate
    
    override func retryButtonClicked() {
        
        getConversation()
    }
    
    //MARK: PopOver Delegate
    
    func didSelectItem(popOverObject: PopoverObject, at index: Int) {
        
        DispatchQueue.main.async {
        
        switch popOverObject.title {
            
        case MenuOptions.reject:
            
            let rejectVC = UIStoryboard.conversations.instantiateViewController(withIdentifier: StoryboardIDs.conversationRejectViewController) as! ConversationRejectViewController
            rejectVC.dataCtrl = self.dataCtrl
            self.navigationController?.pushViewController(rejectVC, animated: true)
            
            break
            
        case MenuOptions.approve:
            
            let approveVC = UIStoryboard.conversations.instantiateViewController(withIdentifier: StoryboardIDs.conversationApproveViewController) as! ConversationApproveViewController
            approveVC.dataCtrl = self.dataCtrl
            self.navigationController?.pushViewController(approveVC, animated: true)
            
            break
            
        case MenuOptions.verify:
            
            let verifyVC = UIStoryboard.conversations.instantiateViewController(withIdentifier: StoryboardIDs.conversationVerifyViewController) as! ConversationVerifyViewController
            verifyVC.dataCtrl = self.dataCtrl
            self.navigationController?.pushViewController(verifyVC, animated: true)
            
            break
            
            
        case MenuOptions.viewDetails:
            
            self.infoButtonAction()
            
            break
            
        case MenuOptions.addUsers:
            
            self.addUsersToExistingConversation()
            
            break
            
        case MenuOptions.hideIgnorPost:
            
            self.hidePostButtonAction()
            
            break
            
        case MenuOptions.goToapprovalDetails:
            
            let approvalDataController:ApprovalsDataController = ApprovalsDataController()
            if(self.didComeFromNotification)
            {
                approvalDataController.selectedNotification = self.dataCtrl?.selectedNotification
            }
            else
            {
                let notificationObject = NotificationObject(JSON: [String:String]())
                notificationObject?.postId = self.dataCtrl?.selectedCoversation?.postId
                approvalDataController.selectedNotification = notificationObject
            }
            approvalDataController.isFromDeepLinking = true
            let approvalDetailsViewController:DocumentViewController = UIStoryboard.approvals.instantiateViewController(withIdentifier: StoryboardIDs.approvalDetailsViewController) as! DocumentViewController
            approvalDetailsViewController.dataController = approvalDataController
            self.navigationController?.pushViewController(approvalDetailsViewController, animated: true)
            
            break
            
        default:
            break
        }
        
    }

    }

}
