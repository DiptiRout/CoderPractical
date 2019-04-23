//
//  CodesViewController.swift
//  DecoderPractical
//
//  Created by Muvi on 07/04/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import UIKit


open class DropDownTF : UITextField{
    
    var arrow : Arrow!
    public let dropDown = DropDown()
    public var selectedIndex: Int?
    fileprivate  var dataArray = [String]()

   @IBInspectable  public var isSearchEnable: Bool = true {
        didSet{
            addGesture()
        }
    }
    
    @IBInspectable public var borderColor: UIColor =  UIColor.lightGray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable public var listHeight: CGFloat = 150{
        didSet {
            
        }
    }
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 5.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable public var arrowSize: CGFloat = 15 {
        didSet{
            let center =  arrow.superview!.center
            arrow.frame = CGRect(x: center.x - arrowSize/2, y: center.y - arrowSize/2, width: arrowSize, height: arrowSize)
        }
    }
    
    public var optionArray = [String]() {
        didSet{
            self.dataArray = self.optionArray
            setupDropDown()
        }
    }
    var searchText = String() {
        didSet{
            if searchText == "" {
                self.dataArray = self.optionArray
            }else{
                self.dataArray = optionArray.filter {
                    return $0.range(of: searchText, options: .caseInsensitive) != nil
                }
            }
            selectedIndex = nil
            self.dropDown.dataSource = dataArray
            self.dropDown.reloadAllComponents()
        }
    }
  
    // Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.delegate = self
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupUI()
        self.delegate = self
    }
    
    func setupUI () {
       let size = self.frame.height
        let rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: size, height: size))
        self.rightView = rightView
        self.rightViewMode = .always
        let arrowContainerView = UIView(frame: rightView.frame)
        self.rightView?.addSubview(arrowContainerView)
        let center = arrowContainerView.center
        arrow = Arrow(origin: CGPoint(x: center.x - arrowSize/2,y: center.y - arrowSize/2),size: arrowSize)
        arrowContainerView.addSubview(arrow)
        
        addGesture()
    }
    
    func setupDropDown() {
        
        dropDown.dataSource = dataArray
        dropDown.anchorView = self
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)

        let appearance = DropDown.appearance()
        
        appearance.cellHeight = 40
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        //        appearance.separatorColor = UIColor(white: 0.7, alpha: 0.8)
        //appearance.cornerRadius = 10
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.9
        appearance.shadowRadius = 20
        appearance.animationduration = 0.25
        appearance.textColor = .darkGray
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.text = item
            self.hideList()
            print("Selected item: \(item) at index: \(index)")
        }
        dropDown.cancelAction = { [unowned self] in
            self.hideList()
            print("Drop down dismissed")
        }
        
//        dropDown.willShowAction = { [unowned self] in
//            //self.showList()
//            print("Drop down will show")
//        }
        
    }
    
    fileprivate func addGesture (){
        let gesture =  UITapGestureRecognizer(target: self, action:  #selector(touchAction))
        if isSearchEnable{
            self.rightView?.addGestureRecognizer(gesture)
        }else{
            self.addGestureRecognizer(gesture)
        }
        
    }
    
    public func showList() {
        self.isSelected = true
        self.dropDown.show()

        UIView.animate(withDuration: 0.9,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
                       
                        self.arrow.position = .up
                        self.dropDown.reloadAllComponents()
        },
                       completion: { (finish) -> Void in

        })

    }

    
    public func hideList() {
        self.dropDown.hide()
        UIView.animate(withDuration: 0.9,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
                       
                        self.arrow.position = .down
        },
                       completion: { (didFinish) -> Void in
                        self.isSelected = false

        })
    }
    
    @objc public func touchAction() {

        isSelected ?  hideList() : showList()
    }
}

//MARK: UITextFieldDelegate
extension DropDownTF : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        superview?.endEditing(true)
        return false
    }
    public func  textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        //self.selectedIndex = nil
        //self.dataArray = self.optionArray
        touchAction()
    }
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return isSearchEnable
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string != "" {
            self.searchText = self.text! + string
        }else{
            let subText = self.text?.dropLast()
            self.searchText = String(subText!)
        }
        if !isSelected {
            showList()
        }
        return true;
    }
    
}

//MARK: Arrow
enum Position {
    case left
    case down
    case right
    case up
}

class Arrow: UIView {
    
    var position: Position = .down {
        didSet{
            switch position {
            case .left:
                self.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
                break
                
            case .down:
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi*2)
                break
                
            case .right:
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
                break
                
            case .up:
                self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                break
            }
        }
    }
    
    init(origin: CGPoint, size: CGFloat) {
        super.init(frame: CGRect(x: origin.x, y: origin.y, width: size, height: size))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        // Get size
        let size = self.layer.frame.width
        
        // Create path
        let bezierPath = UIBezierPath()
        
        // Draw points
        let qSize = size/4
        
        bezierPath.move(to: CGPoint(x: 0, y: qSize))
        bezierPath.addLine(to: CGPoint(x: size, y: qSize))
        bezierPath.addLine(to: CGPoint(x: size/2, y: qSize*3))
        bezierPath.addLine(to: CGPoint(x: 0, y: qSize))
        bezierPath.close()
        
        // Mask to path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        if #available(iOS 12.0, *) {
        self.layer.addSublayer (shapeLayer)
        } else {
         self.layer.mask = shapeLayer
        }
    }
}

