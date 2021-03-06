//
//  ViewController.swift
//  Delegations
//
//  Created by Yariv Nissim on 3/2/16.
//  Copyright © 2016 Yariv Nissim. All rights reserved.
//

import UIKit

class ShelterViewController: UIViewController, PetContainer {
    @IBOutlet weak var tableView: UITableView!

    var pet: Pet? {
        didSet { title = pet?.name }
    }
    
    lazy var shelter: Shelter = { [weak self] in
        var shelter = Shelter()
        shelter.pets = [Pet(name: "Cat"), Pet(name: "Dog"), Pet(name: "Kengoroo")]
        return shelter
    }()
    
    var observer: AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shelter.didChangePets = didChangePets
        shelter.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        observer = NSNotificationCenter.defaultCenter().addObserverForName(ShelterDidChangePets, object: nil, queue: nil) { _ in
            print("something happened")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let observer = observer {
            NSNotificationCenter.defaultCenter().removeObserver(observer)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell
        , let indexPath = tableView.indexPathForCell(cell)
        , var petContainer = segue.destinationViewController as? PetContainer {
            let pet = shelter.pets[indexPath.row]
            petContainer.pet = pet
        }
    }
    
    // Unwind Segue
    @IBAction func performActionOnPet(segue: UIStoryboardSegue) {
        print("perform action on pet")
    }
}

extension ShelterViewController: ShelterDelegate {
    func didChangePets(pets: [Pet]) {
        print("Pets updated: \(pets)")
    }
}

extension ShelterViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shelter.pets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let pet = shelter.pets[indexPath.row]
        cell.textLabel?.text = pet.name
        
        return cell
    }
}

extension ShelterViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let pet = shelter.pets[indexPath.row]
        print("\(pet.name)")
    }
}