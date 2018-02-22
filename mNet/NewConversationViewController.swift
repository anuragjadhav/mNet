//
//  NewConversationViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 30/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary
import Photos

class NewConversationViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var subjectTextField: CustomBrownTextColorTextfield!
    @IBOutlet weak var messageTextView: CustomBrownColorTextView!
    @IBOutlet weak var attachmentNameLabel: CustomBlueTextColorLabel!
    @IBOutlet weak var selectedToUsersCollectionView: UICollectionView!
    @IBOutlet weak var selectedForVerificationUsersCollectionView: UICollectionView!
    @IBOutlet weak var selectedForApprovalUsersCollectionView: UICollectionView!
    @IBOutlet weak var selectedBccUsersCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var dataCtrl:ConversationsDataController?
    let imagePicker = UIImagePickerController()
    var documentController:UIDocumentMenuViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addkeyBoardListners()
        dataCtrl?.refreshPreviouslySelectedData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpNavigationController()
        
        selectedToUsersCollectionView.reloadData()
        selectedBccUsersCollectionView.reloadData()
        selectedForVerificationUsersCollectionView.reloadData()
        selectedForApprovalUsersCollectionView.reloadData()
        
        selectedToUsersCollectionView.flashScrollIndicators()
        selectedBccUsersCollectionView.flashScrollIndicators()
        selectedForVerificationUsersCollectionView.flashScrollIndicators()
        selectedForApprovalUsersCollectionView.flashScrollIndicators()
        
    }
    
    //Mark: Keyboard handling
    
    override func keyBoardWillShow(notification: NSNotification) {
        
        super.keyBoardWillShow(notification: notification)
        scrollView.scrollRectToVisible(messageTextView.frame, animated: true)
     
    }
    
    override func keyBoardWillHide(notification: NSNotification) {
        
        super.keyBoardWillHide(notification: notification)
        
    }
    
    //MARK: Setup
    func setUpNavigationController() {
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: Collection view delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView === selectedToUsersCollectionView)
        {
            return (dataCtrl?.toUserList!.count)!
        }
        else if(collectionView === selectedBccUsersCollectionView)
        {
           return (dataCtrl?.bccUserList!.count)!
        }
        else if(collectionView === selectedForApprovalUsersCollectionView)
        {
             return (dataCtrl?.forApprovalUserList!.count)!
        }
        else if(collectionView === selectedForVerificationUsersCollectionView)
        {
             return (dataCtrl?.forVerificationUserList!.count)!
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: SelectedUsersCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"SelectedUsersCollectionViewCell", for: indexPath) as! SelectedUsersCollectionViewCell
        
        if(collectionView === selectedToUsersCollectionView)
        {
            let user:People = (dataCtrl?.toUserList![indexPath.row])!
            cell.loadCellWithUser(user: user, showDeleteButton:false)
            
        }
        else if(collectionView === selectedBccUsersCollectionView)
        {
            let user:People = (dataCtrl?.bccUserList![indexPath.row])!
            cell.loadCellWithUser(user: user, showDeleteButton:false)
        }
        else if(collectionView === selectedForApprovalUsersCollectionView)
        {
            let user:People = (dataCtrl?.forApprovalUserList![indexPath.row])!
            cell.loadCellWithUser(user: user, showDeleteButton:false)
        }
        else if(collectionView === selectedForVerificationUsersCollectionView)
        {
            let user:People = (dataCtrl?.forVerificationUserList![indexPath.row])!
            cell.loadCellWithUser(user: user, showDeleteButton:false)
        }
        
        return cell
        
    }
    
    
    //MARK: Image Picker Delegates
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let currentTimeStamp:String = String(UInt64((Date.init().timeIntervalSince1970 + 62_135_596_800) * 10_000_000)) + "_doc.jpg"
        
        dataCtrl?.selectedFilenameInNewConversation = currentTimeStamp
        dataCtrl?.selectedFileDataInNewConversation = UIImageJPEGRepresentation(chosenImage, 0.9)
        
        attachmentNameLabel.text = dataCtrl?.selectedFilenameInNewConversation
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Document Picker Delegates
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        dataCtrl?.selectedFilenameInNewConversation = (url.absoluteString as NSString).lastPathComponent
        
        attachmentNameLabel.text = dataCtrl?.selectedFilenameInNewConversation
        
        do
        {
            try self.dataCtrl?.selectedFileDataInNewConversation = Data(contentsOf: url)
        }
        catch
        {
            self.dataCtrl?.selectedFileDataInNewConversation = nil
        }
        
        //optional, case PDF -> render
        //displayPDFweb.loadRequest(NSURLRequest(url: cico) as URLRequest)
  
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


    //MARK: Button Actions
    
    @IBAction func toButtonAction(_ sender: UIButton) {
        
        let selectUserVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "SelectUserViewController") as! SelectUserViewController
        selectUserVC.dataCtrl = dataCtrl
        selectUserVC.userType = NewConversationUserType.to
        self.navigationController?.pushViewController(selectUserVC, animated: true)
    }
    
    @IBAction func bccButtonAction(_ sender: UIButton) {
        
        let selectUserVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "SelectUserViewController") as! SelectUserViewController
        selectUserVC.dataCtrl = dataCtrl
        selectUserVC.userType = NewConversationUserType.bcc
        self.navigationController?.pushViewController(selectUserVC, animated: true)
    }
    
    @IBAction func approvalButtonAction(_ sender: UIButton) {
        
        let selectUserVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "SelectUserViewController") as! SelectUserViewController
        selectUserVC.dataCtrl = dataCtrl
        selectUserVC.userType = NewConversationUserType.forApproval
        self.navigationController?.pushViewController(selectUserVC, animated: true)
    }
    
    @IBAction func verificationButtonAction(_ sender: UIButton) {
        
        let selectUserVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "SelectUserViewController") as! SelectUserViewController
        selectUserVC.dataCtrl = dataCtrl
        selectUserVC.userType = NewConversationUserType.forVerification
        self.navigationController?.pushViewController(selectUserVC, animated: true)
    }
    
    @IBAction func attachmentButtonAction(_ sender: Any) {
        
        let alert = UIAlertController(title:"Select Media", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Take An Image", style: .default , handler:{ (UIAlertAction)in
                self.dataCtrl?.isDocumentSelected = false
                self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Open Photo Gallery", style: .default , handler:{ (UIAlertAction)in
            self.dataCtrl?.isDocumentSelected = false
            self.openPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "Document", style: .default , handler:{ (UIAlertAction)in
            self.dataCtrl?.isDocumentSelected = true
             self.openDocuments()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler:{ (UIAlertAction)in
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func closeButtonAction(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func startConversationButtonAction(_ sender: UIButton) {
        
        if((dataCtrl?.toUserList?.count)! > 0 && subjectTextField.text != nil && (subjectTextField.text?.count)! > 0 && messageTextView.text != nil && messageTextView.text.count > 0 && dataCtrl?.selectedFilenameInNewConversation != nil && dataCtrl?.selectedFileDataInNewConversation != nil)
        {
            dataCtrl?.newConversationSubject = subjectTextField.text
            dataCtrl?.newConversationMessage = messageTextView.text
            
            self.showTransperantLoadingOnViewController()
            
            dataCtrl?.createNewConversation(onSuccess: { [unowned self] in
                
                DispatchQueue.main.async {
                    
                    self.dataCtrl?.isNewConversationAdded = true
                    self.navigationController?.popViewController(animated: true)
                }
                
            }, onFailure: { [unowned self] (errorMessage) in
                
                DispatchQueue.main.async {
                    
                    let alert = UIAlertController(title:AlertMessages.sorry, message:errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
        else
        {
            let alert = UIAlertController(title:AlertMessages.sorry, message:"Please enter valid data to start new conversation", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
