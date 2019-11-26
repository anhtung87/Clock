//
//  ViewController.swift
//  Clock
//
//  Created by Hoang Tung on 11/20/19.
//  Copyright © 2019 Hoang Tung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var calendar = NSCalendar.current
    var currentDate = NSDate()
    
    var hourView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var minuteView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
    var secondView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    var hourNumber = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var minuteNumber = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var secondNumber = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    var timer: Timer!
    
    var hour: Int!
    var minute: Int!
    var second: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let hourView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: hourView.center.x, y: hourView.center.y), radius: hourView.bounds.width / 2 - 1, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.white.cgColor
        circleLayer.lineWidth = 2
        circleLayer.strokeColor = UIColor.systemBlue.cgColor
        
        hourView.layer.addSublayer(circleLayer)
        view.addSubview(hourView)
        hourView.center = view.center
//        hourView.center.y = view.center.y - 200
        
//        let minuteView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        let circleLayer2 = CAShapeLayer()
        let circlePath2 = UIBezierPath(arcCenter: CGPoint(x: minuteView.center.x, y: minuteView.center.y), radius: minuteView.bounds.width / 2 - 1, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        
        circleLayer2.path = circlePath2.cgPath
        circleLayer2.fillColor = UIColor.white.cgColor
        circleLayer2.lineWidth = 2
        circleLayer2.strokeColor = UIColor.systemGreen.cgColor
        
        minuteView.layer.addSublayer(circleLayer2)
        view.addSubview(minuteView)
        minuteView.center = view.center
//        minuteView.center.y = view.center.y - 135
        
//        let hourNumber = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        hourNumber.font = UIFont.systemFont(ofSize: 40)
        hourNumber.numberOfLines = 0
        hourNumber.text = "12"
        hourNumber.textColor = UIColor.systemBlue
        
        hourView.addSubview(hourNumber)
        hourNumber.textAlignment = .center
        hourNumber.center = hourView.center
        hourNumber.center.x = hourView.bounds.maxX / 2
        hourNumber.center.y = hourView.bounds.maxY / 2
//        view.addSubview(hourNumber)
        
//        let minuteNumber = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        minuteNumber.font = UIFont.systemFont(ofSize: 32)
        minuteNumber.numberOfLines = 0
        minuteNumber.text = "0"
        minuteNumber.textColor = UIColor.systemGreen
        
        minuteView.addSubview(minuteNumber)
        minuteNumber.textAlignment = .center
        minuteNumber.center = minuteView.center
        minuteNumber.center.x = minuteView.bounds.maxX / 2
        minuteNumber.center.y = minuteView.bounds.maxY / 2
        
        
//        let secondView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let circleLayer3 = CAShapeLayer()
        let circlePath3 = UIBezierPath(arcCenter: CGPoint(x: secondView.center.x, y: secondView.center.y), radius: secondView.bounds.width / 2 - 1, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        
        circleLayer3.path = circlePath3.cgPath
        circleLayer3.fillColor = UIColor.white.cgColor
        circleLayer3.lineWidth = 2
        circleLayer3.strokeColor = UIColor.systemOrange.cgColor
        
        secondView.layer.addSublayer(circleLayer3)
        view.addSubview(secondView)
        secondView.center = view.center
//        secondView.center.y = view.center.y - 85
        
//        let secondNumber = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        secondNumber.font = UIFont.systemFont(ofSize: 24)
        secondNumber.numberOfLines = 0
        secondNumber.text = "0"
        secondNumber.textColor = UIColor.systemOrange
        
        secondView.addSubview(secondNumber)
        secondNumber.textAlignment = .center
        secondNumber.center = secondView.center
        secondNumber.center.x = secondView.bounds.maxX / 2
        secondNumber.center.y = secondView.bounds.maxY / 2
        
//        secondView.layer.anchorPoint = CGPoint(x: -1, y: 0.5)
        setAnchorPoint(kimView: hourView, point: CGPoint(x: -1, y: 0.5))
        setAnchorPoint(kimView: minuteView, point: CGPoint(x: -0.6, y: 0.5))
        setAnchorPoint(kimView: secondView, point: CGPoint(x: -0.25, y: 0.5))
        
        runDongHo()
    }
    
    func getLocation(kimView: UIView, kimNumber: UILabel, alpha: CGFloat) {
        let r = kimView.bounds.size.height
        kimView.layer.cornerRadius = r
        
        kimView.transform = CGAffineTransform(rotationAngle: alpha)
        kimNumber.transform = CGAffineTransform(rotationAngle: -alpha)
    }
    
    func setAnchorPoint(kimView: UIView, point: CGPoint) {
        kimView.layer.anchorPoint = point
    }
    
    func setTimer() -> (hour:CGFloat, minute: CGFloat, second: CGFloat) {
        hour = calendar.component(.hour, from: currentDate as Date)
        minute = calendar.component(.minute, from: currentDate as Date)
        second = calendar.component(.second, from: currentDate as Date)
        
        hourNumber.text = String(hour)
        minuteNumber.text = String(minute)
        secondNumber.text = String(second)
        
        let hourInAboutSecond = hour * 3600 + minute * 60 + second
        let minuteInAboutSecond = minute * 60 + second
        
        let firstAlphaHour = CGFloat.pi * (2 * CGFloat(hourInAboutSecond)/12/60/60) - .pi / 2
        let firstAlphaMinute = CGFloat.pi * (2 * CGFloat(minuteInAboutSecond)/60/60) - .pi / 2
        let firstAlphaSecond = CGFloat.pi * (2 * CGFloat(second)/60) - .pi / 2
        return (firstAlphaHour, firstAlphaMinute, firstAlphaSecond)
    }
    
    @objc func runTimer() {
        let omegaGiay = CGAffineTransform(rotationAngle: CGFloat.pi * 2 / 60)
        let omegaPhut = CGAffineTransform(rotationAngle: CGFloat.pi * 2 / 60 / 60)
        let omegaGio = CGAffineTransform(rotationAngle: CGFloat.pi * 2 / 60 / 60 / 12)
        
        secondView.transform = secondView.transform.concatenating(omegaGiay)
        minuteView.transform = minuteView.transform.concatenating(omegaPhut)
        hourView.transform = hourView.transform.concatenating(omegaGio)
        
        secondNumber.transform = secondNumber.transform.concatenating(omegaGiay.inverted())
        minuteNumber.transform = minuteNumber.transform.concatenating(omegaPhut.inverted())
        hourNumber.transform = hourNumber.transform.concatenating(omegaGio.inverted())
        
        second = second < 59 ? second + 1 : 0
        minute = second == 0 ? minute + 1 : minute
        hour = minute == 60 ? hour + 1 : hour
        minute = minute == 60 ? 0 : minute
        hour = hour == 24 ? 0 : hour
        
        hourNumber.text = String(hour)
        minuteNumber.text = String(minute)
        secondNumber.text = String(second)
    }
    
    func runDongHo() {
        getLocation(kimView: hourView, kimNumber: hourNumber, alpha: setTimer().hour)
        getLocation(kimView: minuteView, kimNumber: minuteNumber, alpha: setTimer().minute)
        getLocation(kimView: secondView, kimNumber: secondNumber, alpha: setTimer().second)
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
    }
}

