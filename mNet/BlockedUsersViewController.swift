//
//  BlockedUsersViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 3/26/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class BlockedUsersViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,KRPullLoadViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var peopleTableView: UITableView!
    
     @IBOutlet weak var noBlockedUsersLabel: CustomBrownTextColorLabel!
    
    let dataCtrl:PeopleDataController = PeopleDataController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // add pull down refresh control
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self as KRPullLoadViewDelegate
        peopleTableView.addPullLoadableView(loadMoreView, type: .loadMore)
        
        peopleTableView.tableFooterView = UIView()
        
        dataCtrl.showOnlyBlockedUsers = true
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
        
        let cell:PeopleTableViewCell = tableView.dequeueReusableCell(withIdentifier:CellIdentifiers.peopleTableViewCell) as! PeopleTableViewCell
        
        let people:People = dataCtrl.peopleArray[indexPath.row]
        
        cell.loadCellWithPeople(people)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let people:People = dataCtrl.peopleArray[indexPath.row]
        let profileVC = UIStoryboard.profile.instantiateViewController(withIdentifier: StoryboardIDs.profileViewController) as! ProfileViewController
        profileVC.didComeFromPeopleVC = true
        profileVC.dataCtrl.selectedPeople = people
        self.navigationController?.pushViewController(profileVC, animated: true)
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
                    self.checkNoData()
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
    
    func checkNoData() {
        
        noBlockedUsersLabel.isHidden = dataCtrl.peopleArray.count > 0
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
                
                if((searchBar.text == nil || searchBar.text == "") && dataCtrl.previousCallSuccessOrFailed){
                    
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
