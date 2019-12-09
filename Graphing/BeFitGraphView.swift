//
//  BeFitGraphView.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/6/19.
//

import Foundation
import Cocoa
import WebKit

class BeFitGraphView: WebView {
    @IBOutlet var FoodListController: NSArrayController!
    
    deinit {
        FoodListController.removeObserver(self, forKeyPath: "arrangedObjects")
    }
    
    override func awakeFromNib() {
        
        drawGraphFromSelectedFoodList()
        FoodListController.addObserver(self, forKeyPath: "arrangedObjects", options: .new, context: nil)
        
    }
    
    private func getMagnitudeForGraph(_ averageForList: Double) -> Float {
        //Want 2X the average for all foods to be the 100 percentile mark which is a value of 100. So:
        //Magnitude = ( 100 * Average for list) / (Average For all * 2)
        //Magnitude = 50 * AverageForList / Average For All Foods.
        
        let returnValue = Float(averageForList)
        
        //Don't want a magnitude greater then 100
        //if ( ReturnValue > 100 )
        //{ ReturnValue = 100; }
        
        return returnValue
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath?.isEqual("arrangedObjects") ?? false {
            needsDisplay = true
        }
    }
    
    private func drawGraphFromSelectedFoodList() {
        let listOfFoods = FoodListController.arrangedObjects as! [Food]
        
        if listOfFoods.count < 8000 {
            var totalCaloriesForList: Int64 = 0
            var totalFatForList: Double = 0
            var totalProteinForList: Int64 = 0
            var totalCarbsForList: Int64 = 0
            var totalCalciumForList: Double = 0
            var totalIronForList: Double = 0
            var totalSugarForList: Int64 = 0
            var totalFiberForList: Int64 = 0
            var totalSodiumForList: Int64 = 0
            
            var numberOfFoods = 0
            
            for food in listOfFoods {
                totalCaloriesForList += food.caloriesLongValue
                totalFatForList += food.totalFatValueAsDouble
                totalProteinForList += food.proteinValueAsLong
                totalCarbsForList += food.carbsValueAsLong
                totalCalciumForList += food.calciumValueAsDouble
                totalIronForList += food.ironValueAsDouble
                totalSugarForList += food.sugarsValueAsLong
                totalFiberForList += food.dietaryFiberValueAsLong
                totalSodiumForList += food.sodiumValueAsLong
                numberOfFoods += 1
            }
            
            //Convert the Calories Square Data into an Integer
            let calInteger = Int(getMagnitudeForGraph(Double(totalCaloriesForList)))
            
            //Convert the Fat Square Data into an Integer
            let fatInteger = Int(getMagnitudeForGraph(totalFatForList))
            
            //Convert the Protien Square Data into an Integer
            let protInteger = Int(getMagnitudeForGraph(Double(totalProteinForList)))
            
            //Convert the Carbs Square Data into an Integer
            let carbInteger = Int(getMagnitudeForGraph(Double(totalCarbsForList)))
            
            //Convert the Calcium Square Data into an Integer
            //let calcInteger = Int(getMagnitudeForGraph(totalCalciumForList))
            
            //Convert the Iron Square Data into an Integer
            //let ironInteger = Int(getMagnitudeForGraph(totalIronForList))
            
            //Convert the Sugar Square Data into an Integer
            let sugarInteger = Int(getMagnitudeForGraph(Double(totalSugarForList)))
            
            //Convert the Fiber Square Data into an Integer
            let fiberInteger = Int(getMagnitudeForGraph(Double(totalFiberForList)))
            
            //Convert the Sodium Square Data into an Integer
            let sodiumInteger = Int(getMagnitudeForGraph(Double(totalSodiumForList)))
            
            let lbspref = UserDefaults.standard.string(forKey: "goal-name") ?? "0"
            
            //Set that Integer as a string
            let calString = String(format: "%.2d", calInteger)
            let fatString = String(format: "%.2d", fatInteger)
            let protString = String(format: "%.2d", protInteger)
            /*
             let carbString = String(format: "%.2d", carbInteger)
             let calcString = String(format: "%.2d", calcInteger)
             let ironString = String(format: "%.2d", ironInteger)
             let sugarString = String(format: "%.2d", sugarInteger)
             let fiberString = String(format: "%.2d", fiberInteger)
             let sodiumString = String(format: "%.2d", sodiumInteger)
             */
            
            //pass that to webview with javascript
            let javascriptString = String(format: "myFunction('%@','%@','%@','%d','%d','%d','%d','%@')", calString, fatString, protString, carbInteger, sugarInteger, fiberInteger, sodiumInteger, lbspref)
            print(javascriptString)
            
            
            stringByEvaluatingJavaScript(from: javascriptString)
            
            let response = stringByEvaluatingJavaScript(from: javascriptString)
            print("drawGraphFromSelectedFoodList:\n", response ?? "")
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
           drawGraphFromSelectedFoodList()
       }
    
    
}
