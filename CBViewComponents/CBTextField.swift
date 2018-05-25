//
//  CBTextField.swift
//  CBViewComponents
//
//  Created by 𝕎𝔸𝕐ℕ𝔼 on 2018/5/21.
//  Copyright © 2018年 Cobonhood Inc. All rights reserved.
//

import UIKit

class CBTextField: UITextField {
	
	private struct Constants {
		
		static let inputViewInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
		
		static let titleHeight: CGFloat = 15
		
		static let textHeight: CGFloat = 15
		
		static let hintHeight: CGFloat = 15
		
		struct Spacing {
			
			static let titlaAndTextInput: CGFloat = 10
			
			static let textInputAndHint: CGFloat = 5
			
			static let textAndButton: CGFloat = 15
		}
	}
	
	// MARK: -
	// MARK: Properties
	
	internal var inputViewInset = Constants.inputViewInset
	
	internal var spacingBetweenTitlaAndTextInput = Constants.Spacing.titlaAndTextInput
	
	internal var spacingBetweenTextInputAndHint = Constants.Spacing.textInputAndHint
	
	internal var spacingBetweenTextAndButton = Constants.Spacing.textAndButton
	
	/// Title
	internal var title: String? = nil {
		didSet {
			self.titleLayer.string = self.title
		}
	}
	
	internal var titleFont: UIFont? = .systemFont(ofSize: 12) {
		didSet {
			if let font = self.titleFont {
				self.titleLayer.font = font.cfFont
				self.titleLayer.fontSize = font.pointSize
			}
		}
	}
	
	internal var titleColor: UIColor? = .darkText {
		didSet {
			self.titleLayer.foregroundColor = self.titleColor?.cgColor
		}
	}
	
	internal var titleAlignment: NSTextAlignment = .natural {
		didSet {
			self.titleLayer.alignmentMode = self.titleAlignment.kCAAlignmentMode
		}
	}
	
	internal var isTitleHidden: Bool = false {
		didSet {
			self.titleLayer.isHidden = isTitleHidden
			
			/// Update to new frame.
			let titleHeight = self.titleFont?.lineHeight ?? Constants.titleHeight
			var frame = self.frame
			frame.size.height += (self.isTitleHidden ? -titleHeight : titleHeight)
			self.frame = frame
		}
	}
	
	/// Input View Background Color
	internal var backColor: UIColor?  = .white {
		didSet {
			self.inputBackLayer.backgroundColor = self.backColor?.cgColor
		}
	}
	
	/// Input View Border
	internal var borderWidth: CGFloat = 0.0 {
		didSet {
			self.inputBackLayer.borderWidth = self.borderWidth
		}
	}
	
	internal var borderColor: UIColor = .clear {
		didSet {
			self.inputBackLayer.borderColor = self.borderColor.cgColor
		}
	}
	
	private var leftButtonSize: CGSize?
	
	private var rightButtonSize: CGSize?
	
	/// Hint
	internal var hintText: String? = nil {
		didSet {
			self.hintLayer.string = self.hintText
		}
	}
	
	internal var hintFont: UIFont? = .systemFont(ofSize: 12) {
		didSet {
			if let font = self.hintFont {
				self.hintLayer.font = font.cfFont
				self.hintLayer.fontSize = font.pointSize
			}
		}
	}
	
	internal var hintColor: UIColor? = .darkText {
		didSet {
			self.hintLayer.foregroundColor = self.hintColor?.cgColor
		}
	}
	
	internal var hintAlignment: NSTextAlignment = .left {
		didSet {
			self.hintLayer.alignmentMode = self.hintAlignment.kCAAlignmentMode
		}
	}
	
	internal var isHintHidden: Bool = false {
		didSet {
			self.hintLayer.isHidden = isHintHidden
			
			/// Update to new frame.
			let hintHeight = self.hintFont?.lineHeight ?? Constants.hintHeight
			var frame = self.frame
			frame.size.height += (self.isHintHidden ? -hintHeight : hintHeight)
			self.frame = frame
		}
	}
	
	// MARK: -
	// MARK: View Components
	
	private lazy var titleLayer: CATextLayer = {
		let layer = CATextLayer()
		layer.string = self.title
		layer.foregroundColor = self.titleColor?.cgColor
		layer.backgroundColor = UIColor.clear.cgColor
		layer.alignmentMode = self.titleAlignment.kCAAlignmentMode
		layer.isWrapped = true
		layer.contentsScale = UIScreen.main.scale
		
		if let font = self.titleFont {
			layer.font = font.cfFont
			layer.fontSize = font.pointSize
		}
		
		return layer
	}()
	
	private lazy var inputBackLayer: CALayer = {
		let layer = CALayer()
		layer.backgroundColor = self.backColor?.cgColor
		layer.borderColor = self.borderColor.cgColor
		layer.borderWidth = self.borderWidth
		return layer
	}()
	
	private var leftButton: UIButton? = nil
	
	private var rightButton: UIButton? = nil
	
	private lazy var hintLayer: CATextLayer = {
		let layer = CATextLayer()
		layer.string = self.hintText
		layer.foregroundColor = self.hintColor?.cgColor
		layer.backgroundColor = UIColor.clear.cgColor
		layer.alignmentMode = self.hintAlignment.kCAAlignmentMode
		layer.isWrapped = true
		layer.contentsScale = UIScreen.main.scale
		
		if let font = self.hintFont {
			layer.font = font.cfFont
			layer.fontSize = font.pointSize
		}
		
		return layer
	}()
	
	// MARK: -
	// MARK: Initialization
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.initializeTextField()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.initializeTextField()
	}
	
	private final func initializeTextField() {
		self.borderStyle = .none
		
		self.layer.addSublayer(self.titleLayer)
		self.layer.addSublayer(self.inputBackLayer)
		self.layer.addSublayer(self.hintLayer)
		
		// TODO: Some other initializations
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		var frame = self.frame
		frame.size.height = max(self.intrinsicContentSize.height, frame.height)
		self.frame = frame
		
		self.titleLayer.frame = self.titleRectForBounds(self.bounds)
		self.inputBackLayer.frame = self.inputBackRectForBounds(self.bounds)
		self.hintLayer.frame = self.hintRectForBounds(self.bounds)
		
		if let leftButton = self.leftButton {
			leftButton.frame = self.leftButtonRectForBounds(self.bounds)
		}
		
		if let rightButton = self.rightButton {
			rightButton.frame = self.rightButtonRectForBounds(self.bounds)
		}
	}
	
	internal func set(leftButton: UIButton, withSize size: CGSize) {
		self.leftButton = leftButton
		self.leftButtonSize = size
		self.addSubview(leftButton)
		
		self.setNeedsLayout()
		self.layoutIfNeeded()
	}
	
	internal func set(rightButton: UIButton, withSize size: CGSize) {
		self.rightButton = rightButton
		self.rightButtonSize = size
		self.addSubview(rightButton)
		
		self.setNeedsLayout()
		self.layoutIfNeeded()
	}
	
	internal func set(titleHidden: Bool, animated: Bool) {
		self.isTitleHidden = titleHidden
		
		if animated {
			UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
				self.setNeedsLayout()
				self.layoutIfNeeded()
			}, completion: nil)
		}
	}
	
	internal func set(hintHidden: Bool, animated: Bool) {
		self.isHintHidden = hintHidden
		
		if animated {
			UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
				self.setNeedsLayout()
				self.layoutIfNeeded()
			}, completion: nil)
		}
	}
	
	// MARK: -
	// MARK: UITextField text/placeholder positioning overrides
	
	/**
	Calculate the rectangle for the textfield when it is not being edited
	- parameter bounds: The current bounds of the field
	- returns: The rectangle that the textfield should render in
	*/
	override open func textRect(forBounds bounds: CGRect) -> CGRect {
		let superRect = super.textRect(forBounds: bounds)
		
		let rightButtonSize = self.rightButtonSize ?? .zero
		let spacingBetweenRightButtonAndText: CGFloat = (self.rightButtonSize == nil) ? 0 : self.spacingBetweenTextAndButton
		
		let leftButtonSize = self.leftButtonSize ?? .zero
		let spacingBetweenLeftButtonAndText: CGFloat = (self.leftButtonSize == nil) ? 0 : self.spacingBetweenTextAndButton
		
		let remainedHorizontalSpacing = superRect.height - self.titleHeight
			- self.spacingBetweenTitlaAndTextInput
			- self.textInputVerticalInsets
			- self.spacingBetweenTextInputAndHint
			- self.hintHeight
		
		let buttonsWidth = leftButtonSize.width + rightButtonSize.width
		let spacingBetweenButtons = spacingBetweenLeftButtonAndText + spacingBetweenRightButtonAndText
		
		let rect = CGRect(x: superRect.minX + self.inputViewInset.left + leftButtonSize.width + spacingBetweenLeftButtonAndText,
						  y: superRect.minY + self.titleHeight + self.spacingBetweenTitlaAndTextInput + self.inputViewInset.top,
						  width: superRect.width - self.textInputHorizontalInsets - buttonsWidth - spacingBetweenButtons,
						  height: remainedHorizontalSpacing)
		
		return rect
	}
	
	/**
	Calculate the rectangle for the textfield when it is being edited
	- parameter bounds: The current bounds of the field
	- returns: The rectangle that the textfield should render in
	*/
	override open func editingRect(forBounds bounds: CGRect) -> CGRect {
		let superRect = super.textRect(forBounds: bounds)
		
		let rightButtonSize = self.rightButtonSize ?? .zero
		let spacingBetweenRightButtonAndText: CGFloat = (self.rightButtonSize == nil) ? 0 : self.spacingBetweenTextAndButton
		
		let leftButtonSize = self.leftButtonSize ?? .zero
		let spacingBetweenLeftButtonAndText: CGFloat = (self.leftButtonSize == nil) ? 0 : self.spacingBetweenTextAndButton
		
		let remainedHorizontalSpacing = superRect.height - self.titleHeight
			- self.spacingBetweenTitlaAndTextInput
			- self.textInputVerticalInsets
			- self.spacingBetweenTextInputAndHint
			- self.hintHeight
		
		let buttonsWidth = leftButtonSize.width + rightButtonSize.width
		let spacingBetweenButtons = spacingBetweenLeftButtonAndText + spacingBetweenRightButtonAndText
		
		let rect = CGRect(x: superRect.minX + self.inputViewInset.left + leftButtonSize.width + spacingBetweenLeftButtonAndText,
						  y: superRect.minY + self.titleHeight + self.spacingBetweenTitlaAndTextInput + self.inputViewInset.top,
						  width: superRect.width - self.textInputHorizontalInsets - buttonsWidth - spacingBetweenButtons,
						  height: remainedHorizontalSpacing)
		
		return rect
	}
	
	/**
	Calculate the rectangle for the placeholder
	- parameter bounds: The current bounds of the placeholder
	- returns: The rectangle that the placeholder should render in
	*/
	override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		let superRect = super.textRect(forBounds: bounds)
		
		let rightButtonSize = self.rightButtonSize ?? .zero
		let spacingBetweenRightButtonAndText: CGFloat = (self.rightButtonSize == nil) ? 0 : self.spacingBetweenTextAndButton
		
		let leftButtonSize = self.leftButtonSize ?? .zero
		let spacingBetweenLeftButtonAndText: CGFloat = (self.leftButtonSize == nil) ? 0 : self.spacingBetweenTextAndButton
		
		let remainedHorizontalSpacing = superRect.height - self.titleHeight
			- self.spacingBetweenTitlaAndTextInput
			- self.textInputVerticalInsets
			- self.spacingBetweenTextInputAndHint
			- self.hintHeight
		
		let buttonsWidth = leftButtonSize.width + rightButtonSize.width
		let spacingBetweenButtons = spacingBetweenLeftButtonAndText + spacingBetweenRightButtonAndText
		
		let rect = CGRect(x: superRect.minX + self.inputViewInset.left + leftButtonSize.width + spacingBetweenLeftButtonAndText,
						  y: superRect.minY + self.titleHeight + self.spacingBetweenTitlaAndTextInput + self.inputViewInset.top,
						  width: superRect.width - self.textInputHorizontalInsets - buttonsWidth - spacingBetweenButtons,
						  height: remainedHorizontalSpacing)
		
		return rect
	}
	
	// MARK: -
	// MARK: Positioning Overrides
	
	private func titleRectForBounds(_ bounds: CGRect) -> CGRect {
		return CGRect(x: bounds.minX, y: bounds.minY,
					  width: bounds.width, height: self.titleHeight)
	}
	
	private func inputBackRectForBounds(_ bounds: CGRect) -> CGRect {
		return CGRect(x: bounds.minX,
					  y: self.titleHeight + self.spacingBetweenTitlaAndTextInput,
					  width: bounds.width,
					  height: bounds.height - self.titleHeight
						- self.spacingBetweenTitlaAndTextInput
						- self.spacingBetweenTextInputAndHint
						- self.hintHeight)
	}
	
	private func leftButtonRectForBounds(_ bounds: CGRect) -> CGRect {
		guard let _ = self.leftButton, let buttonSize = self.leftButtonSize else {
			return .zero
		}
		
		let inputBackRect = self.inputBackRectForBounds(bounds)
		return CGRect(x: inputBackRect.minX + self.inputViewInset.left,
					  y: inputBackRect.minY + (inputBackRect.height - buttonSize.height) / 2.0,
					  width: buttonSize.width,
					  height: buttonSize.height)
	}
	
	private func rightButtonRectForBounds(_ bounds: CGRect) -> CGRect {
		guard let _ = self.rightButton, let buttonSize = self.rightButtonSize else {
			return .zero
		}
		
		let inputBackRect = self.inputBackRectForBounds(bounds)
		return CGRect(x: inputBackRect.maxX - self.inputViewInset.right - buttonSize.width,
					  y: inputBackRect.minY + (inputBackRect.height - buttonSize.height) / 2.0,
					  width: buttonSize.width,
					  height: buttonSize.height)
	}
	
	private func hintRectForBounds(_ bounds: CGRect) -> CGRect {
		return CGRect(x: bounds.minX, y: bounds.height - self.hintHeight,
					  width: bounds.width, height: self.hintHeight)
	}
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: self.bounds.width,
					  height: self.titleHeight + self.spacingBetweenTitlaAndTextInput
						+ self.textInputHeight
						+ self.textInputVerticalInsets
						+ self.spacingBetweenTextInputAndHint
						+ self.hintHeight)
	}
	
	// MARK: -
	// MARK: Calculations
	
	private var titleHeight: CGFloat {
		guard !self.isTitleHidden else {
			return 0
		}
		
		if let font = titleFont {
			return font.lineHeight
		}
		return Constants.titleHeight
	}
	
	private var textHeight: CGFloat {
		if let font = self.font {
			return font.lineHeight
		}
		return Constants.textHeight
	}

	private var textInputHeight: CGFloat {
		let leftButtonHeight = self.leftButtonSize?.height ?? 0
		let rightButtonHeight = self.rightButtonSize?.height ?? 0
		return max(self.textHeight, max(leftButtonHeight, rightButtonHeight))
	}
	
	private var hintHeight: CGFloat {
		guard !self.isHintHidden else {
			return 0
		}
		
		if let font = hintFont {
			return font.lineHeight
		}
		return Constants.hintHeight
	}
	
	private var textInputVerticalInsets: CGFloat {
		return self.inputViewInset.top + self.inputViewInset.bottom
	}
	
	private var textInputHorizontalInsets: CGFloat {
		return self.inputViewInset.left + self.inputViewInset.right
	}
	
}

// MARK: -
// MARK: UIFont Extensions

extension UIFont {
	
	fileprivate var cfFont: CGFont? {
		let fontName: CFString = self.fontName as NSString
		return CGFont(fontName)
	}
}

// MARK: -
// MARK: NSTextAlignment Extensions

extension NSTextAlignment {
	
	fileprivate var kCAAlignmentMode: String {
		switch self {
		case .natural:
			return kCAAlignmentNatural
			
		case .left:
			return kCAAlignmentLeft
			
		case .center:
			return kCAAlignmentCenter
			
		case .right:
			return kCAAlignmentRight
			
		case .justified:
			return kCAAlignmentJustified
		}
	}
}
