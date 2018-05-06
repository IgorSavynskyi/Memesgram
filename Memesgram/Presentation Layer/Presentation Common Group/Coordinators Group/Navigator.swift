protocol Navigator {
    associatedtype Destination
    
    func navigate(to destination: Destination, transition: TransitionType)
}

enum TransitionType {
    case push
    case modal
}
