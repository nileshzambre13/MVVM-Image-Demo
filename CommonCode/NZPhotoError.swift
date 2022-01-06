
import Foundation
public enum NZPhotoError: Error {
    case wrongStatusError(status: Int)
    case urlSessionError(Error)
    case parseError(Error)
}
