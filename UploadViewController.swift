//
//  UploadViewController.swift
//  InstaCloneFirebase
//
//  Created by Kubilay Kitapçıoğlu on 12.02.2020.
//  Copyright © 2020 Kubilay Kitapçıoğlu. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var commentText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UIGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    @objc func chooseImage() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    func makeAlert (title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okB = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okB)
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func actionButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = Storage.storage().reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg") //her fotoya farklı id
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                
                if error != nil {
                    self.makeAlert(title: "ERROR!", message: error?.localizedDescription ?? "Error") //localized description firebaseın errorunu gösterir
                }else{
                    imageReference.downloadURL { (url, error) in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            print (imageUrl)
                            
                            
                            
                            //DATABASE
                        }
                    }
                }
            }
        }
    }
}
