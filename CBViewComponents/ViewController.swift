//
//  ViewController.swift
//  CBViewComponents
//
//  Created by 𝕎𝔸𝕐ℕ𝔼 on 2018/5/21.
//  Copyright © 2018年 Cobonhood Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	private var isColorChanged: Bool = false
	
	fileprivate lazy var textField: CBTextField = {
		let textField = CBTextField()
		textField.textAlignment = .center
		textField.title = "Title"
		textField.hintText = "* Hint"
		textField.titleAlignment = .center
		textField.hintAlignment = .center
		textField.backColor = .white
		textField.borderColor = .black
		textField.borderWidth = 1
		return textField
	}()
	
	fileprivate lazy var maxButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("MAX", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 10)
		button.layer.borderWidth = 1.0
		button.layer.borderColor = UIColor.black.cgColor
		return button
	}()
	
	fileprivate lazy var changeHintButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Change Hint", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 20)
		button.layer.borderWidth = 1.0
		button.layer.borderColor = UIColor.black.cgColor
		button.layer.cornerRadius = 4.0
		return button
	}()
	
	fileprivate lazy var changeBorderColorButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Change Border Color", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 20)
		button.layer.borderWidth = 1.0
		button.layer.borderColor = UIColor.black.cgColor
		button.layer.cornerRadius = 4.0
		return button
	}()
	
	fileprivate lazy var changeTitleHiddenButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Change Title Hidden", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 20)
		button.layer.borderWidth = 1.0
		button.layer.borderColor = UIColor.black.cgColor
		button.layer.cornerRadius = 4.0
		return button
	}()
	
	fileprivate lazy var changeHintHiddenButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Change Hint Hidden", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 20)
		button.layer.borderWidth = 1.0
		button.layer.borderColor = UIColor.black.cgColor
		button.layer.cornerRadius = 4.0
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let screenWidth = UIScreen.main.bounds.width

		self.view.addSubview(self.textField)
		self.textField.set(rightButton: maxButton, withSize: CGSize(width: 35, height: 30))
		self.textField.frame = CGRect(x: 15, y: 100, width: screenWidth - 30, height: 60)
		
		self.view.addSubview(changeHintButton)
		self.changeHintButton.frame = CGRect(x: 15, y: 250, width: screenWidth - 30, height: 50)
		self.changeHintButton.addTarget(self, action: #selector(changeHint(_:)), for: .touchUpInside)
		
		self.view.addSubview(changeBorderColorButton)
		self.changeBorderColorButton.frame = CGRect(x: 15, y: changeHintButton.frame.maxY + 25, width: screenWidth - 30, height: 50)
		self.changeBorderColorButton.addTarget(self, action: #selector(changeBorderColor(_:)), for: .touchUpInside)
		
		self.view.addSubview(changeTitleHiddenButton)
		self.changeTitleHiddenButton.frame = CGRect(x: 15, y: changeBorderColorButton.frame.maxY + 25, width: screenWidth - 30, height: 50)
		self.changeTitleHiddenButton.addTarget(self, action: #selector(changeTitleHidden(_:)), for: .touchUpInside)
		
		self.view.addSubview(changeHintHiddenButton)
		self.changeHintHiddenButton.frame = CGRect(x: 15, y: changeTitleHiddenButton.frame.maxY + 25, width: screenWidth - 30, height: 50)
		self.changeHintHiddenButton.addTarget(self, action: #selector(changeHintHidden(_:)), for: .touchUpInside)
	}
	
	@objc func changeHint(_ sender: UIButton) {
		self.textField.hintText = "* " + String(arc4random_uniform(100))
	}
	
	@objc func changeBorderColor(_ sender: UIButton) {
		self.isColorChanged = !self.isColorChanged
		let newColor: UIColor = isColorChanged ? .green : .black
		self.textField.borderColor = newColor
	}
	
	@objc func changeTitleHidden(_ sender: UIButton) {
		self.textField.set(titleHidden: !self.textField.isTitleHidden, animated: true)
	}
	
	@objc func changeHintHidden(_ sender: UIButton) {
		self.textField.isHintHidden = !self.textField.isHintHidden
	}


}

