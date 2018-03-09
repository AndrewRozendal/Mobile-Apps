//
//  RatingControl.swift
//  Movie Database
//
//  Created by Andrew Rozendal 08 March 2018
//  Copyright © 2018 Camosun. All rights reserved.
//
//  See https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/ImplementingACustomControl.html#//apple_ref/doc/uid/TP40015214-CH19-SW1 for implementation details
//

import UIKit

// UIStackView that enables user to view the current rating of a movie and update it
@IBDesignable class RatingControl: UIStackView {
    //MARK: Properties
    
    // Holds all rating buttons in the Rating Control
    private var ratingButtons = [UIButton]()
    // Holds all rating images in the Rating Control
    private var ratingImages = [UIImageView]()
    // Used to enable saving in parent
    var parentViewController: MovieDetailsViewController?
    
    // Holds whether the RatingControl is interactive or just informative
    // Defaults to informative
    // When changed, rebuild the rating icons
    var desiredFunctionality = Functionality.Info{
        didSet{
            setupIcons()
        }
    }
    // The current movie
    var currentMovie: Movie? = nil
    
    // The rating for the current movie.
    // Rebuild the rating icons whenever this is changed
    var rating = 0 {
        didSet {
            updateIconStates()
        }
    }
    
    //Support editing in XCode with IBInspectable
    // Set starSize and whenever changed rebuild the icons
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupIcons()
        }
    }
    
    // Set number of stars and rebuild the icons
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupIcons()
        }
    }
    
    
    // MARK: Initializers
    // For initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupIcons()
    }
    
    // For loading
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupIcons()
    }
    
    // MARK: Actions
    //Rebuilds all icons/buttons in the rating control
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
                
                // Set the button images for each context
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
    
    // When a rating button is tapped, this function updates the rating control to reflect the change
    // and asks its parent to save the change.
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            // Could not find the button in our rating buttons
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
    
    // Sets the state of each button to reflect the current rating
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
    
    // Update the rating in the Movie object stored in the movieCollection and then ask
    // parent view to save the collection
    private func updateDataModel(){
        guard let m = currentMovie else {
            // we dont have a movie object
            fatalError("Tried to update a Movie without an instance")
        }
        m.rating = rating
        guard let parent = self.parentViewController else {
            // Parent property was not set properly by parent
            // This likely means we have a parent that is not a DetailViewController
            fatalError("Rating control tried to save with a parent controller that did not support it")
        }
        parent.save()
    }
}
