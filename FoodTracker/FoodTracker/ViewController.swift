//
//  ViewController.swift
//  FoodTracker
//
//  Created by MacBook on 2018-02-05.
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
    
    //MARK: Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Intercept date picker events
        self.expiryDate.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
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
        let numberOfSecondsInDay: Double = 86400.0
        let diff = Double(sender.date.timeIntervalSince(Date()) / numberOfSecondsInDay)
        let percentage = Int(diff / 30.0 * 100.0)
        //debugPrint(sender.date)
        //debugPrint(diff)
        //debugPrint(percentage)
        self.expiryIndicator.indicatorPercentage = percentage
    }
    
}

