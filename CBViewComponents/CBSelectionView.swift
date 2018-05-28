//
//  CBSelectionView.swift
//  CBViewComponents
//
//  Created by 𝕎𝔸𝕐ℕ𝔼 on 2018/5/24.
//  Copyright © 2018年 Cobonhood Inc. All rights reserved.
//

import UIKit

// MARK: DataSource

protocol CBSelectionViewControllerDataSource: class {
	
	func numberOfItemForSelectionViewController(_ selectionView: CBSelectionViewController) -> Int
	
	func selectionViewController(_ selectionView: CBSelectionViewController, titleForSelectionAt index: Int) -> String?
	
	func selectionViewController(_ selectionView: CBSelectionViewController, sizeForSelectionAt index: Int) -> CGSize?
	
}

extension CBSelectionViewControllerDataSource {
	
	func selectionViewController(_ selectionView: CBSelectionViewController, sizeForSelectionAt index: Int) -> CGSize? {
		return nil
	}
}

// MARK: -
// MARK: Delegate

protocol CBSelectionViewControllerDelegate: class {
	
	func selectionViewController(_ selectionView: CBSelectionViewController, didSelectItemAt index: Int)
}

extension CBSelectionViewControllerDelegate {

	func selectionViewController(_ selectionView: CBSelectionViewController, didSelectItemAt index: Int) { }
}

class CBSelectionViewController: UIView {

	private struct Constants {
		
		static let itemSpacing: CGFloat = 1
	}
	
	internal weak var dataSource: CBSelectionViewControllerDataSource?
	
	internal weak var delegate: CBSelectionViewControllerDelegate?
	
	internal var opacity: CGFloat = 0 {
		didSet {
			self.backgroundColor = self.backgroundColor?.withAlphaComponent(self.opacity)
		}
	}
	
	fileprivate var items: [UIButton] = []
	
	fileprivate var stackview: UIStackView = {
		let stackview = UIStackView()
		stackview.axis = .vertical
		stackview.distribution = .equalSpacing
		stackview.alignment = .center
		stackview.spacing = Constants.itemSpacing
		return stackview
	}()
	
	init() {
		super.init(frame: .zero)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	internal func show(for view: UIView?) {
		
		guard let numberOfItems = self.dataSource?.numberOfItemForSelectionViewController(self) else {
			return
		}
		
		var maxWidth: CGFloat = 0
		var maxHeight: CGFloat = 0
		
		for index in 0 ..< numberOfItems {
			let button = UIButton(type: .system)
			
			/// Configure button title if button title is given by data source.
			if let title = self.dataSource?.selectionViewController(self, titleForSelectionAt: index) {
				button.setTitle(title, for: .normal)
			}
			
			/// Configure button size if button size is given by data source.
			if let size = self.dataSource?.selectionViewController(self, sizeForSelectionAt: index) {
				button.widthAnchor.constraint(equalToConstant: size.width).isActive = true
				button.heightAnchor.constraint(equalToConstant: size.height).isActive = true
				maxWidth = max(maxWidth, size.width)
				maxHeight += size.height
			}
			/// Otherwise, use the button intrinsic size.
			else {
				button.sizeToFit()
				maxWidth = max(maxWidth, button.frame.width)
				maxHeight += button.frame.height
			}
			
			/// Add action for each button.
			button.addTarget(self, action: #selector(didTapItem(_:)), for: .touchUpInside)
			
			/// Add to stackview.
			self.stackview.addArrangedSubview(button)
		}
		
		/// Height includes all item spacing.
		maxHeight += CGFloat(max((self.items.count - 1), 0)) * Constants.itemSpacing
		
		/// Get the key window of application.
		if let window = UIApplication.shared.keyWindow {
			self.frame = window.bounds
			
			self.addSubview(self.stackview)
			self.stackview.center = CGPoint(x: window.bounds.width / 2, y: window.bounds.height / 2)
			self.stackview.widthAnchor.constraint(equalToConstant: maxWidth).isActive = true
//			self.stackview.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//			self.stackview.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//			
			self.setNeedsLayout()
			self.layoutIfNeeded()
			
			window.addSubview(self)
		}
	}
	
	internal func dismiss() {
		/// Removes all views.
		self.stackview.removeFromSuperview()
		self.removeFromSuperview()
		
		/// Removes all items.
		self.items.removeAll()
	}
	
	@objc fileprivate func didTapItem(_ sender: UIButton) {
		guard let index = self.items.index(of: sender) else {
			return
		}
		self.delegate?.selectionViewController(self, didSelectItemAt: index)
	}
	
}

extension UIViewController {
	
	fileprivate var topViewController: UIViewController? {
		
		if let presented = self.presentedViewController {
			return presented.topViewController
		}
		
		if let nav = self as? UINavigationController {
			return nav.visibleViewController?.topViewController
		}
		
		if let tab = self as? UITabBarController {
			if let selected = tab.selectedViewController {
				return selected.topViewController
			}
		}
		
		return self
	}
}

extension UIApplication {
	
	fileprivate var topViewController: UIViewController? {
		return self.keyWindow?.rootViewController?.topViewController
	}
}
