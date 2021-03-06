//
//  NewCategoryVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 27/05/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import RealmSwift

class NewCategoryVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: CustomButton!
    
    let imagePicker = UIImagePickerController()
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Como la imageView no puede tener IBAction, le ponemos un Gesture Recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imagePicker.delegate = self
        
        setUpButton()
    }
    // Presiona la imagen y aparece un pop up con las opciones de camara
    @objc func imageViewTapped() {
        
        let controller = UIAlertController(title: "Select Image", message: "", preferredStyle: .actionSheet)
        
        controller.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert) in
            self.presentImagePicker(with: .camera)
        }))
        
        controller.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: { (action) in
            self.presentImagePicker()
        }))
        
        controller.addAction(UIAlertAction(title: "Film roll", style: .default, handler: { (action) in
            self.presentImagePicker(with: .photoLibrary)
        }))
        
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(controller, animated: true, completion: nil)
    }
    // presentamos las opciones de la libreria de fotos con una como defecto
    func presentImagePicker(with sourceType: UIImagePickerController.SourceType = .savedPhotosAlbum) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func setUpButton() {
        cancelButton.makeBacgroundWhiteWithBorder()
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        // asociamos newCategory a FoodCategory para tener acceso a sus variables
        let newCategory = FoodCategory()
        newCategory.title = textField.text!
        newCategory.imageName = imageView.image?.jpegData(compressionQuality: 0.1) // imagen reducida
        
        do {
            try realm.write {
                realm.add(newCategory)
            }
        } catch {
            print(error.localizedDescription)
        }
        // Pasar informacion a la CategoryVC
        NotificationCenter.default.post(name: Notifications.viewControllerPublishNotification, object: nil, userInfo: nil)
        
        self.dismiss(animated:true, completion:nil);
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        self.tabBarController?.selectedIndex = 0
    }
}

extension NewCategoryVC: UITextFieldDelegate {

    // Desaparece el teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// El UINavigationControllerDelegate lo ponemos por que vamos a navegar a otra aplicacion diferente
extension NewCategoryVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
