//
//  User+CoreDataProperties.swift
//  TestApp
//
//  Created by Yulia Ignateva on 15.03.2023.
//
//

import CoreData

extension Users {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var email: String?
    @NSManaged public var photo: Foundation.Data?
    
}
