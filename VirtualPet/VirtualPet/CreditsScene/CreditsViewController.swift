//
//  CreditsViewController.swift
//  VirtualPet
//
//  Created by Ezequiel on 12/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

import UIKit

@objc class CreditsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var creditsData : NSArray
    @IBOutlet var creditsTable: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        creditsData = NSArray()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creditsTable.registerNib(UINib(nibName: "CreditsCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CreditsCell")
        
        var person1 = CreditPerson()
        person1.setData("Ezequiel Munz", role: "iOS Developer Pro")
        var person2 = CreditPerson()
        person2.setData("NicolasPalmieri", role: "iOS Master")
        
        creditsData = [person1, person2]
        
        self.creditsTable.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditsData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CreditsCell", forIndexPath: indexPath) as? CreditsCell
        
        if (cell == nil)
        {
            cell = CreditsCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "CreditsCell")
        }
        
        cell!.fillWithPerson(creditsData[indexPath.row] as CreditPerson)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Delightful People"
    }
    
}

