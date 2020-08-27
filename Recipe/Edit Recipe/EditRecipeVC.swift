//
//  EditRecipeVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 17/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import RealmSwift

class EditRecipeVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prepTimeTextField: UITextField!
    @IBOutlet weak var cookTimeTextField: UITextField!
    @IBOutlet weak var difficultyTextField: UITextField!
    @IBOutlet weak var serversTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ingridientsTextField: UITextView!
    @IBOutlet weak var instructionsTextField: UITextView!
    @IBOutlet weak var cancelButton: CustomButton!
    
    var editRecipe: Recipe!
    var foodCategory: FoodCategory?
    let realm = try! Realm()
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imagePicker.delegate = self
        
        setupEditRecipe()
        setUpButton()
    }
    
    @objc func imageViewTapped() {
        let controller = UIAlertController(title: "Select Image", message: "", preferredStyle: .actionSheet)
        
        controller.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.presentImagePicker(with: .camera)
        }))
        
        controller.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: { (alert) in
            self.presentImagePicker()
        }))
        
        controller.addAction(UIAlertAction(title: "Film Roll", style: .default, handler: { (alert) in
            self.presentImagePicker(with: .photoLibrary)
        }))
        
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(controller, animated: true, completion: nil)
    }
    
    func presentImagePicker(with sourceTyoe: UIImagePickerController.SourceType = .savedPhotosAlbum) {
           
           imagePicker.allowsEditing = false
           imagePicker.sourceType = sourceTyoe
           present(imagePicker, animated: true, completion: nil)
       }
    
    func setupEditRecipe() {
        
        imageView.image = UIImage(data: editRecipe.imageName!)
        prepTimeTextField.text = editRecipe.preparation
        cookTimeTextField.text = editRecipe.timeToCook
        difficultyTextField.text = editRecipe.difficulty
        serversTextField.text = editRecipe.serves
        ingridientsTextField.text = editRecipe.ingridients
        instructionsTextField.text = editRecipe.instructions
        titleTextField.text = editRecipe.recipeTitle
    }
    
    func setUpButton() {
        cancelButton.makeBacgroundWhiteWithBorder()
    }

    @IBAction func editButtonPressed(_ sender: UIButton) {
        
        let editRecipe = Recipe()
        editRecipe.recipeTitle = titleTextField.text!
        editRecipe.preparation = prepTimeTextField.text!
        editRecipe.timeToCook = cookTimeTextField.text!
        editRecipe.difficulty = difficultyTextField.text!
        editRecipe.serves = serversTextField.text!
        editRecipe.ingridients = ingridientsTextField.text!
        editRecipe.instructions = instructionsTextField.text!
        editRecipe.imageName = imageView.image?.jpegData(compressionQuality: 0) // imagen reducida
        print("add \(editRecipe) to \(String(describing: self.foodCategory))")
        
        do {
            try realm.write {
                self.foodCategory?.recipes.append(editRecipe)
                self.realm.add(editRecipe, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
        // Pasar informacion a la RecipeVC
        NotificationCenter.default.post(name: Notifications.newRecipe, object: nil, userInfo: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension EditRecipeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
