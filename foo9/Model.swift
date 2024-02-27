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
    var id: String
    var parentId: String?
    
}

struct AbstractGroup {
    var type: Types 
    var name : String
    var image: String
    var groups: [AbstractGroup]?
    var items: [Item]?
    var parentID: String?
}


class Item : Codable{
    
    
    
    var title : String
    var image : String
    var price : Int
    var groupId: String
    
    init(title: String, image: String, price: Int, groupId: String) {
        self.title = title
        self.image = image
        self.price = price
        self.groupId = groupId
        
        
    }
   
    
}
enum Types : String, Codable {
    case pizza
    case burger
//    case drink
}
enum PizzaSize: String,  Codable{
    case small
    case medium
    case large
}
enum DoughThickness: String, Codable{
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

//protocol BurgerProtocol :Codable {
//    var size : BurgerSize {get}
//}




class Pizza : Item, PizzaProtocol {
    
    var dough: DoughThickness
    var size: PizzaSize
    
    init(title : String, image: String, price: Int, dough: DoughThickness, size: PizzaSize, groupId: String) {
        self.dough = dough
        self.size = size
        super.init(title: title, image: image, price: price, groupId: groupId)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }

    
}






class Storage  {
    //var groups = [AbstractGroup]()
    var rootGroup : AbstractGroup!
    
    let rootId = "parentRootID"
    
    init(){
        setup()
    }
    func setup(){
        
        let pts1 = Pizza(title: "pizza1 slim small", image: "pizza", price: 200, dough: .traditional, size: .small, groupId: "traditional")
        let ptm1 = Pizza(title: "pizza1 slim medium", image: "pizza", price: 200,  dough: .traditional, size: .medium, groupId: "traditional")
        let ptl1 = Pizza(title: "pizza1 slim large", image: "pizza", price: 200, dough: .traditional, size: .large, groupId: "traditional")
        
    
        let pss1 = Pizza(title: "pizza1 slim small", image: "pizza", price: 200, dough: .slim, size: .small, groupId: "slim")
        let psm1 = Pizza(title: "pizza1 slim medium", image: "pizza", price: 200,  dough: .slim, size: .medium, groupId: "slim")
        let psl1 = Pizza(title: "pizza1 slim large", image: "pizza", price: 200, dough: .slim, size: .large, groupId: "slim")
        
        let pgt1 = Group(type: .pizza, name: "pizza traditional", image : "pizza", id: "traditional", parentId: self.rootId )
        let pgs1 = Group(type: .pizza, name: "pizza slim", image: "pizza", id: "small", parentId: self.rootId)
        
        let rootGroup = Group(type: .pizza, name: "pizza", image: "pizza",  id: self.rootId , parentId: nil)
        
        let groups1 = [pgt1, pgs1]
        let items = [pts1, ptm1, ptl1, pss1, psm1, psl1]
        
        var abstractGroups = [AbstractGroup]()
        

        
        for group in groups1 {
            var items1 =  [Item]()
            for item in items {
                if (item.groupId == group.id){
                    items1.append(item)
                }
            }
            
            abstractGroups.append(AbstractGroup(type: group.type, name: group.name, image: group.image, items: items1 ))
        }
       
        self.rootGroup = AbstractGroup(type: rootGroup.type, name: rootGroup.name, image: rootGroup.image, groups: abstractGroups, items: nil, parentID: nil)
        
//
//        for item in items {
//            for group in groups1{
//                if (item.groupId == group.id){
//                    abstractGroups.append(AbstractGroup(name: group.name, image: group.image, items: [item]))
//                }
//            }
//        }

       
//        groups.append(pizzas)
        
        

        

        
        
        
    }
    
}

extension String{
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        return ceil(size.width)
    }
}







