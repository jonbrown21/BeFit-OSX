//
//  FoodList+UI.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/4/19.
//

import Foundation
import Cocoa

extension FoodList {
    @objc var OrderIndexLongValue: Int64 {
        return orderIndex?.int64Value ?? 0
    }
    
    @objc var OrderIndexStringValue: String {
        return orderIndex?.description ?? "0"
    }
    
    @objc var nameValue: String {
        return name ?? ""
    }
    
    @objc var badgeString: String? {
        var numOfItems: Int64 = 0
        for food in (foods?.allObjects as? [Food]) ?? [] {
            numOfItems += food.quantityLongValue
        }
        
        if numOfItems == 0 {
            return nil
        } else {
            return String(format: "%ld", numOfItems)
        }
    }
    
    @objc var numberOfCaloriesString: String {
        var totalCalories: Int64 = 0
        for food in (foods?.allObjects as? [Food]) ?? [] {
            totalCalories += food.caloriesLongValue
        }
        
        return String(format: "%qi Total Calories", totalCalories)
    }
    
    @objc var FoodListDisplayImage: NSImage? {
        let imageToReturn: NSImage?
        
        switch orderIndex?.intValue ?? 0 {
        case 0:
            imageToReturn = NSImage(named: "Library")
        case 1:
            imageToReturn = NSImage(named: "Library")
        default:
            imageToReturn = NSImage(named: "Document")
        }
        
        imageToReturn?.isTemplate = true
        return imageToReturn
    }
    
    @objc var canEditName: Bool {
        switch orderIndex?.intValue ?? 0 {
        case 0, 1:
            return false
        default:
            return true
        }
    }
    
    @objc var hideShowButton: Bool {
        switch orderIndex?.intValue ?? 0 {
        case 0:
            return false
        case 1:
            return true
        default:
            return true
        }
    }
    
    @objc var CaloriesMagnitudeForGraph: Float {
        var totalCaloriesForList: Double = 0
        if orderIndex?.intValue != 0 {
            for food in (foods?.allObjects as? [Food]) ?? [] {
                totalCaloriesForList += Double(food.caloriesLongValue)
            }
        }
        
        return Float(totalCaloriesForList / 10)
    }
    
    @objc var numberOfItemsWithCaloriesString: String {
        if OrderIndexLongValue != 0 {
            return String(format: "%@, %@", numberOfItemsString, numberOfCaloriesString)
        } else {
            return numberOfItemsString
        }
    }
    
    @objc var numberOfItemsString: String {
        #if OLDWAYOFDOINGIT
        /* this just calculates the number of foods in the list, not the actual quantities of the foods */
        if foods?.count ?? 0 == 1 {
            return "BeFit — 1 Item"
        } else {
            return String(format: "%d Items", foods?.count ?? 0)
        }
        #endif
        
        var numOfItems: Int64 = 0
        for food in (foods?.allObjects as? [Food]) ?? [] {
            numOfItems += food.quantityLongValue
        }
        
        let character = 0x2014 // Character(Unicode.Scalar(0x2014))
        
        switch numOfItems {
        case 1:
            return String(format: "%@ %C %ld Item", name ?? "", character, numOfItems)
        case 54134, 54135, 54148:
            return String(format: "%@ %C %ld Items", name ?? "", character, numOfItems)
        case 7146:
            return String(format: "%@ %C %ld Items", name ?? "", character, numOfItems)
        default:
            return String(format: "%@ %C %ld Items", name ?? "", character, numOfItems)
        }
    }
    
    func setNameValue(_ nameToUse: String) {
        name = nameToUse
    }
}
