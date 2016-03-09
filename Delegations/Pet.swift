//
//  Pet.swift
//  Delegations
//
//  Created by Yariv Nissim on 3/2/16.
//  Copyright © 2016 Yariv Nissim. All rights reserved.
//

import Foundation

public protocol PetContainer {
    var pet: Pet? { get set }
}

public let ShelterDidChangePets = "Shelter.didChangePets"

protocol ShelterDelegate: class {
    func didChangePets(pets: [Pet])
}

public struct Shelter {
    public var pets = [Pet]() {
        didSet {
            delegate?.didChangePets(pets)
            didChangePets?(pets: pets)
            NSNotificationCenter.defaultCenter().postNotificationName(ShelterDidChangePets, object: nil)
        }
    }
    
    // Delegates
    
    weak var delegate: ShelterDelegate?
    
    // Closures
    
    var didChangePets: ((pets: [Pet]) -> Void)?
}

public struct Pet {
    public let name: String
}