//
//  ViewController.swift
//  Paint
//
//  Created by Ope on 2/5/17.
//  Copyright © 2017 Ope. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var lastPoint:CGPoint = CGPoint.zero
    var color:UIColor = .black
    
    @IBOutlet weak var mainDisp: UIImageView!
    @IBOutlet weak var topTempDisp: UIImageView!

    @IBAction func clearButton(_ sender: Any) {
        mainDisp.image = nil
        //topTempDisp.image = nil
    }
    @IBAction func blackButton(_ sender: Any) {
        color = UIColor.black
    }
    @IBAction func grayButton(_ sender: Any) {
        color = UIColor.gray
    }
    @IBAction func whiteButton(_ sender: Any) {
        color = UIColor.white
    }
    @IBAction func redButton(_ sender: Any) {
        color = UIColor.red
    }
    @IBAction func orangeButton(_ sender: Any) {
        color = UIColor.orange
    }
    @IBAction func yellowButton(_ sender: Any) {
        color = UIColor.yellow
    }
    @IBAction func greenButton(_ sender: Any) {
        color = UIColor.green
    }
    @IBAction func blueButton(_ sender: Any) {
        color = UIColor.blue
    }
    @IBAction func purpleButton(_ sender: Any) {
        color = UIColor.purple
    }
    @IBAction func pinkButton(_ sender: Any) {
        color = UIColor(red: 0.9843, green: 0.1882, blue: 1, alpha: 1.0) // #fb30ff 
    }
    @IBAction func shareButton(_ sender: Any) {
        //Get image
        UIGraphicsBeginImageContext(mainDisp.frame.size)
        mainDisp.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //ShareSheet
        let shareSheet = UIActivityViewController(activityItems: [image as Any], applicationActivities: nil)
        self.present(shareSheet,animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            lastPoint = touch.location(in:view)
            print("Start point ",lastPoint)
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currPoint:CGPoint = touch.location(in: view)
            miniDraw(from: lastPoint, to: currPoint)
            lastPoint = touch.location(in:view)
        }
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currPoint:CGPoint = touch.location(in: view)
            miniDraw(from: lastPoint, to: currPoint)
            print("Last point  ", currPoint)
        }
        
        UIGraphicsBeginImageContext(view.frame.size)
        mainDisp.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        mainDisp.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        super.touchesEnded(touches, with: event)
    }
    
    //Func to draw miniscule lines between 2 given points.
    func miniDraw(from: CGPoint, to: CGPoint){
        UIGraphicsBeginImageContext(view.frame.size)
        let currentContext = UIGraphicsGetCurrentContext()
        mainDisp.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        currentContext?.setStrokeColor(color.cgColor)
        currentContext?.setLineWidth(5.0)
        currentContext?.move(to: from)
        currentContext?.addLine(to: to)
        currentContext?.strokePath()
        
        mainDisp.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

