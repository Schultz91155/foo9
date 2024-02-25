//
//  Model.swift
//  foo9
//
//  Created by Pavel Brovkin on 17.02.2024.
//

import Foundation
import UIKit

struct Group : Codable {
    var type: Types 
    var name : String
    var image: String
    var groups: [Group]?
    var items:  [Item]?
}


class Item : Codable{
    
    var title : String
    var image : String
    var price : Int
    
    init(title: String, image: String, price: Int) {
        self.title = title
        self.image = image
        self.price = price
    }
    
}
enum Types : Codable {
    case pizza
    case burger
//    case drink
}
enum PizzaSize: Codable{
    case small
    case medium
    case large
}
enum DoughThickness: Codable{
    case traditional
    case slim
}
protocol PizzaProtocol : Codable{
    
    var dough: DoughThickness {get set}
    var size: PizzaSize {get set}
    
}


enum BurgerSize :Codable {
    case M
    case L
    case XL
    
}

protocol BurgerProtocol :Codable {
    var size : BurgerSize {get}
}




class Pizza : Item {
    
    var dough: DoughThickness
    var size: PizzaSize
    
    init(title : String, image: String, price: Int, dough: DoughThickness, size: PizzaSize) {
        self.dough = dough
        self.size = size
        super.init(title: title, image: image, price: price)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }

    
}

class Burger : Item, BurgerProtocol{
    
    
    var size: BurgerSize
    
    init(title : String, image: String, price: Int, size: BurgerSize) {
        self.size = size
        super.init(title: title, image: image, price: price)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }



    
}




class Storage : Codable {
    var groups = [Group]()
    
    
    init(){
        setup()
    }
    func setup(){
        let pts1 = Pizza(title: "pizza1 traditional small", image: "pizza", price: 100, dough: .traditional, size: .small )
        let ptm1 = Pizza(title: "pizza1 traditional medium", image: "pizza", price: 200, dough: .traditional, size: .medium)
        let ptl1 = Pizza(title: "pizza1 traditional large", image: "pizza", price: 200, dough: .traditional, size: .large)
        
        let pgt1 = Group(type: .pizza, name: "pizza traditional", image : "pizza", groups: nil, items: [pts1,ptm1,ptl1])
        
        let pss1 = Pizza(title: "pizza1 slim small", image: "pizza", price: 200, dough: .slim, size: .small)
        let psm1 = Pizza(title: "pizza1 slim medium", image: "pizza", price: 200,  dough: .slim, size: .medium)
        let psl1 = Pizza(title: "pizza1 slim large", image: "pizza", price: 200, dough: .slim, size: .large)
        
        let pgs1 = Group(type: .pizza, name: "pizza slim", image: "pizza", groups: nil, items: [pss1,psm1,psl1])
        
        let p1 = Group(type: .pizza, name: "pizza1", image: "pizza", groups: [pgt1, pgs1], items: nil)
        
        let pts2 = Pizza(title: "pizza2 traditional small", image: "pizza", price: 200, dough: .traditional, size: .small)
        let ptm2 = Pizza(title: "pizza2 traditional medium", image: "pizza", price: 200, dough: .traditional, size: .medium)
        let ptl2 = Pizza(title: "pizza2 traditional large", image: "pizza", price: 200, dough: .traditional, size: .large)
        
        let pgt2 = Group(type: .pizza, name: "pizza traditional", image: "pizza", groups: nil, items: [pts2,ptm2,ptl2])
        
        let pss2 = Pizza(title: "pizza2 slim small", image: "pizza", price: 200, dough: .slim, size: .small)
        let psm2 = Pizza(title: "pizza2 slim medium", image: "pizza", price: 200, dough: .slim, size: .medium)
        let psl2 = Pizza(title: "pizza2 slim large", image: "pizza", price: 200, dough: .slim, size: .large)
        
        let pgs2 = Group(type: .pizza, name: "pizza slim", image: "pizza", groups: nil, items: [pss2,psm2,psl2])
        
        let p2 = Group(type: .pizza, name: "pizza2", image: "pizza", groups: [pgt2, pgs2], items: nil)
        
        let pts3 = Pizza(title: "pizza3 traditional small", image: "pizza", price: 200, dough: .traditional, size: .small)
        let ptm3 = Pizza(title: "pizza3 traditional medium", image: "pizza", price: 200, dough: .traditional, size: .medium)
        let ptl3 = Pizza(title: "pizza3 traditional large", image: "pizza", price: 200, dough: .traditional, size: .large)
        
        let pgt3 = Group(type: .pizza, name: "pizza traditional", image: "pizza", groups: nil, items: [pts3,ptm3,ptl3])
        
        let pss3 = Pizza(title: "pizza3 slim small", image: "pizza", price: 200, dough: .slim, size: .small)
        let psm3 = Pizza(title: "pizza3 slim medium", image: "pizza", price: 200, dough: .slim, size: .medium)
        let psl3 = Pizza(title: "pizza3 slim large", image: "pizza", price: 200, dough: .slim, size: .large)
    
        let pgs3 = Group(type: .pizza, name: "pizza slim", image: "pizza", groups: nil, items: [pss3,psm3,psl3])
        
        let p3 = Group(type: .pizza, name: "pizza3", image: "pizza", groups: [pgt3, pgs3], items: nil)
        
        let pizzas = Group(type: .pizza, name: "pizzas", image: "pizza", groups: [p1, p2,p3], items: nil)
        
        groups.append(pizzas)
        
        let bm1 = Burger(title: "burger 1 size M", image: "burger", price: 200,  size: .M)
        let bl1 = Burger(title: "burger 1 size L", image: "burger", price: 200, size: .L)
        let bXl1 = Burger(title: "burger 1 size XL", image: "burger", price: 200, size: .XL)
        
        let b1 = Group(type: .burger, name: "burger 1", image: "burger", groups: nil, items: [bm1, bl1, bXl1])
        
        let bm2 = Burger(title: "burger 2 size M", image: "burger", price: 200, size: .M)
        let bl2 = Burger(title: "burger 2 size L", image: "burger", price: 200, size: .L)
        let bXL2 = Burger(title: "burger 2 size XL", image: "burger", price: 200, size: .XL)
        
        let b2 = Group(type: .burger, name: "burger 2", image: "burger", groups: nil, items: [bm2, bl2, bXL2])
        
        let bm3 = Burger(title: "burger 3 size M", image: "burger", price: 200, size: .M)
        let bl3 = Burger(title: "burger 3 size L", image: "burger",price: 200, size: .L)
        let bXL3 = Burger(title: "burger 3 size XL", image: "burger", price: 200, size: .XL)
        
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







