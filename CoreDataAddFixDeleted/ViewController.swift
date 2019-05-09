//
//  ViewController.swift
//  CoreDataAddFixDeleted
//
//  Created by Vu on 5/9/19.
//  Copyright © 2019 Vu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    
    
    var data: Entity?
    var index: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let Adata = data {
            nameTextField.text = Adata.nameCoreData
            ageTextField.text = String(Adata.ageCoreData)
            imageView.image = Adata.imageCoreData as? UIImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Error \(info)")
        }
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickSelecLibrary(_ sender: UITapGestureRecognizer) {
        let imageController = UIImagePickerController()
        imageController.sourceType = .photoLibrary
        imageController.delegate = self
        present(imageController, animated: true, completion: nil)
    }
    
    @IBAction func onClickDoneButton(_ sender: UIButton) {
        if index == nil {
            let entity = Entity(context: AppDelegate.context)
            if let content = imageView.image {
                entity.imageCoreData = content
            }
            if let nameText = nameTextField.text {
                entity.nameCoreData = nameText
            }
            if let ageText = ageTextField.text {
                entity.ageCoreData = Int64(ageText) ?? 0
            }
        } else {
            data?.setValue(imageView.image, forKey: "imageCoreData")
            data?.setValue(nameTextField.text, forKey: "nameCoreData")
            data?.setValue(Int(ageTextField.text!), forKey: "ageCoreData")
        }
        AppDelegate.saveContext()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onClickCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

