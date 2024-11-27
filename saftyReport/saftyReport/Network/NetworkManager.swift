import Foundation
import Alamofire

class NetworkManager {
    
    func photoAPI(compleation: @escaping (Result<[GalleryPhotoList], NetworkError>) -> Void) {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            print("[Error] BASE_URL is missing in Info.plist")
            compleation(.failure(.unknownError))
            return
        }
        
        let url = "\(baseURL)/api/v1/report/photo"
        print("[Request] URL: \(url)")
        
        let headers: HTTPHeaders = ["userId": "1"]
        print("[Request] Headers: \(headers)")
        
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
                
                print("[Response] Status Code: \(statusCode)")
                
                switch response.result {
                case .success:
                    let photoList = self.decodePhoto(data: data)
                    print("[Success] Photo List Decoded: \(photoList)")
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
            print("[Decode Success] GalleryResponse Decoded Successfully")
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
