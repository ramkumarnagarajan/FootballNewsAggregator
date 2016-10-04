//
//  TeamAnSource+CoreDataProperties.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 11/8/15.
//  Copyright © 2015 Ram. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TeamAndSource {

    @NSManaged var teamName: String?
    @NSManaged var urlName: String?
    @NSManaged var sourceURL: String?

}
