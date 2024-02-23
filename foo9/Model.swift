//
//  Model.swift
//  foo9
//
//  Created by Pavel Brovkin on 17.02.2024.
//

import Foundation
import UIKit

struct Group {
    var type: Types 
    var name : String
    var image: String
    var groups: [Group]?
    var items:  [Item]?
}


protocol Item {
    
    
    var title : String {get}
    var image : String {get}
    var price : Int {get}
    
}
enum Types{
    case pizza
    case burger
//    case drink
}
enum PizzaSize{
    case small
    case medium
    case large
}
enum DoughThickness{
    case traditional
    case slim
}
protocol PizzaProtocol {
    
    var dough: DoughThickness {get}
    var size: PizzaSize {get}
    
}


enum BurgerSize{
    case M
    case L
    case XL
    
}

protocol BurgerProtocol{
    var size : BurgerSize {get}
}




struct Pizza : Item, PizzaProtocol{

  
    
    var title: String
    
    var image: String
    
    var dough: DoughThickness
    
    var size: PizzaSize
    
    var price: Int
    
}

struct Burger : Item, BurgerProtocol{

    
    var title: String
    
    var image: String
    
    var size: BurgerSize
    
    var price: Int
    
}




class Storage {
    var groups = [Group]()
    
    
    init(){
        setup()
    }
    func setup(){
        let pts1 = Pizza(title: "pizza1 traditional small", image: "pizza", dough: .traditional, size: .small, price: 100)
        let ptm1 = Pizza(title: "pizza1 traditional medium", image: "pizza", dough: .traditional, size: .medium, price: 200)
        let ptl1 = Pizza(title: "pizza1 traditional large", image: "pizza", dough: .traditional, size: .large, price: 300)
        
        let pgt1 = Group(type: .pizza, name: "pizza traditional", image : "pizza", groups: nil, items: [pts1,ptm1,ptl1])
        
        let pss1 = Pizza(title: "pizza1 slim small", image: "pizza", dough: .slim, size: .small, price: 150)
        let psm1 = Pizza(title: "pizza1 slim medium", image: "pizza", dough: .slim, size: .medium, price: 250)
        let psl1 = Pizza(title: "pizza1 slim large", image: "pizza", dough: .slim, size: .large, price: 350)
        
        let pgs1 = Group(type: .pizza, name: "pizza slim", image: "pizza", groups: nil, items: [pss1,psm1,psl1])
        
        let p1 = Group(type: .pizza, name: "pizza1", image: "pizza", groups: [pgt1, pgs1], items: nil)
        
        let pts2 = Pizza(title: "pizza2 traditional small", image: "pizza", dough: .traditional, size: .small, price: 100)
        let ptm2 = Pizza(title: "pizza2 traditional medium", image: "pizza", dough: .traditional, size: .medium, price: 100)
        let ptl2 = Pizza(title: "pizza2 traditional large", image: "pizza", dough: .traditional, size: .large, price: 100)
        
        let pgt2 = Group(type: .pizza, name: "pizza traditional", image: "pizza", groups: nil, items: [pts2,ptm2,ptl2])
        
        let pss2 = Pizza(title: "pizza2 slim small", image: "pizza", dough: .slim, size: .small, price: 100)
        let psm2 = Pizza(title: "pizza2 slim medium", image: "pizza", dough: .slim, size: .medium, price: 100)
        let psl2 = Pizza(title: "pizza2 slim large", image: "pizza", dough: .slim, size: .large, price: 100)
        
        let pgs2 = Group(type: .pizza, name: "pizza slim", image: "pizza", groups: nil, items: [pss2,psm2,psl2])
        
        let p2 = Group(type: .pizza, name: "pizza2", image: "pizza", groups: [pgt2, pgs2], items: nil)
        
        let pts3 = Pizza(title: "pizza3 traditional small", image: "pizza", dough: .traditional, size: .small, price: 100)
        let ptm3 = Pizza(title: "pizza3 traditional medium", image: "pizza", dough: .traditional, size: .medium, price: 100)
        let ptl3 = Pizza(title: "pizza3 traditional large", image: "pizza", dough: .traditional, size: .large, price: 100)
        
        let pgt3 = Group(type: .pizza, name: "pizza traditional", image: "pizza", groups: nil, items: [pts3,ptm3,ptl3])
        
        let pss3 = Pizza(title: "pizza3 slim small", image: "pizza", dough: .slim, size: .small, price: 100)
        let psm3 = Pizza(title: "pizza3 slim medium", image: "pizza", dough: .slim, size: .medium, price: 100)
        let psl3 = Pizza(title: "pizza3 slim large", image: "pizza", dough: .slim, size: .large, price: 100)
    
        let pgs3 = Group(type: .pizza, name: "pizza slim", image: "pizza", groups: nil, items: [pss3,psm3,psl3])
        
        let p3 = Group(type: .pizza, name: "pizza3", image: "pizza", groups: [pgt3, pgs3], items: nil)
        
        let pizzas = Group(type: .pizza, name: "pizzas", image: "pizza", groups: [p1, p2,p3], items: nil)
        
        groups.append(pizzas)
        
        let bm1 = Burger(title: "burger 1 size M", image: "burger", size: .M, price: 200)
        let bl1 = Burger(title: "burger 1 size L", image: "burger", size: .L, price: 300)
        let bXl1 = Burger(title: "burger 1 size XL", image: "burger", size: .XL, price: 300)
        
        let b1 = Group(type: .burger, name: "burger 1", image: "burger", groups: nil, items: [bm1, bl1, bXl1])
        
        let bm2 = Burger(title: "burger 2 size M", image: "burger", size: .M, price: 200)
        let bl2 = Burger(title: "burger 2 size L", image: "burger", size: .L, price: 300)
        let bXL2 = Burger(title: "burger 2 size XL", image: "burger", size: .XL, price: 300)
        
        let b2 = Group(type: .burger, name: "burger 2", image: "burger", groups: nil, items: [bm2, bl2, bXL2])
        
        let bm3 = Burger(title: "burger 3 size M", image: "burger", size: .M, price: 200)
        let bl3 = Burger(title: "burger 3 size L", image: "burger", size: .L, price: 300)
        let bXL3 = Burger(title: "burger 3 size XL", image: "burger", size: .XL, price: 300)
        
        let b3 = Group(type: .burger, name: "burger 3", image: "burger", groups: nil, items: [bm3, bl3, bXL3])
        
        let burgers = Group(type: .burger, name: "burgers", image: "burgers", groups: [b1, b2, b3], items: nil)
        
        groups.append(burgers)
        
        
        
        
        
    }
    
}

extension String{
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        return ceil(size.width)
    }
}







