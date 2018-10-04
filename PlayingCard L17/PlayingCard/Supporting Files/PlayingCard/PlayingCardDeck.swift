//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by CS193p Instructor on 10/9/17.
//  Copyright © 2017 CS193p Instructor. All rights reserved.
//

import Foundation

struct PlayingCardDeck
{
    private(set) var cards = [PlayingCard]()
    
    init() {
        for suit in PlayingCard.Suit.allCases {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
    
    mutating func draw() -> PlayingCard? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}

 // For Swift 4.2 better use native  Int.random(in: ...)
extension Int {
    var arc4random: Int {
        if self > 0 {
           // return Int(arc4random_uniform(UInt32(self)))
            return Int.random(in: 0..<self)
        } else if self < 0 {
           // return -Int(arc4random_uniform(UInt32(abs(self))))
            return -Int.random(in: 0..<abs(self))
        } else {
            return 0
        }
    }
}
