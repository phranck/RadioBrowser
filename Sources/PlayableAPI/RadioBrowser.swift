
import Foundation
import SwiftyBeaver
let log = SwiftyBeaver.self

public class RadioBrowser: ObservableObject {
    public static let version = "0.1.0"
    public static let build = 1
    
    @Published public var radioStations: [RadioStation] = []

    private var agentName: String = "n/a"
    private var agentVersion: String = version
    
    required public init(agent: String = "\(RadioBrowser.self)", version: String = "\(RadioBrowser.version)") {
        self.agentName = agent
        self.agentVersion = version
    }
    
    // MARK: - Private Helper
    
    internal func stations(for endpoint: String, queryParameters: Dictionary<String, String> = [:]) throws {
        var request: URLRequest
        
        do {
            request = try _request(for: endpoint, queryParameters: queryParameters)
            log.debug("Performing request: \(request.url!)")
        }
        catch let error {
            fatalError(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: request) { [unowned self] data, response, error in
            guard let responseData = data else {
                fatalError(RadioBrowserError.invalidResponseData.description)
            }
            
            do {
                let decoderResponse = try JSONDecoder().decode([RadioStation].self, from: responseData)
                DispatchQueue.main.async {
                    self.radioStations = decoderResponse
                }
            }
            catch let error {
                fatalError(RadioBrowserError.undefined(error: error).description)
            }
        }
        .resume()
    }

    private func _request(for endpoint: String, queryParameters: Dictionary<String, String>) throws -> URLRequest {
        guard var requestUrl = URL(string: endpoint) else {
            throw RadioBrowserError.malformedURLString(urlString: endpoint)
        }
        
        if !queryParameters.isEmpty {
            requestUrl = requestUrl.append(queryParameters: queryParameters)
        }
        
//        let headers = [
//            "x-rapidapi-key": RapidAPI.key,
//            "x-rapidapi-host": RapidAPI.host
//        ]
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
        request.addValue("\(agentName)/\(agentVersion)", forHTTPHeaderField: "User-Agent")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .reloadRevalidatingCacheData
        
        return request
    }
}

internal enum RadioBrowserEndpoint: String {
    case stations
}
