//
//  GeneralPreferencesViewController.swift
//  BeFit
//
//  Created by Andrej Slegl on 11/6/19.
//

import Foundation
import Cocoa

class GeneralPreferencesViewController: NSViewController, MASPreferencesViewController {
    @IBOutlet var lbsName: NSTextField!
    @IBOutlet var feetname: NSTextField!
    @IBOutlet var inchname: NSTextField!
    @IBOutlet var kgname: NSTextField!
    @IBOutlet var cmname: NSTextField!
    @IBOutlet var agename: NSTextField!
    //@IBOutlet var gendername: NSTextField!
    @IBOutlet var prefslider: NSSlider!
    @IBOutlet var sliderValueLabel: NSTextField!
    @IBOutlet var gendercheck: NSPopUpButton!
    @IBOutlet var metricheck: NSButton!
    @IBOutlet var bmiValue: NSTextField!
    @IBOutlet var weightGoals: NSPopUpButton!
    @IBOutlet var lifeStyle: NSPopUpButton!
    @IBOutlet var Answer: NSTextField!
    @IBOutlet var Recomend: NSButton!
    @IBOutlet var formattedSliderValue: NSTextField!
    
    private var defaults: UserDefaults {
        return .standard
    }
    
    init() {
        super.init(nibName: "GeneralPreferencesView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        LBSChecker(nil)
        FeetChecker(nil)
        InchesChecker(nil)
        cmChecker(nil)
        kgChecker(nil)
        ageChecker(nil)
        bmiCalculator(nil)
        
        formattedSliderValue.isHidden = true
    }
    
    //MARK: - MASPreferencesViewController
    
    var viewIdentifier: String {
        return "GeneralPreferences"
    }
    
    var toolbarItemLabel: String? {
        return NSLocalizedString("General", comment: "Toolbar item name for the General preference pane")
    }
    
    var toolbarItemImage: NSImage? {
        return NSImage(named: "Cog")
    }
    
    //MARK: - Actions
    
    @IBAction func LBSChecker(_ sender: AnyObject?) {
        let lbspref = defaults.string(forKey: "lbs-name")
        
        if lbspref?.isEmpty ?? true {
            lbsName.stringValue = ""
        } else {
            lbsName.stringValue = lbspref ?? ""
        }
        
        // Set Format for LBS Field
        let lbsnameformatter = NumberFormatter()
        lbsnameformatter.format = "#,###;0;(#,##0)"
        lbsName.cell?.formatter = lbsnameformatter
    }
    
    @IBAction func FeetChecker(_ sender: AnyObject?) {
        let feetpref = defaults.string(forKey: "feet-name")
        // Read default prefrences for member name
        if feetpref?.isEmpty ?? true {
            feetname.stringValue = ""
        } else {
            feetname.stringValue = feetpref ?? ""
        }
        
        // Set Format for LBS Field
        let feetnameformatter = NumberFormatter()
        feetnameformatter.format = "#,###;0;(#,##0)"
        feetname.cell?.formatter = feetnameformatter
    }
    
    @IBAction func InchesChecker(_ sender: AnyObject?) {
        let inchpref = defaults.string(forKey: "inch-name")
        
        if inchpref?.isEmpty ?? true {
            inchname.stringValue = ""
        } else {
            inchname.stringValue = inchpref ?? ""
        }
        
        // Set Format for LBS Field
        let inchnameformatter = NumberFormatter()
        inchnameformatter.format = "#,###;0;(#,##0)"
        inchname.cell?.formatter = inchnameformatter
    }
    
    @IBAction func cmChecker(_ sender: AnyObject?) {
        let cmpref = defaults.string(forKey: "cm-name")
        
        if cmpref?.isEmpty ?? true {
            cmname.stringValue = ""
        } else {
            cmname.stringValue = cmpref ?? ""
        }
        
        // Set Format for LBS Field
        let cmnameformatter = NumberFormatter()
        cmnameformatter.format = "#,###;0;(#,##0)"
        cmname.cell?.formatter = cmnameformatter
    }
    
    @IBAction func kgChecker(_ sender: AnyObject?) {
        let kgpref = defaults.string(forKey: "kg-name")
        
        if kgpref?.isEmpty ?? true {
            kgname.stringValue = ""
        } else {
            kgname.stringValue = kgpref ?? ""
        }
        
        // Set Format for LBS Field
        let kgnameformatter = NumberFormatter()
        kgnameformatter.format = "#,###;0;(#,##0)"
        kgname.cell?.formatter = kgnameformatter
    }
    
    @IBAction func ageChecker(_ sender: AnyObject?) {
        let agepref = defaults.string(forKey: "age-name")
        
        if agepref?.isEmpty ?? true {
            agename.stringValue = ""
        } else {
            agename.stringValue = agepref ?? ""
        }
        
        // Set Format for LBS Field
        let agenameformatter = NumberFormatter()
        agenameformatter.format = "#,###;0;(#,##0)"
        agename.cell?.formatter = agenameformatter
    }
    
    @IBAction func bmiCalculator(_ sender: AnyObject?) {
        let agepref = defaults.string(forKey: "age-name")
        let cmpref = defaults.string(forKey: "cm-name")
        let kgpref = defaults.string(forKey: "kg-name")
        
        let inchpref = defaults.string(forKey: "inch-name")
        let feetpref = defaults.string(forKey: "feet-name")
        let lbspref = defaults.string(forKey: "lbs-name")
        
        //let metricpref = defaults.string(forKey: "self.checkBoxChecked")
        let metricvalue = defaults.string(forKey: "metric-name")
        let gendervalue = defaults.string(forKey: "gender-name")
        let lifestylevalue = defaults.string(forKey: "lifestyle-name")
        let goalsvalue = defaults.string(forKey: "goals-name")
        //let goalvalue = defaults.string(forKey: "goal-name")
        
        let feet = feetpref.flatMap { Int($0) } ?? 0
        let inches = inchpref.flatMap { Float($0) } ?? 0
        let totalWeight = lbspref.flatMap { Float($0) } ?? 0
        let totalCM = cmpref.flatMap { Float($0) } ?? 0
        let metercheck = metricvalue.flatMap { Float($0) } ?? 0
        let gender = gendervalue.flatMap { Float($0) } ?? 0
        let age = agepref.flatMap { Float($0) } ?? 0
        let lbs = lbspref.flatMap { Float($0) } ?? 0
        let lifestyles = lifestylevalue.flatMap { Float($0) } ?? 0
        let goals = goalsvalue.flatMap { Float($0) } ?? 0
        let inch = totalCM * 0.393701
        
        var totalKG: Float = 0
        var lbsconv: Float = 0
        var totalMeters: Float = 0
        var BMI: Float = 0
        var BMR: Float = 0
        var totalInches: Float = 0
        
        if metercheck == 1 {
            totalKG = kgpref.flatMap { Float($0) } ?? 0
            lbsconv = totalKG / 0.453592
            totalMeters = totalCM / 100
            BMI = totalKG / (totalMeters * totalMeters)
            
            let finishedBMI = String(format: "%.f", BMI)
            let bmiFloatValue = Float(finishedBMI) ?? 0
            let theRange: String
            
            if bmiFloatValue < 16.5 {
                theRange = "Underweight"
            } else if bmiFloatValue < 18.5 {
                theRange = "Underweight"
            } else if bmiFloatValue < 27 {
                theRange = "Normal"
            } else if bmiFloatValue < 30 {
                theRange = "Overweight";
            } else if bmiFloatValue < 35 {
                theRange = "Obese"
            } else {
                theRange = "Obese"
            }
            
            let finalBMIOutput = String(format: "BMI: %.f | Rating: %@", BMI, theRange)
            bmiValue.stringValue = finalBMIOutput
            
            defaults.set(finishedBMI, forKey: "bmi-value")
            
            // Calculate BMR
            if gender == 0 {
                BMR = 655 + (4.35 * lbsconv) + (4.7 * inch) - (4.7 * age)
            } else {
                BMR = 66 + (6.23 * lbsconv) + (12.7 * inch) - (6.8 * age)
            }
            
            print("BMR IS \(BMR)")
        } else {
            totalInches = (Float(feet) * 12) + inches
            BMI = totalWeight / (totalInches * totalInches) * 703
            let finishedBMI = String(format: "%.f", BMI)
            let bmiFloatValue = Float(finishedBMI) ?? 0
            let theRange: String
            
            print("Total Inches: \(totalInches)")
            
            if bmiFloatValue < 16.5 {
                theRange = "Underweight"
            } else if bmiFloatValue < 18.5 {
                theRange = "Underweight"
            } else if bmiFloatValue < 27 {
                theRange = "Normal"
            } else if bmiFloatValue < 30 {
                theRange = "Overweight"
            } else if bmiFloatValue < 35 {
                theRange = "Obese"
            } else {
                theRange = "Obese"
            }
            
            let finalBMIOutput = String(format: "BMI: %.f | Rating: %@", BMI, theRange)
            bmiValue.stringValue = finalBMIOutput
            
            defaults.set(finishedBMI, forKey: "bmi-value")
            
            // Calculate BMR
            if gender == 0 {
                BMR = 655 + (4.35 * lbs) + (4.7 * totalInches) - (4.7 * age)
                print("BMR LBS IS \(lbs)")
                print("BMR IN IS \(totalInches)")
            } else {
                BMR =  66 + (6.23 * lbs) + (12.7 * totalInches) - (6.8 * age)
            }
            
            print("BMR IS \(BMR)")
        }
        
        // Calculate Lifestyle
        let BMRLIFESTYLE: Float
        
        if lifestyles == 0 {
            BMRLIFESTYLE = BMR * 1.2
        } else if lifestyles == 1 {
            BMRLIFESTYLE = BMR * 1.375
        } else if lifestyles == 2 {
            BMRLIFESTYLE = BMR * 1.55
        } else if lifestyles == 3 {
            BMRLIFESTYLE = BMR * 1.725
        } else if lifestyles == 4 {
            BMRLIFESTYLE = BMR * 1.9
        } else {
            BMRLIFESTYLE = 0
        }
        
        // Calculate Goals
        let BMRGOALS: Float
        
        if goals == 0 {
            BMRGOALS = BMRLIFESTYLE - 500
        } else if goals == 1 {
            BMRGOALS = BMRLIFESTYLE + 1000
        } else if goals == 2 {
            BMRGOALS = BMRLIFESTYLE
        } else {
            BMRGOALS = BMRLIFESTYLE
        }
        
        Answer.floatValue = BMRGOALS
        
        // Set Format for Answer Field
        let answerformatter = NumberFormatter()
        answerformatter.format = "#,###;0;(#,##0)"
        Answer.cell?.formatter = answerformatter
        
        let recomendPref = Recomend.stringValue
        let rec = Float(recomendPref) ?? 0
        let slide = Answer.floatValue
        
        let mySlide = NSNumber(value: slide).stringValue
        formattedSliderValue.stringValue = mySlide
        
        let slidePrefSetter = formattedSliderValue.stringValue
        
        if rec == 0 {
            prefslider.isEnabled = true
        } else {
            defaults.set(slidePrefSetter, forKey: "goal-name")
            prefslider.stringValue = slidePrefSetter
            sliderValueLabel.stringValue = slidePrefSetter
            print("Recomended String Value is: \(slidePrefSetter)")
            print("Recomended Float Value is: \(slide)")
            print("Recommended Pref is: \(rec)")
            
            prefslider.isEnabled = false
        }
    }
    
    @IBAction func setMetric(_ sender: AnyObject?) {
        let metricPref = metricheck.stringValue
        
        if sender === metricheck {
            defaults.set(metricPref, forKey: "metric-name")
        } else {
            bmiCalculator(nil)
            print("Metric value is: \(metricPref)")
        }
    }
    
    @IBAction func setLifestyle(_ sender: AnyObject?) {
        let indexInteger = lifeStyle.indexOfSelectedItem
        let indexIntegerString = String(format: "%li", indexInteger)
        
        if sender === lifeStyle {
            defaults.set(indexIntegerString, forKey: "lifestyle-name")
            bmiCalculator(nil)
            print("Lifestyle is: \(indexInteger)")
        }
    }
    
    @IBAction func setRecomendation(_ sender: AnyObject?) {
        let recomendPref = Recomend.stringValue
        
        if sender === Recomend {
            defaults.set(recomendPref, forKey: "recommend-name")
            bmiCalculator(nil)
            print("Metric value is: \(recomendPref)")
        }
    }
    
    @IBAction func setGoals(_ sender: AnyObject?) {
        let indexInteger = weightGoals.indexOfSelectedItem
        let indexIntegerString = String(format: "%li", indexInteger)
        
        if sender === weightGoals {
            defaults.set(indexIntegerString, forKey: "goals-name")
            bmiCalculator(nil)
            print("Goals are: \(indexInteger)")
        }
    }
    
    @IBAction func setGender(_ sender: AnyObject?) {
        let indexInteger = gendercheck.indexOfSelectedItem
        let indexIntegerString = String(format: "%li", indexInteger)
        
        if sender === gendercheck {
            defaults.set(indexIntegerString, forKey: "gender-name")
            bmiCalculator(nil)
            print("Gender is: \(indexInteger)")
        }
    }
    
    @IBAction func setWeightLBS(_ sender: AnyObject?) {
        // Set default prefrences for Member Name
        let num1 = lbsName.floatValue
        let num2 = lbsName.stringValue
        let lbsnamed = lbsName.stringValue
        
        if num1 <= 0 {
            if num2.isEmpty {
                if sender === lbsName {
                    defaults.set(lbsnamed, forKey: "lbs-name")
                    bmiCalculator(nil)
                    print("LBS value is: \(lbsnamed)")
                }
            } else {
                let alert = NSAlert()
                alert.messageText = "Please enter a value between 0 and 350 lbs."
                alert.runModal()
            }
        } else if num1 > 350 {
            let alert = NSAlert()
            alert.messageText = "Please enter a value between 0 and 350 lbs."
            alert.runModal()
        } else {
            if sender === lbsName {
                defaults.set(lbsnamed, forKey: "lbs-name")
                bmiCalculator(nil)
                print("LBS value is: \(lbsnamed)")
            }
        }
    }
    
    @IBAction func setFeet(_ sender: AnyObject?) {
        // Set default prefrences for Member Name
        let num2 = feetname.floatValue
        let num3 = feetname.stringValue
        
        let feetnamed = feetname.stringValue
        
        if num2 <= 0 {
            if num3.isEmpty {
                if sender === feetname {
                    defaults.set(feetnamed, forKey: "feet-name")
                    bmiCalculator(nil)
                    print("Feet value is: \(feetnamed)")
                }
            } else {
                let alert = NSAlert()
                alert.messageText = "Please enter a value between 0 and 10 lbs."
                alert.runModal()
            }
        } else if num2 > 10 {
            let alert = NSAlert()
            alert.messageText = "Please enter a value between 0 and 10 lbs."
            alert.runModal()
        } else {
            if sender === feetname {
                defaults.set(feetnamed, forKey: "feet-name")
                bmiCalculator(nil)
                print("Feet value is: \(feetnamed)")
            }
        }
    }
    
    @IBAction func setInches(_ sender: AnyObject?) {
        // Set default prefrences for Member Name
        let num3 = inchname.floatValue
        let num4 = inchname.stringValue
        
        let inchnamed = inchname.stringValue
        
        if num3 <= 0 {
            if num4.isEmpty {
                if sender === inchname {
                    defaults.set(inchnamed, forKey: "inch-name")
                    bmiCalculator(nil)
                    print("Inch value is: \(inchnamed)")
                }
            } else {
                let alert = NSAlert()
                alert.messageText = "Please enter a value between 0 and 12 lbs."
                alert.runModal()
            }
        } else if num3 > 12 {
            let alert = NSAlert()
            alert.messageText = "Please enter a value between 0 and 12 lbs."
            alert.runModal()
        } else {
            if sender === inchname {
                defaults.set(inchnamed, forKey: "inch-name")
                bmiCalculator(nil)
                print("Inch value is: \(inchnamed)")
            }
        }
    }
    
    @IBAction func setCM(_ sender: AnyObject?) {
        // Set default prefrences for Member Name
        let num3 = cmname.floatValue
        let num4 = cmname.stringValue
        
        let cmnamed = cmname.stringValue
        
        if num3 <= 0 {
            if num4.isEmpty {
                if sender === cmname {
                    defaults.set(cmnamed, forKey: "cm-name")
                    bmiCalculator(nil)
                    print("CM value is: \(cmnamed)")
                }
            } else {
                let alert = NSAlert()
                alert.messageText = "Please enter a value between 0 and 300 cm."
                alert.runModal()
            }
        } else if num3 > 300 {
            let alert = NSAlert()
            alert.messageText = "Please enter a value between 0 and 300 cm."
            alert.runModal()
        } else {
            if sender === cmname {
                defaults.set(cmnamed, forKey: "cm-name")
                bmiCalculator(nil)
                print("CM value is: \(cmnamed)")
            }
        }
    }
    
    @IBAction func setKG(_ sender: AnyObject?) {
        // Set default prefrences for Member Name
        
        let num3 = kgname.floatValue
        let num4 = kgname.stringValue
        
        let kgnamed = kgname.stringValue
        
        if num3 <= 0 {
            if num4.isEmpty {
                if sender === kgname {
                    defaults.set(kgnamed, forKey: "kg-name")
                    bmiCalculator(nil)
                    print("KG value is: \(kgnamed)")
                }
            } else {
                let alert = NSAlert()
                alert.messageText = "Please enter a value between 0 and 300 cm."
                alert.runModal()
            }
        } else if num3 > 300 {
            let alert = NSAlert()
            alert.messageText = "Please enter a value between 0 and 300 cm."
            alert.runModal()
        } else {
            if sender === kgname {
                defaults.set(kgnamed, forKey: "kg-name")
                bmiCalculator(nil)
                print("KG value is: \(kgnamed)")
            }
        }
    }
    
    @IBAction func setAge(_ sender: AnyObject?) {
        // Set default preferences for Member Name
        let num3 = agename.floatValue
        let num4 = agename.stringValue
        
        let agenamed = agename.stringValue
        
        if num3 <= 0 {
            if num4.isEmpty {
                if sender === agename {
                    defaults.set(agenamed, forKey: "age-name")
                    bmiCalculator(nil)
                    print("Age value is: \(agenamed)")
                }
            } else {
                let alert = NSAlert()
                alert.messageText = "Please enter a value between 0 and 100."
                alert.runModal()
            }
        } else if num3 > 100 {
            let alert = NSAlert()
            alert.messageText = "Please enter a value between 0 and 100."
            alert.runModal()
        } else {
            if sender === agename {
                defaults.set(agenamed, forKey: "age-name")
                bmiCalculator(nil)
                print("Age value is: \(agenamed)")
            }
        }
    }
}

