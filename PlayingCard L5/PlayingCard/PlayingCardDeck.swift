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
            
            // For Swift 4.2 better use native  Int.random(in: ...)
           // return cards.remove(at: cards.count.arc4random)
            return cards.remove(at: Int.random(in: 0..<cards.count))
        } else {
            return nil
        }
    }
}

