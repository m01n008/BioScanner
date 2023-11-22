//
//  ViewController.swift
//  BioScannerApp
//
//  Created by Muhammad Moin Raza Khan on 27/10/2023.
//

import UIKit
import BioScanner
class ViewController: UIViewController {
    
    @IBOutlet weak var verifyBtn: UIButton?
    @IBOutlet weak var toggleBtn: UIButton?
    
    private var authManager = AuthManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        verifyBtn?.setImage(UIImage(systemName: "faceid"), for: .normal)
        
        /*
        // create the alert
        
        */
        
    }
    @IBAction func toggleBtnTapped(_sender1: UIButton){
        let status: String = authManager.resetBioIDPolicyState()
        alert(title: "BioIDPolicyState",
              message: status,
              okActionTitle: "Ok")
        
    }
    
    @IBAction func verifyBtnTapped(_sender: UIButton){
        if(authManager.isBiometricsAvailable()){
            if(authManager.isBiometricsChanged()){
                self.alert(title: "Biometrics Changed", message: "Please reconfigure FaceID/TouchID", okActionTitle: "Ok")
            }
            else{
                
                authManager.evaluate {
                    [weak self] (success, error) in
                    guard success == 1 else {
                        
                        self?.alert(title: "Failed",
                                    message: "Biometric Unsuccessful. FaceID/TouchID might not be configured",
                                    okActionTitle: "Ok")
                        return
                    }
                    self?.alert(title: "Success",
                                message: "Biometric successful",
                                okActionTitle: "Ok")
                    
                }
            }
        }
        else{
            self.alert(title: "Biometric Availablity",
                        message: "Biometrics not available",
                        okActionTitle: "Ok")
        }
                       
    }
    
    
    func alert(title: String, message: String, okActionTitle: String) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }


}



