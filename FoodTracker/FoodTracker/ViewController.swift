//
//  ViewController.swift
//  FoodTracker
//
//  Created by Andrew Rozendal on 2018-02-05.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit
import os

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    // TODO: What is this? The main image?????
    @IBOutlet weak var photoImageView: UIImageView!
    // Date Picker for selecting expiry date
    @IBOutlet weak var expiryDate: UIDatePicker!
    // TODO: Better description.  Expiry Indicator that displays percentage status
    @IBOutlet weak var expiryIndicator: ExpiryIndicator!
    // Food item ? WHY IS THIS HERE?
    var item: FoodItem?
    
    //Buttons
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //MARK: Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Intercept date picker events
        self.expiryDate.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        if let item = item {
            // Only entered if item was set by the table view controller on edit
            photoImageView.image = item.image
            expiryDate.date = item.expiryDate
            expiryIndicator.setIndicatorPercentage(expDate: item.expiryDate)
        } else {
            expiryIndicator.indicatorPercentage = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Dismiss the picker if the user cancels a photo selection
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Pick original image user selects, not edited one
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            //TODO: Why would this throw?
            os_log("Missing image in %@", log: OSLog.default, type: .debug, info)
            return
        }
        
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    // Preparation for saving an item
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        
        item = FoodItem(image: photoImageView.image ?? #imageLiteral(resourceName: "defaultImage"), expiryDate: expiryDate.date)
    }
    
    //MARK: Actions
    
    // Present an image picker to allow user to select image from their photo library
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    // Handle date changed on expiryDate date picker and update percentage on expiryIndicator
    @objc func dateChanged(_ sender: UIDatePicker){
        self.expiryIndicator.setIndicatorPercentage(expDate: sender.date)
    }
    
    // Cancel Button
    @IBAction func cancel(_ sender: Any) {
        if presentingViewController is UINavigationController{
            // Add
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            // Edit
            owningNavigationController.popViewController(animated: true)
        }
    }
    
    
}

