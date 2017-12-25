//
//  CustomPickerView.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/22/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

@objc protocol CustomPickerViewDelegate : class {
    
   @objc optional func selectedPickerViewIndex(index:Int)
   @objc optional func selectedDateOnPickerView(date:Date)

}

class CustomPickerView: UIView {

    @IBOutlet weak var customPickerView: UIPickerView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    private var isCustomPickerOn:Bool = false
    private var isDatePickerPickerOn:Bool = false
    
    private var selectedRowOnCustomPickerView:Int?
    private var selectedDateOnDatePickerView:Date?
    
    private var showDatePicker:Bool = false
    
    weak var delegate : CustomPickerViewDelegate? {
        
        didSet {
            
            if(self.showDatePicker == false){
                
                self.customPickerView.delegate = (self.delegate as! UIPickerViewDelegate)
                self.customPickerView.dataSource = (self.delegate as! UIPickerViewDataSource)
            }
            else{
                
                self.customPickerView.delegate = nil
                self.customPickerView.dataSource = nil
            }
        }
        
    }
    
    
    //Mark: Show Hide PickerView
    
    func showPickerView(isDatePicker:Bool,delegate:CustomPickerViewDelegate?){
        
        self.showDatePicker = isDatePicker
        
        self.delegate = delegate
        
        if(self.showDatePicker == true){
            
            if(self.isCustomPickerOn == true){
                
                self.hidePicker()
                self.isCustomPickerOn = false;
                self.customPickerView.isHidden = true
                
                self.datePickerView.isHidden = false
                self.showPicker()
                self.isDatePickerPickerOn = true
            }
            else if(self.isDatePickerPickerOn == false){
                
                self.isCustomPickerOn = false;
                self.customPickerView.isHidden = true
                
                self.datePickerView.isHidden = false
                self.showPicker()
                self.isDatePickerPickerOn = true
            }
        }
        else{
            
            if(self.isDatePickerPickerOn == true){
                
                self.hidePicker()
                self.isDatePickerPickerOn = false;
                self.datePickerView.isHidden = true

                self.customPickerView.isHidden = false
                self.customPickerView.reloadAllComponents()
                self.customPickerView.selectRow(0, inComponent: 0, animated: false)
                self.showPicker()
                self.isCustomPickerOn = true
            }
            else if (self.isCustomPickerOn == false){
                
                self.isDatePickerPickerOn = false;
                self.datePickerView.isHidden = true
                
                self.customPickerView.isHidden = false
                self.customPickerView.reloadAllComponents()
                self.customPickerView.selectRow(0, inComponent: 0, animated: false)
                self.showPicker()
                self.isCustomPickerOn = true
            }
        }

    }


    // Show Picker
    
    func showPicker(){
        
        let newY = self.frame.origin.y - self.frame.size.height
        let newRect =  CGRect(x: 0, y: newY, width: self.frame.size.width, height: self.frame.size.height)
        
        UIView.animate(withDuration: 0.5) {
            
            self.frame = newRect
        }
    }
    
    // Hide Picker
    
    func hidePicker(){
        
        let newY = self.frame.origin.y + self.frame.size.height
        let newRect =  CGRect(x: 0, y: newY, width: self.frame.size.width, height: self.frame.size.height)
        
        UIView.animate(withDuration: 0.5) {
            
            self.frame = newRect
        }
    }
    
    //Mark: Button Action
    
    @IBAction func doneButtonAction(_ sender: Any) {
        
        self.hidePicker()
        
        if(self.isCustomPickerOn){
            
            self.isCustomPickerOn = false
            let  selectedIndex:Int = self.customPickerView.selectedRow(inComponent: 0)
            
            if(delegate != nil){
                
                delegate?.selectedPickerViewIndex!(index: selectedIndex)
            }
        }
        
        if(self.isDatePickerPickerOn){
            
            self.isDatePickerPickerOn = false
            
            if(delegate != nil){
                
                delegate?.selectedDateOnPickerView!(date: self.datePickerView.date)
            }
        }
    }

}
