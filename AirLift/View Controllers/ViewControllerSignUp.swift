//
//  ViewControllerSignIn.swift
//  AirLift
//
//  Created by Trevor Hecht on 3/28/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewControllerSignUp: UIViewController {
    
    let backgroundImageView = UIImageView()
    var ref : DatabaseReference!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.isHidden = true
        setBackground()
        setUpTextFields()
        ref = Database.database().reference()

    }
    
//ON Click listener for register button
    @IBAction func signUpConfirmation(_ sender: Any) {
        //start loading icon
        self.loadingIndicator.isHidden = false
        self.loadingIndicator.startAnimating()
        //make sure textFields are valid
        guard let email = emailTF.text, let password = passwordTF.text, let confirmPass = confirmPassTF.text
            else{
                showAlert(title: "Invalid", message: "Must fill out each field")
                self.loadingIndicator.isHidden = true
                self.loadingIndicator.stopAnimating()
                return
            }
        
        if confirmPass != password {
            showAlert(title: "Error", message: "Passwords are not the same")
            self.loadingIndicator.isHidden = true
            self.loadingIndicator.stopAnimating()
            return
        }
        
        //Firebase Authentication, create unique ID, makes sure email is valid and not in use
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.showAlert(title: "Error", message: "\(String(describing: error))")
                print (error ?? "")
                self.loadingIndicator.isHidden = true
                self.loadingIndicator.stopAnimating()
                return
            }
            //if email and pass are valid:
            let userInfo = ["email" : email, "password" : password]
            let userChild = self.ref.child("Users").child((user?.user.uid)!)
            
            userChild.updateChildValues(userInfo, withCompletionBlock: { (err, ref)in
                if err != nil{
                    self.showAlert(title: "Error", message: "\(String(describing: err))")
                    print (err ?? "")
                    self.loadingIndicator.isHidden = true
                    self.loadingIndicator.stopAnimating()
                    return
                }
                self.showAlertAndSendHome(title: "Success" , message: "Email: \(email) has successfully been registered")
//                //Send to main page
//                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vcHome") as? ViewControllerHomePage {
//                    self.present(vc, animated: true, completion: nil)
//                }
            })
        }
        

    }
    
//Alert with action to bring you to Home page
    func showAlertAndSendHome(title : String, message: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action: UIAlertAction!) in
            //Open Segue with Aircraft Home
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vcHome") as? ViewControllerHomePage { self.present(vc, animated: true, completion: nil) }
    
        }))
        self.loadingIndicator.isHidden = true
        self.loadingIndicator.stopAnimating()
        self.present(alertController, animated: true, completion: nil)
    }
    
    
//THESE ARE COMMON funcs - in most files  ******************************************************************
    func initiateFirebase(){
//        let actionCodeSettings = ActionCodeSettings()
//        actionCodeSettings.url = URL(string: "https://console.firebase.google.com/project/rescueapp-d91a0")
//        actionCodeSettings.handleCodeInApp = true
//        actionCodeSettings.setIOSBundleID(com.AirLift!)
        
    }
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
        confirmPassTF.isSecureTextEntry = true
    }

    func showAlert(title : String, message: String){
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
