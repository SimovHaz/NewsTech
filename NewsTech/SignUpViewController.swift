//
//  SignUpViewController.swift
//  NewsTech
//
//  Created by Karizma LTD on 02/08/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit
import Parse
import SlideMenuControllerSwift
import SDWebImage

class SignUpViewController: UIViewController ,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var fullName: UITextField!
    var picker = UIImagePickerController()
    var path : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func loadPicture(_ sender: Any) {
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum;
        picker.allowsEditing = false
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            picker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(picker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
            alertWarning.show()
        }
    }
    func openGallary()
    {
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150)) as UIActivityIndicatorView
        spinner.startAnimating()
        
        let newUser = PFUser()
        
        newUser.username = email.text
        newUser.password = password.text
        newUser.email = email.text
        newUser["fullName"] = fullName.text
        newUser["avatar"] = path
      
        
        // Sign up the user asynchronously
        newUser.signUpInBackground(block: { (succeed, error) -> Void in
            
            // Stop the spinner
            spinner.stopAnimating()
            if ((error) != nil) {
                let alert = UIAlertView(title: "Error", message: "\(String(describing: error))", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
            } else {
                let alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                DispatchQueue.main.async(execute: { () -> Void in
                    let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainPostViewNavigation") as! UINavigationController
                    let menu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                    
                    let slideMenuController = SlideMenuController(mainViewController: main , rightMenuViewController: menu)
                    
                    SlideMenuOptions.leftViewWidth = UIScreen.main.bounds.width - 70
                    SlideMenuOptions.contentViewScale = 1
                    
                    self.present(slideMenuController, animated: true, completion: nil)
                })
            }
        })
    }
    
    //PickerView Delegate Methods
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        picker.dismiss(animated: true, completion: nil)
        let imageData = UIImagePNGRepresentation((info[UIImagePickerControllerOriginalImage] as? UIImage)!)
        let file = PFFile(name: email.text! + ".png", data: imageData!)
        file?.saveInBackground({ (done, error) in
            if error == nil {
                print("done")
                self.path = file?.url!
                self.avatar.sd_setImage(with: URL(string: (file?.url!)! ), placeholderImage: UIImage(named: "profile-icon"), options: SDWebImageOptions()) { (image, error, cacheType, url) in
                    if image != nil {
                        self.avatar.image = image
                    }
                }
            }
        })
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("picker cancel.")
    }
    
    
}
