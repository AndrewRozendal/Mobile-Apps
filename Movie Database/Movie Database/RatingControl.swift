//
//  RatingControl.swift
//  Movie Database
//
//  Created by MacBook on 2018-03-01.
//  Copyright © 2018 Camosun. All rights reserved.
//
//  See https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/ImplementingACustomControl.html#//apple_ref/doc/uid/TP40015214-CH19-SW1 for implementation details
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    private var ratingImages = [UIImageView]()
    
    // Holds whether the RatingControl is interactive or just informative
    // Defaults to informative
    var desiredFunctionality = Functionality.Info{
        didSet{
            setupIcons()
        }
    }
    var currentMovie: Movie? = nil
    
    var rating = 0 {
        didSet {
            updateIconStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupIcons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupIcons()
        }
    }
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupIcons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupIcons()
    }
    
    private func setupIcons() {
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // clear any existing images
        for image in ratingImages {
            removeArrangedSubview(image)
            image.removeFromSuperview()
        }
        ratingImages.removeAll()
        
        // Load Icon Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        if desiredFunctionality == Functionality.Clickable {
            // Add new buttons
            for _ in 0..<starCount {
                // Create the button
                let button = UIButton()
                // Set the button images
                button.setImage(emptyStar, for: .normal)
                button.setImage(filledStar, for: .selected)
                button.setImage(highlightedStar, for: .highlighted)
                button.setImage(highlightedStar, for: [.highlighted, .selected])
                
                // Add constraints
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
                button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
                
                // Setup the button action
                button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
                
                // Add the button to the stack
                addArrangedSubview(button)
                
                // Add the new button to the rating button array
                ratingButtons.append(button)
            }
            updateIconStates()
        } else if desiredFunctionality == Functionality.Info{
            for i in 0..<starCount {
                // Create the button
                let image = UIImageView()
                // Set the button images
                if i < rating {
                    image.image = filledStar
                } else {
                    image.image = emptyStar
                }
                
                // Add constraints
                image.translatesAutoresizingMaskIntoConstraints = false
                image.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
                image.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
                
                // Add the button to the stack
                addArrangedSubview(image)
                
                // Add the new button to the rating images array
                ratingImages.append(image)
            }
        }
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
            updateDataModel()
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
            updateDataModel()
        }
    }
    
    private func updateIconStates() {
        if desiredFunctionality == Functionality.Clickable{
            for (index, button) in ratingButtons.enumerated() {
                // If the index of a button is less than the rating, that button should be selected.
                button.isSelected = index < rating
            }
        } else if desiredFunctionality == Functionality.Info {
            // For UIImages we need to reset them, can't update like buttons, so just call setup
            setupIcons()
        }
    }
    
    private func updateDataModel(){
        guard let m = currentMovie else {
            fatalError("Tried to update a Movie without an instance")
        }
        m.rating = rating
    }
}
