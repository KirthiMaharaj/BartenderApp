//
//  BartenderDrinks+CoreDataProperties.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/08/20.
//
//

import Foundation
import CoreData


extension BartenderDrinks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BartenderDrinks> {
        return NSFetchRequest<BartenderDrinks>(entityName: "BartenderDrinks")
    }

    @NSManaged public var alcoholic: String?
    @NSManaged public var category: String?
    @NSManaged public var drinkId: String?
    @NSManaged public var images: String?
    @NSManaged public var ingredient1: String?
    @NSManaged public var ingredient2: String?
    @NSManaged public var ingredient3: String?
    @NSManaged public var ingredient4: String?
    @NSManaged public var ingredient5: String?
    @NSManaged public var ingredient6: String?
    @NSManaged public var ingredient7: String?
    @NSManaged public var instructions: String?
    @NSManaged public var name: String?

}

extension BartenderDrinks : Identifiable {

}
