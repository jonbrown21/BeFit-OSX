//
//  FoodList+CoreDataProperties.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/4/19.
//
//

import Foundation
import CoreData


extension FoodList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodList> {
        return NSFetchRequest<FoodList>(entityName: "FoodListObject")
    }

    @NSManaged public var name: String?
    @NSManaged public var orderIndex: NSNumber?
    @NSManaged public var foods: NSSet?

}

// MARK: Generated accessors for foods
extension FoodList {

    @objc(addFoodsObject:)
    @NSManaged public func addToFoods(_ value: Food)

    @objc(removeFoodsObject:)
    @NSManaged public func removeFromFoods(_ value: Food)

    @objc(addFoods:)
    @NSManaged public func addToFoods(_ values: NSSet)

    @objc(removeFoods:)
    @NSManaged public func removeFromFoods(_ values: NSSet)

}
