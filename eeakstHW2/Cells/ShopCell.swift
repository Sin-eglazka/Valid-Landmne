//
//  ShopCell.swift
//  eeakstHW3
//
//  Created by Kate on 04.04.2023.
//

import UIKit


final class ShopCell: UIButton {
    private var quantityCoin: Int, quantityClues:Int
    required init(coins: Int, clues:Int, type: UIButton.ButtonType = .system) {
        self.quantityCoin = coins
        self.quantityClues = clues
        super.init(frame: .zero)
        layer.cornerRadius = 0
        heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        setHeight(to: 40)
        setWidth(to: 40)
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getClues() -> Int{
        return self.quantityClues
    }
    
    func getCoins() -> Int{
        return self.quantityCoin
    }
    
}
