//
//  Category.swift
//  DailyPlanner
//
//  Created by Oliwia Procyk on 02/08/2023.
//

import Foundation
import RealmSwift

final class Category: Object {
    @Persisted var name: String = ""
    @Persisted var items: List<Item>
}
