//
//  NewCategorySelectionVC.swift
//  Recipe
//
//  Created by Cristian Sedano Arenas on 02/06/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import RealmSwift

public class NewCategorySelectionVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: CustomTextField!
    
    @IBOutlet var colorSlider: [UISlider]!
    @IBOutlet var colorLabel: [UILabel]!
    
    @IBOutlet weak var hexLabel: UILabel!
    
    let imagePicker = UIImagePickerController()
    let colorKeys = ["R", "G", "B", "A"]
    let realm = try! Realm()
    var foodCategory: FoodCategory?{
        didSet {
            loadNotes()
        }
    }
    
    func loadNotes() {
        print("add recipes for  \(String(describing: foodCategory))")
    }
 
    public override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        repaintBackbround()
        imagePicker.delegate = self
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
    
    func repaintBackbround() {
        let backColor = UIColor(red: CGFloat(colorSlider[0].value), green: CGFloat(colorSlider[1].value), blue: CGFloat(colorSlider[2].value), alpha: CGFloat(colorSlider[3].value))
        
        self.view.backgroundColor = backColor
        self.hexLabel.text = backColor.toHex
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        colorLabel[sender.tag].text = "\(colorKeys[sender.tag]): \(lroundf(sender.value*255.0))"
        repaintBackbround()
    }
    
    @IBAction func savePressed(_ sender: Any) {

        let newCategory = Recipe()
        newCategory.title = textField.text!
        newCategory.colorHex = UIColor(hex: hexLabel.text!)?.toHex
        newCategory.imageName = imageView.image?.jpegData(compressionQuality: 0) // imagen reducida
        print("add \(newCategory) to \(String(describing: self.foodCategory))")
        
        do {
            
            try realm.write {
                self.foodCategory?.categorySelection.append(newCategory)
                realm.add(newCategory)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
        // Pasar informacion a la CategoryVC
        NotificationCenter.default.post(name: Notifications.newCategorySelection, object: nil, userInfo: nil)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension NewCategorySelectionVC: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NewCategorySelectionVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
