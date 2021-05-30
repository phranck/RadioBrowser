//
//  RadioStation.swift
//
//  Created by Frank Gregor on 30.05.21.
//

import Foundation

public struct RadioStation: Hashable {
    public var id: Int
    public var name: String
    public var streamUrl: String
    public var websiteUrl: String?
    public var coverUrl: String?
    public var countryCode: String?
    public var codec: String?
    public var bitrate: Int?
    
    public init(id: Int, name: String, streamUrl: String) {
        self.id = id
        self.name = name
        self.streamUrl = streamUrl
    }
}

extension RadioStation: Codable {
    private enum CodingKeys: String, CodingKey {
        case id          = "id"
        case name        = "name"
        case streamUrl   = "streamUrl"
        case websiteUrl  = "websiteUrl"
        case coverUrl    = "coverUrl"
        case countryCode = "countryCode"
        case codec       = "codec"
        case bitrate     = "bitrate"
    }
}

extension RadioStation: Equatable {
    public static func == (lhs: RadioStation, rhs: RadioStation) -> Bool {
        return lhs.id == rhs.id
    }
}
