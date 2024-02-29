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

protocol BurgerProtocol :Codable {
    var size : BurgerSize {get}
}




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

class Burger : Item, BurgerProtocol {
    
    
    
    var size: BurgerSize
    
    init(title : String, image: String, price: Int, size: BurgerSize, groupId: String) {
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
        
        let pts1 = Pizza(title: "Margarita slim small", image: "pizza", price: 200, dough: .traditional, size: .small, groupId: "Margarita_traditional")
        let ptm1 = Pizza(title: "Margarita slim medium", image: "pizza", price: 200,  dough: .traditional, size: .medium, groupId: "Margarita_traditional")
        let ptl1 = Pizza(title: "Margarita slim large", image: "pizza", price: 200, dough: .traditional, size: .large, groupId: "Margarita_traditional")
        let pss1 = Pizza(title: "Margarita slim small", image: "pizza", price: 200, dough: .slim, size: .small, groupId: "Margarita_slim")
        let psm1 = Pizza(title: "Margarita slim medium", image: "pizza", price: 200,  dough: .slim, size: .medium, groupId: "Margarita_slim")
        let psl1 = Pizza(title: "Margarita slim large", image: "pizza", price: 200, dough: .slim, size: .large, groupId: "Margarita_slim")
        
        let pts2 = Pizza(title: "MeatPizza slim small", image: "pizza", price: 200, dough: .traditional, size: .small, groupId: "MeatPizza_traditional")
        let ptm2 = Pizza(title: "MeatPizza slim medium", image: "pizza", price: 200,  dough: .traditional, size: .medium, groupId: "MeatPizza_traditional")
        let ptl2 = Pizza(title: "MeatPizza slim large", image: "pizza", price: 200, dough: .traditional, size: .large, groupId: "MeatPizza_traditional")
        let pss2 = Pizza(title: "MeatPizza slim small", image: "pizza", price: 200, dough: .slim, size: .small, groupId: "MeatPizza_slim")
        let psm2 = Pizza(title: "MeatPizza slim medium", image: "pizza", price: 200,  dough: .slim, size: .medium, groupId: "MeatPizza_slim")
        let psl2 = Pizza(title: "MeatPizza slim large", image: "pizza", price: 200, dough: .slim, size: .large, groupId: "MeatPizza_slim")
        
        let pts3 = Pizza(title: "ChickenPizza slim small", image: "pizza", price: 200, dough: .traditional, size: .small, groupId: "ChickenPizza_traditional")
        let ptm3 = Pizza(title: "ChickenPizza slim medium", image: "pizza", price: 200,  dough: .traditional, size: .medium, groupId: "ChickenPizza_traditional")
        let ptl3 = Pizza(title: "ChickenPizza slim large", image: "pizza", price: 200, dough: .traditional, size: .large, groupId: "ChickenPizza_traditional")
        let pss3 = Pizza(title: "ChickenPizza slim small", image: "pizza", price: 200, dough: .slim, size: .small, groupId: "ChickenPizza_slim")
        let psm3 = Pizza(title: "ChickenPizza slim medium", image: "pizza", price: 200,  dough: .slim, size: .medium, groupId: "ChickenPizza_slim")
        let psl3 = Pizza(title: "ChickenPizza slim large", image: "pizza", price: 200, dough: .slim, size: .large, groupId: "ChickenPizza_slim")
        
        let mbM = Burger(title: "Meat burger M", image: "burger", price: 100, size: .M, groupId: "MeatBurger")
        let mbL = Burger(title: "Meat burger L", image: "burger", price: 100, size: .L, groupId: "MeatBurger")
        let mbXL = Burger(title: "Meat burger XL", image: "burger", price: 100, size: .XL, groupId: "MeatBurger")
        
        let chbM = Burger(title: "Chiken burger M", image: "burger", price: 100, size: .M, groupId: "ChickenBurger")
        let chbL = Burger(title: "Chiken burger L", image: "burger", price: 100, size: .L, groupId: "ChickenBurger")
        let chbXL = Burger(title: "Chiken burger XL", image: "burger", price: 100, size: .XL, groupId: "ChickenBurger")
        
        let fbM = Burger(title: "Fish burger M", image: "burger", price: 100, size: .M, groupId: "FishBurger")
        let fbL = Burger(title: "Fish burger L", image: "burger", price: 100, size: .L, groupId: "FishBurger")
        let fbXL = Burger(title: "Fish burger XL", image: "burger", price: 100, size: .XL, groupId: "FishBurger")
        
        
        
        
        
        
//        let pgt1 = Group(type: .pizza, name: "pizza traditional", image : "pizza", id: "traditional", parentId: self.rootId )
//        let pgs1 = Group(type: .pizza, name: "pizza slim", image: "pizza", id: "small", parentId: self.rootId)
        
        let rootGroup = Group(type: .pizza, name: "Storage", image: "pizza",  id: self.rootId , parentId: nil)
        
        let pizzas = Group(type: .pizza, name: "Pizzas", image: "pizza", id: "pizzas", parentId: self.rootId)
        
        
        let margarita = Group(type: .pizza, name: "Margarita", image: "pizza", id: "Margarita", parentId: "pizzas")
        let margaritaTraditional = Group(type: .pizza, name: "Margarita traditional", image: "pizza", id: "Margarita_traditional", parentId: "Margarita")
        let margaritaSlim = Group(type: .pizza, name: "Margarita slim", image: "pizza", id: "Margarita_slim", parentId: "Margarita")
        
        
        let meatPizza = Group(type: .pizza, name: "MeatPizza", image: "pizza", id: "MeatPizza", parentId: "pizzas")
        let meatPizzaTraditional = Group(type: .pizza, name: "MeatPizza traditional", image: "pizza", id: "MeatPizza_traditional", parentId: "MeatPizza")
        let meatPizzaSlim = Group(type: .pizza, name: "MeatPizza slim", image: "pizza", id: "MeatPizza_slim", parentId: "MeatPizza")
        
        let chickenPizza = Group(type: .pizza, name: "ChickenPizza", image: "pizza", id: "MeatPizza", parentId: "pizzas")
        let chickenPizzaTraditional = Group(type: .pizza, name: "ChickenPizza traditional", image: "pizza", id: "ChickenPizza_traditional", parentId: "ChickenPizza")
        let chickenPizzaSlim = Group(type: .pizza, name: "ChickenPizza slim", image: "pizza", id: "ChickenPizza_slim", parentId: "ChickenPizza")
        

        let burgers = Group(type: .pizza, name: "Burgers", image: "burger", id: "burgers", parentId: self.rootId)
        
        
        let meatBurger = Group(type: .burger, name: "MeatBurger", image: "burger", id: "MeatBurger", parentId: "burgers")
        let chickenBurger = Group(type: .burger, name: "ChickenBurger", image: "burger", id: "ChickenBurger", parentId: "burgers")
        let fishBurger = Group(type: .burger, name: "FishBurger", image: "burger", id: "FishBurger", parentId: "burgers")
        
        
        
        let groupsJSON = [pizzas,
                                margarita,
                                            margaritaTraditional,
                                            margaritaSlim,
                                meatPizza,
                                            meatPizzaTraditional,
                                            meatPizzaSlim,
                                chickenPizza,
                                            chickenPizzaTraditional,
                                            chickenPizzaSlim,
                            burgers,
                                meatBurger,
                                chickenBurger,
                                fishBurger]
        
        let itemsJSON = [pts1, ptm1, ptl1, pss1, psm1, psl1,
                         pts2, ptm2, ptl2, pss2, psm2, psl2,
                         pts3, ptm3, ptl3, pss3, psm3, psl3,
                         mbM, mbL,mbXL,
                         chbM, chbL, chbXL,
                         fbM, fbL, fbXL
                         
            ]
        
        var abstractGroups = [AbstractGroup]()
        var createtedGrops = [Group]()
        


        
        for group in groupsJSON {
            var tempItems =  [Item]()
            for item in itemsJSON {
                if (item.groupId == group.id){
                    tempItems.append(item)
                }
            }
            
            abstractGroups.append(AbstractGroup(type: group.type, name: group.name, image: group.image, items: tempItems ))
        }
       
        self.rootGroup = AbstractGroup(type: rootGroup.type, name: rootGroup.name, image: rootGroup.image, groups: abstractGroups, items: nil, parentID: nil)
    }
    
}

extension String{
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        return ceil(size.width)
    }
}







