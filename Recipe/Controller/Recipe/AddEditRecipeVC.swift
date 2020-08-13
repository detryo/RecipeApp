//
//  NewCategorySelectionVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 02/06/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import RealmSwift

public class AddEditRecipeVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prepTimeTextField: UITextField!
    @IBOutlet weak var cookTimeTextField: UITextField!
    @IBOutlet weak var difficultyTextField: UITextField!
    @IBOutlet weak var serversTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ingridientsTextField: UITextView!
    @IBOutlet weak var instructionsTextField: UITextView!
    @IBOutlet weak var saveButton: CustomButton!
    
    let imagePicker = UIImagePickerController()
    let realm = try! Realm()
    //
    var recipe: Recipe!
    
    var foodCategory: FoodCategory?{
        didSet {
            loadNewRecipe()
        }
    }
    
    func loadNewRecipe() {
        print("add recipes for  \(String(describing: foodCategory))")
    }
 
    public override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imagePicker.delegate = self
        //
        setupEdit()
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
    //
    func setupEdit() {
        
        imageView.image = UIImage(data: recipe.imageName!)
        prepTimeTextField.text = recipe.preparation
        cookTimeTextField.text = recipe.timeToCook
        difficultyTextField.text = recipe.difficulty
        serversTextField.text = recipe.serves
        ingridientsTextField.text = recipe.ingridients
        instructionsTextField.text = recipe.instructions
        titleTextField.text = recipe.recipeTitle
        
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
                self.realm.add(editRecipe, update: .all) // update: .modified, sin la primary key da error
            }
        } catch {
            print(error.localizedDescription)
        }
        // Pasar informacion a la CategoryVC
        NotificationCenter.default.post(name: Notifications.newRecipe, object: nil, userInfo: nil)
    }
    
    func presentImagePicker(with sourceTyoe: UIImagePickerController.SourceType = .savedPhotosAlbum) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceTyoe
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: Any) {

        // estudiar inheritance
        // estudiar primary keys
        let newRecipe = Recipe()
        newRecipe.recipeTitle = titleTextField.text!
        newRecipe.preparation = prepTimeTextField.text!
        newRecipe.timeToCook = cookTimeTextField.text!
        newRecipe.difficulty = difficultyTextField.text!
        newRecipe.serves = serversTextField.text!
        newRecipe.ingridients = ingridientsTextField.text!
        newRecipe.instructions = instructionsTextField.text!
        newRecipe.imageName = imageView.image?.jpegData(compressionQuality: 0) // imagen reducida
        print("add \(newRecipe) to \(String(describing: self.foodCategory))")
        
        do {
            try realm.write {
                self.foodCategory?.recipes.append(newRecipe)
                self.realm.add(newRecipe, update: .all) // update: .modified, sin la primary key da error
            }
        } catch {
            print(error.localizedDescription)
        }
        // Pasar informacion a la CategoryVC
        NotificationCenter.default.post(name: Notifications.newRecipe, object: nil, userInfo: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddEditRecipeVC: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddEditRecipeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
