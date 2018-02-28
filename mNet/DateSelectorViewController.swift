//
//  DateSelectorViewController.swift
//  bizanalyst
//
//  Created by Nac on 24/10/16.
//  Copyright © 2016 Silicon Veins. All rights reserved.
//

import UIKit

protocol DateSelectorDeleagte {
    
    func didSelectDate(filterString:String?, fromDate:String?, toDate:String?)
}

class DateSelectorViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet var selectTimeView: UIView!
    
    @IBOutlet var selectTimeLabel: UILabel!
    
    @IBOutlet var allButton: UIButton!
    @IBOutlet var todayButton: UIButton!
    @IBOutlet var pastWeekButton: UIButton!
    @IBOutlet var past15DaysButton: UIButton!
    @IBOutlet var pastMonthButton: UIButton!
    @IBOutlet var customDateButton: UIButton!
    
    @IBOutlet var selectTimeSuperView: UIView!
    @IBOutlet var customDateSelectorView: UIView!
    @IBOutlet var customDateSegmentedControl: UISegmentedControl!
    @IBOutlet var fromDateLabel: UILabel!
    @IBOutlet var toDateLabel: UILabel!
    @IBOutlet var fromDatePicker: UIDatePicker!
    @IBOutlet var toDatePicker: UIDatePicker!
    @IBOutlet var doneButton: UIButton!
    
    //MARK: Properties
    
    var tapGesture = UITapGestureRecognizer()
    var delegate:DateSelectorDeleagte?
    let preSelectedDate:Date = Date()
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpView()
    }
    
    
    //MARK: Setup
    
    func setUpView() {
        
        customDateSegmentedControl.selectedSegmentIndex = 0
        customDateSegmentedControl.tintColor = ColorConstants.kBlueColor
        selectTimeSuperView.layer.cornerRadius = 8.0
        selectTimeSuperView.clipsToBounds = true
        customDateSelectorView.layer.cornerRadius = 8.0
        customDateSelectorView.clipsToBounds = true
        selectTimeSuperView.isHidden = false
        customDateSelectorView.isHidden = true
        fromDatePicker.tintColor = ColorConstants.kBlueColor
        toDatePicker.tintColor = ColorConstants.kBlueColor
        tapGesture.addTarget(self, action: #selector(dismissVC))
        fromDatePicker.setDate(preSelectedDate, animated: true)
        toDatePicker.setDate(preSelectedDate, animated: true)
        fromDateLabel.text = preSelectedDate.stringWithFullDate()
        fromDateLabel.text = preSelectedDate.stringWithFullDate()
        view.addGestureRecognizer(tapGesture)
    }
    
    
    //MARK:Button Actions
    @IBAction func allButtonAction(sender: UIButton) {
        
        delegate?.didSelectDate(filterString: nil, fromDate: nil, toDate: nil)
        dismissVC()
    }
    
    
    @IBAction func todayButtonAction(sender: UIButton) {
        
        delegate?.didSelectDate(filterString: "1", fromDate: nil, toDate: nil)
        dismissVC()
    }
    
    
    @IBAction func pastWeekButtonAction(sender: UIButton) {
        
        delegate?.didSelectDate(filterString: "2", fromDate: nil, toDate: nil)
        dismissVC()
    }
    
    
    @IBAction func past15DaysButtonAction(sender: UIButton) {
        
        delegate?.didSelectDate(filterString: "3", fromDate: nil, toDate: nil)
        dismissVC()
    }
    
    
    @IBAction func pastMonthButtonAction(sender: UIButton) {
        
        delegate?.didSelectDate(filterString: "4", fromDate: nil, toDate: nil)
        dismissVC()
    }
    
    @IBAction func customDateButtonAction(sender: UIButton) {
        
        selectTimeSuperView.isHidden = true
        customDateSelectorView.isHidden = false
        
        toDatePicker.isHidden = true
        fromDatePicker.isHidden = false
    }
    
    //MARK: Segmented Control
    
    @IBAction func segmentedControlDidChange(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            
            toDatePicker.isHidden = true
            fromDatePicker.isHidden = false
            
        case 1:
            
            toDatePicker.isHidden = false
            fromDatePicker.isHidden = true
            
        default:
            break
            
        }
    }
    
    
    //MARK: Date Picker
    
    @IBAction func fromDateValueChanged(sender: AnyObject) {
        
        fromDateLabel.text = fromDatePicker.date.stringWithFullDate()
    }
    
    
    @IBAction func toDateValueChange(sender: AnyObject) {
        
        toDateLabel.text = toDatePicker.date.stringWithFullDate()
    }
    
    
    @IBAction func doneButtonAction(sender: UIButton) {
        
        delegate?.didSelectDate(filterString: "5", fromDate: fromDatePicker.date.stringWithDDMMYYYY(), toDate: toDatePicker.date.stringWithDDMMYYYY())
        dismissVC()
    }
    
    //MARK: Tap Gesture:
    
    @objc func dismissVC() {
        
        self.dismiss(animated: false) {
            self.view.removeGestureRecognizer(self.tapGesture)
        }
    }
}
