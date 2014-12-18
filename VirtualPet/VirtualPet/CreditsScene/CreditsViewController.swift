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
        var person3 = CreditPerson()
        person3.setData("        developTeam>", role: "")
        var person4 = CreditPerson()
        person4.setData("", role: "")
        var person5 = CreditPerson()
        person5.setData("Max Power", role: "Steve Jobs Teacher")
        var person6 = CreditPerson()
        person6.setData("Nicholas Palmieri", role: "iOS Ballskicker")
        var person7 = CreditPerson()
        person7.setData("Arnold Scwharzenegger", role: "Terminator")
        var person8 = CreditPerson()
        person8.setData("Pechugas Laru", role: "Sucker")
        var person9 = CreditPerson()
        person9.setData("Pepita la Pistolera", role: "Gunner")
        var person10 = CreditPerson()
        person10.setData("Yoga", role: "El pibe del Cisne")
        
        creditsData = [person10, person9, person8, person7, person6, person5, person4, person3, person2, person1]
        
        self.creditsTable.reloadData()
        // Do any additional setup after loading the view.
        
        self.animationCredits()
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
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "developTeam"
//    }
    
    func animationCredits ()
    {
        let duration = 2.0
        let del = 0.0
        let opt = UIViewAnimationOptions.TransitionFlipFromTop
        UIView.animateWithDuration (duration, delay: del, options: opt, animations:{
            self.creditsTable.setContentOffset(CGPointMake(0, 800), animated: false)}, completion: {(bool finished) in})
    }
    
}

