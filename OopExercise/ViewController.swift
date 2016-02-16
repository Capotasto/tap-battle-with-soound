//
//  ViewController.swift
//  OopExercise
//
//  Created by Norio Egi on 2/10/16.
//  Copyright © 2016 Capotasto. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player1: Player1!
    var player2: Player2!
    var attackSound: AVAudioPlayer!
    var bgmSound: AVAudioPlayer!
    var deadSound: AVAudioPlayer!
    
    @IBOutlet weak var p1Image: UIImageView!
    @IBOutlet weak var p2Image: UIImageView!
    @IBOutlet weak var hpP1: UILabel!
    @IBOutlet weak var hpP2: UILabel!
    @IBOutlet weak var p1AttackBtn: UIButton!
    @IBOutlet weak var p2AttackBtn: UIButton!
    
    @IBOutlet weak var screenLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player1 = Player1(hp: 120, attackPwr: 30, name: "Player1")
        hpP1.text = "\(String(player1.hp)) HP"
        
        player2 = Player2(hp: 150, attackPwr: 20, name: "Player2")
        hpP2.text = "\(String(player2.hp)) HP"
        
        //attack
        let attackPath = NSBundle.mainBundle().pathForResource("attack", ofType: "mp3")
        let attackUrl = NSURL(fileURLWithPath: attackPath!)
        do{
            try attackSound = AVAudioPlayer(contentsOfURL: attackUrl)
            attackSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
        //bgm
        let bgmPath = NSBundle.mainBundle().pathForResource("stage_bgm", ofType: "wav")
        let bgmUrl = NSURL(fileURLWithPath: bgmPath!)
        do{
            try bgmSound = AVAudioPlayer(contentsOfURL: bgmUrl)
            bgmSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
        //Dead
        let deadPath = NSBundle.mainBundle().pathForResource("dead", ofType: "wav")
        let deadUrl = NSURL(fileURLWithPath: deadPath!)
        do{
            try deadSound = AVAudioPlayer(contentsOfURL: deadUrl)
            deadSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
        bgmSound.numberOfLoops = -1
        bgmSound.play()

    }
    
    
    @IBAction func onAttackP1(sender: AnyObject) {
        attackSound.play()
        
        player2.sufferDamage(player1.attackPwr)
        if player2.isAlive {
            hpP2.text = "\(String(player2.hp)) HP"
            screenLbl.text = "\(player1.name) hit for \(player1.attackPwr) points!"
            p1AttackBtn.enabled = false
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("recoverAttack:"), userInfo: "p1", repeats: false)
            
        }else{
            deadSound.play()
            p2Image.hidden = true
            hpP2.hidden = true
            screenLbl.text = "\(player1.name) has won!"
            showRestartWindow();
        }
        
        
    }
    
    @IBAction func onAttackP2(sender: AnyObject) {
        attackSound.play()
        player1.sufferDamage(player2.attackPwr)
        if player1.isAlive {
            hpP1.text = "\(String(player1.hp)) HP"
            screenLbl.text = "\(player2.name) hit for \(player2.attackPwr) points!"
            p2AttackBtn.enabled = false
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("recoverAttack:"), userInfo: "p2", repeats: false)
            
        }else{
            deadSound.play()
            p1Image.hidden = true
            hpP1.hidden = true
            screenLbl.text = "\(player2.name) has won!"
            showRestartWindow();

        }
        
    }
    
    
    func recoverAttack(timer: NSTimer){
        let pNum = timer.userInfo as! String
        if pNum == "p1" {
            p1AttackBtn.enabled = true
        }else if pNum == "p2"{
            p2AttackBtn.enabled = true
        }
    }
    
    func showRestartWindow(){
        let alertController = UIAlertController(title: "Hey!", message: "Do you wanna play more?", preferredStyle: .Alert)
        let otherAction = UIAlertAction(title: "OK", style: .Default) {
            action in print("")
            self.player1 = Player1(hp: 120, attackPwr: 30, name: "Player1")
            self.hpP1.text = "\(String(self.player1.hp)) HP"
            self.hpP1.hidden = false
            self.p1Image.hidden = false
            
            self.player2 = Player2(hp: 150, attackPwr: 20, name: "Player2")
            self.hpP2.text = "\(String(self.player2.hp)) HP"
            self.hpP2.hidden = false
            self.p2Image.hidden = false
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .Cancel) {
            action in print("")
        }
        
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)    }
}

