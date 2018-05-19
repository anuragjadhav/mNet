//
//  ImageDisplayViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 19/05/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ImageDisplayViewController: BaseViewController,EFImageViewZoomDelegate {

     @IBOutlet weak var imageViewZoom: EFImageViewZoom!
    
    var imageUrl:URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(imageUrl != nil)
        {
            let urlRequest:URLRequest = URLRequest(url: imageUrl!)
            
            self.showLoadingOnViewController()
        
            UIImage.imageDownloader.download(urlRequest) { response in
                
                self.removeLoadingFromViewController()

                if let image = response.result.value {
                    
                    self.imageViewZoom._delegate = self as EFImageViewZoomDelegate
                    self.imageViewZoom.image = image
                    self.imageViewZoom.contentMode = .left
                }
            }
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
