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
enum Types : String, Codable {
    case pizza
    case burger
//    case drink
}



class Storage : Codable {
    var groups = [Group]()

    
    init(){
        setup()
    }
    func setup(){
        let pts1 = Item(title: "pizza1 traditional small", image: "pizza", price: 100)
        let ptm1 = Item(title: "pizza1 traditional medium", image: "pizza", price: 100)
        let ptl1 = Item(title: "pizza1 traditional large", image: "pizza", price: 200)
        
    
        let pss1 = Item(title: "pizza1 slim small", image: "pizza", price: 200)
        let psm1 = Item(title: "pizza1 slim medium", image: "pizza", price: 200)
        let psl1 = Item(title: "pizza1 slim large", image: "pizza", price: 200)
        
        
        let pgt1 = Group(type: .pizza, name: "pizza traditional", image : "pizza", groups: nil, items: [pts1,ptm1,ptl1])
        let pgs1 = Group(type: .pizza, name: "pizza slim", image: "pizza", groups: nil, items: [pss1,psm1,psl1])
        let p1 = Group(type: .pizza, name: "pizza1", image: "pizza", groups: [pgt1, pgs1], items: nil)
        
        let pts2 = Item(title: "pizza2 traditional small", image: "pizza", price: 200)
        let ptm2 = Item(title: "pizza2 traditional medium", image: "pizza", price: 200)
        let ptl2 = Item(title: "pizza2 traditional large", image: "pizza", price: 200)
        
        let pgt2 = Group(type: .pizza, name: "pizza traditional", image: "pizza", groups: nil, items: [pts2,ptm2,ptl2])
        
        let pss2 = Item(title: "pizza2 slim small", image: "pizza", price: 200)
        let psm2 = Item(title: "pizza2 slim medium", image: "pizza", price: 200)
        let psl2 = Item(title: "pizza2 slim large", image: "pizza", price: 200)
        
        let pgs2 = Group(type: .pizza, name: "pizza slim", image: "pizza", groups: nil, items: [pss2,psm2,psl2])
        
        let p2 = Group(type: .pizza, name: "pizza2", image: "pizza", groups: [pgt2, pgs2], items: nil)
        
        let pts3 = Item(title: "pizza3 traditional small", image: "pizza", price: 200)
        let ptm3 = Item(title: "pizza3 traditional medium", image: "pizza", price: 200)
        let ptl3 = Item(title: "pizza3 traditional large", image: "pizza", price: 200)
        
        let pgt3 = Group(type: .pizza, name: "pizza traditional", image: "pizza", groups: nil, items: [pts3,ptm3,ptl3])
        
        let pss3 = Item(title: "pizza3 slim small", image: "pizza", price: 200)
        let psm3 = Item(title: "pizza3 slim medium", image: "pizza", price: 200)
        let psl3 = Item(title: "pizza3 slim large", image: "pizza", price: 200)
    
        let pgs3 = Group(type: .pizza, name: "pizza slim", image: "pizza", groups: nil, items: [pss3,psm3,psl3])
        
        let p3 = Group(type: .pizza, name: "pizza3", image: "pizza", groups: [pgt3, pgs3], items: nil)
        
        let pizzas = Group(type: .pizza, name: "pizzas", image: "pizza", groups: [p1, p2,p3], items: nil)
        
        groups.append(pizzas)
        
        let bm1 = Item(title: "burger 1 size M", image: "burger", price: 200)
        let bl1 = Item(title: "burger 1 size L", image: "burger", price: 200)
        let bXl1 = Item(title: "burger 1 size XL", image: "burger", price: 200)
        
        let b1 = Group(type: .burger, name: "burger 1", image: "burger", groups: nil, items: [bm1, bl1, bXl1])
        
        let bm2 = Item(title: "burger 2 size M", image: "burger", price: 200)
        let bl2 = Item(title: "burger 2 size L", image: "burger", price: 200)
        let bXL2 = Item(title: "burger 2 size XL", image: "burger", price: 200)
        
        let b2 = Group(type: .burger, name: "burger 2", image: "burger", groups: nil, items: [bm2, bl2, bXL2])
        
        let bm3 = Item(title: "burger 3 size M", image: "burger", price: 200)
        let bl3 = Item(title: "burger 3 size L", image: "burger",price: 200)
        let bXL3 = Item(title: "burger 3 size XL", image: "burger", price: 200)
        
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







