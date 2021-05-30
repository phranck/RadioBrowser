//
//  Created by Frank Gregor on 30.05.21.
//

import Foundation

extension RadioBrowser {

    public func stationsBy(countryCode: String) {
        var endpoint = endpoint(for: .stations).appending("/\(countryCode.uppercased())")
        
        do {
//            endpoint = "https://de1.api.radio-browser.info/json/stations/bycountrycodeexact/at"
            try stations(for: endpoint)
        }
        catch let error {
            fatalError(error.localizedDescription)
        }
        
    }

}

extension RadioBrowser {
    
    private func endpoint(for endpoint: RadioBrowserEndpoint) -> String {
        var endpointUrl = Constants.API.APIUrl
        
        switch endpoint {
            case .stations:
                endpointUrl.append("/\(endpoint.rawValue)")
        }
        
        return endpointUrl
    }
    
}
