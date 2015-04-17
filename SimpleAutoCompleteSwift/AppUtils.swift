//
//  AppUtils.swift
//  ValuePad
//
//  Created by Kirit on 12/04/15.
//  Copyright (c) 2015 Kirit Vaghela. All rights reserved.
//

import Foundation


class AppUtils{
    
    class func jsonFromResponse(responseObject: AnyObject!)->NSString{
        
        var localError: NSError?
        
        var jsonData = NSJSONSerialization.dataWithJSONObject(responseObject, options: NSJSONWritingOptions.PrettyPrinted, error: &localError)
        
        var jsonString = NSString(data: jsonData!, encoding: NSUTF8StringEncoding)
        
        if jsonString == nil {
            println("Got and error: \(localError)")
        }else{
            return jsonString!
        }
        
        return ""
    }
    
    class func isEmpty(string:NSString)->Bool {

        string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        if string.isEqualToString("") {
            return true;
        }
        return false;
    }
}

