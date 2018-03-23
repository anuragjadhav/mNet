//
//  AttachmentsViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/31/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class AttachmentsViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var attachmentsTableView: UITableView!
    
    var documentVC:DocumentViewController?
    var documents:[ApprovalDocument] = [ApprovalDocument]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        attachmentsTableView.reloadData()
        attachmentsTableView.tableFooterView = UIView()
    }


    //Mark: tableview delegates and data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:AttachmentsTableViewCell = tableView.dequeueReusableCell(withIdentifier:"AttachmentsTableViewCell") as! AttachmentsTableViewCell
        cell.setUpCell(fileNameString: documents[indexPath.row].link)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let urlString:String = documents[indexPath.row].link
        
        let webViewController:WebViewController = UIStoryboard.webView.instantiateViewController(withIdentifier: StoryboardIDs.webViewController) as! WebViewController
        webViewController.setData(url: URL(string: urlString), header: urlString.components(separatedBy: "/").last)
        documentVC?.navigationController?.pushViewController(webViewController, animated: true)
    }

}
