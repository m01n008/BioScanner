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
    
    private let authManager = AuthManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func toggleBtnTapped(_sender1: UIButton){
        let status: Bool = authManager.resetBioIDPolicyState()
        alert(title: "BioIDPolicyState",
              message: "BioIDPolicyState Reset \(status)",
              okActionTitle: "Ok")
        
    }
    
    @IBAction func verifyBtnTapped(_sender: UIButton){
        if(authManager.isBiometricsAvailable()){
            if(authManager.isBiometricsChanged()){
                self.alert(title: "Biometrics Changed", message: "Please reconfigure FaceID/TouchID", okActionTitle: "Ok")
            }
            else{
                
                authManager.evaluate {
                    [weak self] (success, btype, result) in
                    guard success == 1 else {
                        
                        self?.alert(title: "\(btype.localDescription) Error \(result.rawValue)",
                                    message: result.localizedDescription,
                                    okActionTitle: "Ok")
                        return
                    }
                    self?.alert(title: "\(btype.localDescription) Success",
                                message: result.localizedDescription,
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



