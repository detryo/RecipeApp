//
//  NewCategorySelectionVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 02/06/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import RealmSwift

public class AddRecipeVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prepTimeTextField: UITextField!
    @IBOutlet weak var cookTimeTextField: UITextField!
    @IBOutlet weak var difficultyTextField: UITextField!
    @IBOutlet weak var serversTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ingridientsTextField: UITextView!
    @IBOutlet weak var instructionsTextField: UITextView!
    @IBOutlet weak var createNewRecipe: CustomButton!
    @IBOutlet weak var cancelButton: CustomButton!
    
    let imagePicker = UIImagePickerController()
    let realm = try! Realm()
    
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
    
    func setUpButton() {
        cancelButton.makeBacgroundWhiteWithBorder()
    }
    
    @IBAction func saveNewRecipePressed(_ sender: Any) {

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
                self.realm.add(newRecipe)
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

extension AddRecipeVC: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddRecipeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
