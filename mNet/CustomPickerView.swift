//
//  CustomPickerView.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/22/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

protocol CustomPickerViewDelegate : class {
    
    func selectedPickerViewIndex(index:Int)
}

class CustomPickerView: UIView {

    @IBOutlet weak var pickerView: UIPickerView!
    
    var isOn:Bool = false
    
    weak var delegate : CustomPickerViewDelegate? {
        
        didSet {
            self.pickerView.delegate = (self.delegate as! UIPickerViewDelegate)
            self.pickerView.dataSource = (self.delegate as! UIPickerViewDataSource)
        }
        
    }
    
    
    //Mark: Show Hide PickerView
    
    func showPickerView(){
        
        if(self.isOn == false)
        {
            self.isOn = true
            
            self.pickerView.reloadAllComponents()
            
            self.pickerView.selectRow(0, inComponent: 0, animated: false)
            
            let newY = self.frame.origin.y - self.frame.size.height
            let newRect =  CGRect(x: 0, y: newY, width: self.frame.size.width, height: self.frame.size.height)
            
            UIView.animate(withDuration: 0.5) {
                
                self.frame = newRect
            }
        }
    }
    
    func hidePickerView() {
        
        if (self.isOn == true)
        {
            self.isOn = false
            
            let newY = self.frame.origin.y + self.frame.size.height
            let newRect =  CGRect(x: 0, y: newY, width: self.frame.size.width, height: self.frame.size.height)
            
            UIView.animate(withDuration: 0.5) {
                
                self.frame = newRect
            }
        }
    }
    
    //Mark: Button Action
    
    @IBAction func doneButtonAction(_ sender: Any) {
        
        self.hidePickerView()
        
        let  selectedIndex:Int = self.pickerView.selectedRow(inComponent: 0)
        
        if(delegate != nil){
            
            delegate?.selectedPickerViewIndex(index: selectedIndex)
        }
    }

}
