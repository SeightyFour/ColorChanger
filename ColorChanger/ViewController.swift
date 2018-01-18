//
//  ViewController.swift
//  ColorChanger
//
//  Created by Mário Rodrigues on 05/07/2017.
//  Copyright © 2017 Mário Rodrigues. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var redSlider: UISlider!
	@IBOutlet weak var greenSlider: UISlider!
	@IBOutlet weak var blueSlider: UISlider!
	@IBOutlet weak var colorView: UIView!
	

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	@IBAction func changeColor(sender: UISlider) {
		
		if self.redSlider == nil {
			return
		}
		
		redSlider.isContinuous = true
		greenSlider.isContinuous = true
		blueSlider.isContinuous = true
		
		let red: Float = redSlider.value
		let green: Float = greenSlider.value
		let blue: Float = blueSlider.value
		
		colorView.backgroundColor = UIColor(displayP3Red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
	}
	
	func transform (for translation: CGPoint) -> CGAffineTransform {
		let moveBy = CGAffineTransform(translationX: translation.x, y: translation.y)
		let rotation = -sin(translation.x / (colorView.frame.width * 2.0))
		
		return moveBy.rotated(by: rotation)
	}

	@IBAction func panCard(_ sender: UIPanGestureRecognizer) {
		
		switch sender.state {
		case .changed:
			let translation = sender.translation(in: view)
			colorView.transform = transform(for: translation)
		case .ended:

			UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
				self.colorView.transform = .identity
			}, completion: nil)
			
		default:
			break
		}
		
		
	}
	
}

