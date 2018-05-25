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
	
	func numberOfItemForSelectionViewController(at index: Int) -> Int
	
	func selectionViewController(_ selectionView: CBSelectionViewController, titleForSelectionAt index: Int) -> String?
	
	func selectionViewController(_ selectionView: CBSelectionViewController, sizeForSelectionAt index: Int) -> CGSize?
	
	func selectionViewController(_ selectionView: CBSelectionViewController, viewForSelectionAt index: Int) -> UIView?
}

extension CBSelectionViewControllerDataSource {
	
	func selectionViewController(_ selectionView: CBSelectionViewController, sizeForSelectionAt index: Int) -> CGSize? {
		return nil
	}
	
	func selectionViewController(_ selectionView: CBSelectionViewController, viewForSelectionAt index: Int) -> UIView? {
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
		
	}
	
	internal weak var dataSource: CBSelectionViewControllerDataSource?
	
	internal weak var delegate: CBSelectionViewControllerDelegate?
	
	fileprivate var items: [UIButton] = []
	
	

}
