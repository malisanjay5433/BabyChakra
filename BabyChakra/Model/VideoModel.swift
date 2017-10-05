//
//  File.swift
//  BabyChakra
//
//  Created by Sanjay Mali on 05/10/17.
//  Copyright © 2017 Sanjay Mali. All rights reserved.
//

import Foundation

struct VideoModel: Decodable {
    var data: VideoURLModel
}

struct VideoURLModel: Decodable {
    var videos: [urlModel]
}

struct urlModel: Decodable {
    var videoURL: String!
    var title: String!
    var description:String!
}
