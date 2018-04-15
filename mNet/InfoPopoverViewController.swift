//
//  InfoPopoverViewController.swift
//  mNet
//
//  Created by vishruta kadam on 27/03/18.
//  Copyright © 2018 mNet. All rights reserved.
//

protocol PopOverDelegate:class {
    
    func didSelectItem(popOverObject:PopoverObject, at index:Int)
}


import UIKit

class InfoPopoverViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Outlets and Properties
    
    @IBOutlet weak var popoverTableView: UITableView!
    var dataArray:[PopoverObject] = [PopoverObject]()
    weak var delegate:PopOverDelegate?
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Setup
    func setUp() {
        
        popoverTableView.tableFooterView = UIView()
        popoverTableView.reloadData()
        
        var height:Int = dataArray.count * Int(popoverTableView.rowHeight)
        
        if(height > 400)
        {
            height = 400
        }
        
        self.preferredContentSize = CGSize(width: 200, height: height)
    }
    
    
    //MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.popoverTableViewCell) as! PopoverTableViewCell
        let popOverObject = self.dataArray[indexPath.row]
        cell.loadCellWith(popOverObject: popOverObject)
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let popOverObject = self.dataArray[indexPath.row]
        self.dismiss(animated: false, completion: nil)
        delegate?.didSelectItem(popOverObject: popOverObject, at: indexPath.row)
        
    }
}
