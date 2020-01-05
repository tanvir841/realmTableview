//
//  data.swift
//  realmTableview
//
//  Created by Tanvir on 1/4/20.
//  Copyright © 2020 tanvir841. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class task: Object {
    dynamic var name = ""
    dynamic var time = 0
    dynamic var id = Int()
}


    

