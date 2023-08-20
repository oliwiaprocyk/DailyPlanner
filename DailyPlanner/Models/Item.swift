//
//  Item.swift
//  DailyPlanner
//
//  Created by Oliwia Procyk on 16/08/2023.
//

import Foundation
import RealmSwift

final class Item: Object {
    @Persisted var title: String = ""
    @Persisted var done: Bool = false
    @Persisted var dateCreated: Date?
    @Persisted(originProperty: "items") var parentCategory: LinkingObjects<Category>
}
