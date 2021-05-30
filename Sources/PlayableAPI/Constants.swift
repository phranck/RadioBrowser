//
//  Created by Frank Gregor on 30.05.21.
//

import Foundation

public struct Constants {
    
    public struct API {
        static let baseUrl = "http://10.213.69.100:8080"
        static let APIUrl = "\(baseUrl)/api"
    }
    
}

public struct ModelDefaults {
    static let NoId: Int = -1
    static let EmptyString: String = ""
}
