//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by Kubilay Kitapçıoğlu on 10.02.2020.
//  Copyright © 2020 Kubilay Kitapçıoğlu. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func signUpClicked(_ sender: Any) // SIGN UP
    {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }
                else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }

        }
        else {
            makeAlert(titleInput: "Error", messageInput: "Username/Password")
        }
    }
    
    
    @IBAction func signInClicked(_ sender: Any)  //SIGN IN
    {
        
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }
            }
        }
        else {
            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
        }

        
        
    }
    
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

