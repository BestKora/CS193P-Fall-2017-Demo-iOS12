//  ViewController.swift
//  Concentration
//
//  Created by CS193p Instructor  on 09/25/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//
//

import UIKit

class ConcentrationViewController: UIViewController {
    
	private lazy var game =
        Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
	
	var numberOfPairsOfCards: Int {
		return (visibleCardButtons.count + 1) / 2
	}
	

	
	@IBOutlet private weak var flipCountLabel: UILabel! {
		didSet {
			flipCount = 0
		}
	}
	
	@IBOutlet private var cardButtons: [UIButton]!
    
    private var visibleCardButtons: [UIButton]! {
        return cardButtons?.filter{!$0.superview!.isHidden}
    }
	
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
	@IBAction private func touchCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = visibleCardButtons.index(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
		} else {
			print("choosen card was not in visibleCardButtons")
		}
	}
	
	private func updateViewFromModel() {
		guard visibleCardButtons != nil else { return }
		for index in visibleCardButtons.indices {
			let button = visibleCardButtons[index]
			let card = game.cards[index]
			if card.isFaceUp {
				button.setTitle(emoji(for: card), for: UIControl.State.normal)
				button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			} else {
				button.setTitle("", for: UIControl.State.normal)
				button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
			}
		}
		
	}
    
    private(set) var flipCount = 0 {
        didSet {updateFlipCountLabel()}}
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
        .strokeWidth: 5.0,
        .strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(
        string: traitCollection.verticalSizeClass == .compact ? "Flips\n\(flipCount)" : "Flips: \(flipCount)",
        attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    override func traitCollectionDidChange(
                  _ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFlipCountLabel()
    }
    
	var theme: String? {
		didSet {
			emojiChoices = theme ?? ""
			emoji = [:]
			updateViewFromModel()
		}
	}
	
	private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎"
	
	private var emoji = [Card: String]()
	
	private func emoji(for card: Card) -> String {
		if emoji[card] == nil, emojiChoices.count > 0 {
            
            // For Swift 4.2 better use native  Int.random(in: ...)
			// let stringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
            let stringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: Int.random(in: 0..<emojiChoices.count))
			emoji[card] = String(emojiChoices.remove(at: stringIndex))
		}
		return emoji[card] ?? "?"
	}
}

/*
extension Int {
	var arc4Random: Int {
		switch self {
		case 1...Int.max:
			return Int(arc4random_uniform(UInt32(self)))
		case -Int.max..<0:
			return Int(arc4random_uniform(UInt32(self)))
		default:
			return 0
		}
		
	}
}
*/












