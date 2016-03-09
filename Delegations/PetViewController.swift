//
//  PetViewController.swift
//  Delegations
//
//  Created by Yariv Nissim on 3/2/16.
//  Copyright © 2016 Yariv Nissim. All rights reserved.
//

import UIKit
    
class PetViewController: UIViewController, PetContainer {
    @IBOutlet private weak var label: UILabel!
    
    var pet: Pet? {
        didSet { label?.text = pet?.name }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = pet?.name
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if var petContainer = segue.destinationViewController as? PetContainer {
            petContainer.pet = pet
        }
    }
    
    // Manually call segue
    @IBAction func getPetName(sender: UIButton) {
        performSegueWithIdentifier("PetSegue", sender: sender)
    }
}