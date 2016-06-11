//
//  Serializable.swift
//  Koncierge
//
//  Created by Madan Dale on 6/11/16.
//  Copyright © 2016 KPIT Technologies Ltd. All rights reserved.
//

//Converts A class to a dictionary, used for serializing dictionaries to JSON
//
//Supported objects:
//- Serializable derived classes
//- Arrays of Serializable
//- NSData
//- String, Numeric, and all other NSJSONSerialization supported objects



import Foundation

class Serializable : NSObject{
    
    func toDictionary() -> NSDictionary {
        let aClass : AnyClass? = self.dynamicType
        var propertiesCount : CUnsignedInt = 0
        let propertiesInAClass : UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(aClass, &propertiesCount)
        let propertiesDictionary : NSMutableDictionary = NSMutableDictionary()
        
        for i in 0 ..< Int(propertiesCount) {
            let property = propertiesInAClass[i]
            let propName = NSString(CString: property_getName(property), encoding: NSUTF8StringEncoding)
            _ = property_getAttributes(property)
            let propValue : AnyObject! = self.valueForKey(propName as! String);
            
            if propValue is Serializable {
                propertiesDictionary.setValue((propValue as! Serializable).toDictionary(), forKey: propName as! String)
            } else if propValue is Array<AnyObject> {
                var subArray = Array<AnyObject> ()
                for item in (propValue as! Array<AnyObject> ) {
                    subArray.append(item.toDictionary())
                }
                propertiesDictionary.setValue(subArray, forKey: propName as! String)
            } else if propValue is NSData {
                let base64String = propValue?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
                propertiesDictionary.setValue(base64String, forKey: propName as! String)
            } else {
                propertiesDictionary.setValue(propValue, forKey: propName as! String)
            }
        }
        
        return propertiesDictionary
    }
    
    func toJson() -> NSData! {
        let dictionary = self.toDictionary()
        
        var jsonData = NSData()
        do {
            jsonData = try NSJSONSerialization.dataWithJSONObject(dictionary, options:.PrettyPrinted)
        } catch
            let error {
                print("json error: \(error)")
        }
        
        return jsonData ;
    }
    
    func toJsonString() -> NSString! {
        return NSString(data: self.toJson(), encoding: NSUTF8StringEncoding)
    }
    
}

