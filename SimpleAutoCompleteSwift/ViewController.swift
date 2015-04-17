//
//  ViewController.swift
//  SimpleAutoCompleteSwift
//
//  Created by Kirit Vaghela on 17/04/15.
//  Copyright (c) 2015 Kirit Vaghela. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    var items:NSMutableArray = []
    
    @IBOutlet var searchField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text.isEmpty {
            return true;
        }
        
        self.getAutoCompletePlaces(textField.text)
        
        return true

    }

    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        return true
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        var cell = tableView .dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = items[indexPath.row] as? String
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
    
        self.searchField.text = items[indexPath.row] as! String;
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
    func getAutoCompletePlaces(searchKey:NSString){
        
        var manager = AFHTTPRequestOperationManager()

        manager.requestSerializer.timeoutInterval = 5;
        
        var url:String = NSString(format: kGoogleAutoCompleteAPI, GoogleDirectionAPI,searchKey) as String
        
        url = url .stringByReplacingOccurrencesOfString(" ", withString: "+") as String

        println(url)

        var str:String = ""
        
        manager.GET(url,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
               
                str = "JSON:  \(responseObject.description)"
                println(str) //print the good thing
                
                var json:NSDictionary = responseObject as! NSDictionary;
                
                self.items.removeAllObjects()
                
                var places = AutomCompletePlaces.modelObjectWithDictionary(json as [NSObject : AnyObject]) as AutomCompletePlaces
                
                var predictions = places.predictions
                
                for predition in predictions as! [Predictions] {
                    
                    self.items.addObject(predition.predictionsDescription)
                }
                
                self.tableView.reloadData()
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                str = "Error: \(error.localizedDescription)"
        })
        
        
    }
}

