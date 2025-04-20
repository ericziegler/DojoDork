//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

final class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Properties
    
    private(set) var baseURL: String
    private(set) var credentials: Credentials?
    private let session: URLSession
    private let userDefaults: UserDefaults
    private let credentialsCacheKey = "NetworkServiceCredentialsKey"
    
    // MARK: - Init
    
    init(baseURL: String) {
        self.baseURL = baseURL
        self.session = URLSession(configuration: .ephemeral)
        self.userDefaults = UserDefaults.standard
        loadCredentials()
    }
    
    // MARK: - Requests
    
    func request(endpoint: String,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 includeCredentials: Bool,
                 ignoreCache: Bool,
                 timeoutInterval: Double) async throws -> Data? {
        guard let url = URL(string: baseURL)?.appendingPathComponent(endpoint) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: timeoutInterval)
        request.httpMethod = method.rawValue

        // handle parameters
        var params = parameters ?? Parameters()
        // add current timestamp to enforce ignoring php caching
        if ignoreCache {
            let formatter = ISO8601DateFormatter()
            params["nocache"] = formatter.string(from: Date())
        }
        
        // add credentials if expected
        if let credentials = self.credentials, includeCredentials {
            params = params.merging(credentials) { (current, _) in current }
        }
        
        if method == .get {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = params.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
            request.url = urlComponents?.url
        } else {
            // for POST and other methods, add parameters to the body
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let (data, _) = try await session.data(for: request)
        return data
    }
    
    // MARK: - Credentials
    
    func loadCredentials() {
        if let data = userDefaults.data(forKey: credentialsCacheKey),
           let creds = try? JSONDecoder().decode(Credentials.self, from: data) {
            self.credentials = creds
        }
    }
    
    func setCredentials(_ creds: Credentials) {
        if let data = try? JSONEncoder().encode(creds) {
            userDefaults.set(data, forKey: credentialsCacheKey)
            self.credentials = creds
        }
    }
    
    func clearCredentials() {
        userDefaults.removeObject(forKey: credentialsCacheKey)
        self.credentials = nil
    }

}
