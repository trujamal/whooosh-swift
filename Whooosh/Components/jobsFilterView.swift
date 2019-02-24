//
//  jobsFilterView.swift
//  Whooosh
//
//  Created by Jamal Rasool on 2/22/19.
//  Copyright © 2019 Jamal Rasool. All rights reserved.
//

import UIKit


class jobsFilterView: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var FilterTag: UIView!
    @IBOutlet weak var DistanceTag: UILabel!
    @IBOutlet weak var JobTypeTag: UILabel!
    @IBOutlet weak var LocationTag: UILabel!
    @IBOutlet weak var CompanyTag: UILabel!
    @IBOutlet weak var CloseButton: UIButton!
    @IBOutlet weak var HorizontalSpacer: UIView!
    @IBOutlet weak var DistanceSlider: UISlider!
    @IBOutlet weak var MileRadius: UILabel!
    @IBOutlet weak var JobTypeField: UITextField!
    @IBOutlet weak var LocationTypeField: UITextField!
    @IBOutlet weak var CompanyTypeField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        MileRadius.text = "\(DistanceSlider.value)mi"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        
    }
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func distanceSliderAction(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        MileRadius.text = "\(currentValue)mi"
    }
    
    @IBAction func closeModalView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == JobTypeField {

        }
    }
    
    @IBAction func ApplyFilterButton(_ sender: Any) {
//        let filteredArray = editableStaticUserData.companies.filter {
//            if let companyIdentifier = $0.companiesIdentifier,
//                let companyIds = self.editableFilter?.companyIds,
//            where companyIds.contains(companyIdentifier) {
//                return true
//            }
//        }
//        var matchedCompanyIds = Set(filteredArray)
        closeModalView(AnyObject.self)
    }
    
    @IBAction func ClearFilterButton(_ sender: Any) {
        
        // Sending empty values.
        JobTypeField.text = ""
        LocationTypeField.text = ""
        CompanyTypeField.text = ""
        closeModalView(AnyObject.self)
    }
    

    
}
