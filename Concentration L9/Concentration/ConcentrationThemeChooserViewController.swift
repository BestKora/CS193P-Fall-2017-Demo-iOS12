//
//  ConcentrationThemeChooserViewController.swift
//  Lecture 7 - Concentration
//
//  Created by CS193p Instructor  on 09/25/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//
//

import UIKit

class ConcentrationThemeChooserViewController: VCLLoggingViewController,
                                    UISplitViewControllerDelegate {
    
    override var vclLoggingName: String {
        return "ThemeChooser"
    }

	let themes = [
		"Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
		"Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
		"Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
	]
	
	override func awakeFromNib() {
        super.awakeFromNib()
		splitViewController?.delegate = self
	}
	
	@IBAction func chooseTheme(_ sender: Any) {
//        if let cvc = splitViewDetailConcentrationViewController {
//            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
//                cvc.theme = theme
//            }
//        } else if let cvc = lastSeguedToConcentrationViewController {
//            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
//                cvc.theme = theme
//            }
//            navigationController?.pushViewController(cvc, animated: true)
//        } else {
			performSegue(withIdentifier: "Choose Theme", sender: sender as! UIButton)
//		}
	}
	
	private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
		return splitViewController?.viewControllers.last as? ConcentrationViewController
	}
	
	private var lastSeguedToConcentrationViewController: ConcentrationViewController?
	
	func splitViewController(_ splitViewController: UISplitViewController,
							 collapseSecondary secondaryViewController: UIViewController,
							 onto primaryViewController: UIViewController
		) -> Bool
	{
		if let cvc = secondaryViewController as? ConcentrationViewController {
			return cvc.theme == nil
		}
		return false
	}

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let identifier = segue.identifier, identifier == "Choose Theme", let cvc = segue.destination as? ConcentrationViewController {
			if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
				cvc.theme = theme
				lastSeguedToConcentrationViewController = cvc
			}
		}
		
    }


}
