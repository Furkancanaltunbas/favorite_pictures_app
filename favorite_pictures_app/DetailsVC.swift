//
//  DetailsVC.swift
//  favorite_pictures_app
//
//  Created by FurkanCan on 11/09/2022.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var DataText: UITextField!
    
    @IBOutlet weak var explanation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recognizers
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)

    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Pictures", into: context)
        newPainting.setValue(nameText.text, forKey: "name")
        
        if let date = Int(DataText.text!){
            newPainting.setValue(DataText.text, forKey: "date")
        }
        
        newPainting.setValue(UUID(), forKey: "id")
        
        let Image = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(Image, forKey: "image")
        
        do{
            try context.save()
        }catch{
            
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
        

        
   
        
        
    }
    

}
