//
//  Model.swift
//  foo9
//
//  Created by Pavel Brovkin on 17.02.2024.
//

import Foundation
import UIKit







struct JSONGroups : Codable {
    
    var title: String
    var subGroups : [JSONSubGroup]
    
}

struct JSONSubGroup: Codable{
    var title: String
    var image: String
    var price = 300
    var subGroups : [JSONSubGroup]
    var items: [JSONItem]
}

struct JSONItem : Codable{
    var title : String
    var price : Int
}

enum PresetType : String, Codable{
    case single
    case double
}

struct Preset : Codable{
    var title : String
    var mainSubGroupTitle : String
    var mainSubGroupItems : [String]
    var secondarySubGroupTitle : String?
    var secondarySubGroupItems : [String]?
    var type : PresetType
}



class PresetsStorage{
    static let shared = PresetsStorage()
    
    var presets = [Preset](){
        didSet{
            let encodedData = try! JSONEncoder().encode(self.presets)
            UserDefaults.standard.set(encodedData, forKey: "presets")
        }
    }
    private init(){
    }
}
    
    
class NewStorage {
    static let shared = NewStorage()
    var storageGroups = [JSONGroups](){
        didSet{
            let encodedData = try! JSONEncoder().encode(self.storageGroups)
            UserDefaults.standard.set(encodedData, forKey: "key")
        }
    }
    
    let images = ["cheesePizza","meatPizza","Bigburger"]
    private init(){
        
    }
    
    
    
    func parse(pathForFile : String?) -> [JSONGroups]?{
        var d: Data?
        do{
            d = try Data(contentsOf: URL(fileURLWithPath: pathForFile!))
            
        }
        catch{
            print("Error : \(String(describing: error))")
            return nil
        }
        
        guard let data = d else{
            print( "Error...")
            return nil
        }
        
        do{
            let answer = try JSONDecoder().decode([JSONGroups].self, from: data)
            return answer
        } catch{
            print("Error : \(String(describing: error))")
            return nil
        }
        
        //        parsedGroups = parse(pathForFile: Bundle.main.path(forResource: "file", ofType: "json"))
    }
}
    
    

            
            
            
            




extension String{
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        return ceil(size.width)
    }
}
//extension UICollectionView {
//    func reloadData(_ completion: @escaping () -> Void) {
//        reloadData()
//        DispatchQueue.main.async { completion() }
//    }
//}
extension UIView {
    class func loadFromNb <T: UIView>() -> T{
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}





