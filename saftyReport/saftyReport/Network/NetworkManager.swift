import Foundation
import Alamofire

class NetworkManager {
    
    func homeAPI(compleation: @escaping (Result<HomeDataObject, NetworkError>) -> Void) {
        let url = "\(Environment.baseURL)/api/v1/home"
        
        let headers: HTTPHeaders = ["UserId": "1"]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .response { [weak self] response in
                guard let statusCode = response.response?.statusCode,
                      let data = response.data,
                      let self = self
                else {
                    print("[Error] Response or Data is nil")
                    compleation(.failure(.unknownError))
                    return
                }
                
                switch response.result {
                case .success:
                      if let homeDataObject = self.decodeHome(data: data) {
                          compleation(.success(homeDataObject))
                      } else {
                          compleation(.failure(.decodingError))
                      }
                case .failure(let error):
                    print("[Error] Request Failed: \(error.localizedDescription)")
                    let error = self.handleStatusCode(statusCode, data: data)
                    compleation(.failure(error))
                }
            }
    }
        
    func decodeHome(data: Data) -> HomeDataObject? {
        do {
            let response = try JSONDecoder().decode(HomeResponse.self, from: data)
            return response.data
        } catch {
            print("[Decode Error] Failed to Decode HomeResponse: \(error)")
            return nil
        }
    }
    
    func photoAPI(compleation: @escaping (Result<[GalleryPhotoList], NetworkError>) -> Void) {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            print("[Error] BASE_URL is missing in Info.plist")
            compleation(.failure(.unknownError))
            return
        }
        
        let url = "\(baseURL)/api/v1/report/photo"
        
        let headers: HTTPHeaders = ["userId": "1"]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .response { [weak self] response in
                guard let statusCode = response.response?.statusCode,
                      let data = response.data,
                      let self = self
                else {
                    print("[Error] Response or Data is nil")
                    compleation(.failure(.unknownError))
                    return
                }
                
                
                switch response.result {
                case .success:
                    let photoList = self.decodePhoto(data: data)
                    compleation(.success(photoList))
                case .failure(let error):
                    print("[Error] Request Failed: \(error.localizedDescription)")
                    let error = self.handleStatusCode(statusCode, data: data)
                    compleation(.failure(error))
                }
            }
    }
    
    func decodePhoto(data: Data) -> [GalleryPhotoList] {
        do {
            let response = try JSONDecoder().decode(GalleryResponse.self, from: data)
            return response.data?.photoList ?? []
        } catch {
            print("[Decode Error] Failed to Decode GalleryResponse: \(error)")
            return []
        }
    }
}

extension NetworkManager {
    func decodeError(data: Data) -> String {
        do {
            let failResponse = try JSONDecoder().decode(FailResponse.self, from: data)
            print("[Decode Error Response] Status: \(failResponse.status?.description ?? "Unknown")")
            return failResponse.status?.description ?? ""
        } catch {
            print("[Decode Error] Failed to Decode Error Response: \(error)")
            return ""
        }
    }
    
    func handleStatusCode(_ statusCode: Int, data: Data) -> NetworkError {
        let errorCode = decodeError(data: data)
        print("[Handle Status Code] Status Code: \(statusCode), Error Code: \(errorCode)")
        
        switch (statusCode, errorCode) {
        case (400, "00"):
            print("[Error] Invalid Request (400, 00)")
            return .invalidRequest
        case (400, "01"):
            print("[Error] Expression Error (400, 01)")
            return .expressionError
        case (404, ""):
            print("[Error] Invalid URL (404)")
            return .invalidURL
        case (409, "00"):
            print("[Error] Duplicate Error (409, 00)")
            return .duplicateError
        case (500, ""):
            print("[Error] Server Error (500)")
            return .serverError
        default:
            print("[Error] Unknown Error")
            return .unknownError
        }
    }
}
