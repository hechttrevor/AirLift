//
//  ViewControllerLogIn.swift
//  AirLift
//
//  Created by Trevor Hecht on 3/28/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewControllerLogIn: UIViewController {

    let backgroundImageView = UIImageView()
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setUpTextFields()
    }
    
    @IBAction func forgotEmail(_ sender: Any) {
    }
    
    @IBAction func loginConfirmation(_ sender: Any) {
        //make sure textFields are valid
        guard let email = emailTF.text, let password = passwordTF.text
            else{
                showAlert(title: "Invalid", message: "Must fill out each field")
                return
        }
        
        //Firebase auth checks the email and password
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.showAlert(title: "Error", message: "\(String(describing: error))")
                return
            }
            //Login successful, takes you to main page
            //self.showAlert(title: "Success", message: "You have been logged in")
            
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vcHome") as? ViewControllerHomePage {
                self.present(vc, animated: true, completion: nil)
            }
            
        })
    }
    
    
    
  
//THESE ARE COMMON funcs - in most files  ******************************************************************
    func setBackground(){
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false //basiaclly lets you auto layout
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "Background1")
        view.sendSubviewToBack(backgroundImageView)
    }
    func setUpTextFields(){
        passwordTF.isSecureTextEntry = true
    }
    
    func showAlert(title : String, message: String){
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }

}
