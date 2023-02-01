//
//  Candy+CoreDataProperties.swift
//  Project-12-CoreDataProject
//
//  Created by Luca Capriati on 2022/09/12.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName: String {
        name ?? "Unkown Candy"
    }
}

extension Candy : Identifiable {

}
