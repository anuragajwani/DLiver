//
//  Restaurant.swift
//  DLiver
//
//  Created by Anurag Ajwani on 12/09/2019.
//  Copyright © 2019 Anurag Ajwani. All rights reserved.
//

import Foundation

struct Restaurant: Decodable {
    let name: String
    let cuisines: [Cuisine]
}
