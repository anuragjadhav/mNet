//
//  PeopleViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/28/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class PeopleViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,KRPullLoadViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var peopleTableView: UITableView!
    
    let dataCtrl:PeopleDataController = PeopleDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // add pull down refresh control
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self as KRPullLoadViewDelegate
        peopleTableView.addPullLoadableView(loadMoreView, type: .loadMore)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.setupNavigationBar()
        getPeopleList(isReload: true)
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //Mark: tableview delegates and data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataCtrl.peopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PeopleTableViewCell = tableView.dequeueReusableCell(withIdentifier:"PeopleTableViewCell") as! PeopleTableViewCell
        
        let people:People = dataCtrl.peopleArray[indexPath.row]
        
        cell.loadCellWithPeople(people)

        return cell
    }

    // MARK: - Search bar delegates
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        dataCtrl.filterPeopleWithSearchTerm(searchTerm: searchBar.text)
        peopleTableView.reloadData()
    }
    
    //MARK: Get People list
    
    func getPeopleList(isReload:Bool)
    {
        if Reachability.isConnectedToNetwork(){
            
            if(isReload){
            
                self.showLoadingOnViewController()
            }
            
            dataCtrl.getPeopleList(onSuccess: { [unowned self] in
                
                DispatchQueue.main.async {
                    
                    if(isReload){
                        self.removeLoadingFromViewController()
                    }
            
                    self.peopleTableView.reloadData()
                }
                
                }, onFailure: { [unowned self] (errorMessage) in
                    
                    DispatchQueue.main.async {
                        
                        if(isReload){
                            self.removeLoadingFromViewController()
                            self.showRetryView(message:errorMessage)
                        }
                    }
            })
            
        }else{
            
            self.showRetryView(message: AlertMessages.networkUnavailable)
        }
    }
    
    // MARK: - Button Actions

    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Pull Up refresh control delegate
    
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
            switch state {
            case let .loading(completionHandler):
                completionHandler()
                
                if(searchBar.text == nil || searchBar.text == ""){
                    
                    self.getPeopleList(isReload: false)
                }
            default: break
            }
            return
        }
    }
    
    //MARK: retry view delegate
    
    override func retryButtonClicked() {
        
        getPeopleList(isReload: true)
    }

}
