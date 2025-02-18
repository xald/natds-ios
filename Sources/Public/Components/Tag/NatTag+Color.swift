extension NatTag {
    /**
     Size is an enum that represents the possible colors for the NatTag.
     The default color is `Primary`.

     These are all colors allowed for a NatTag:
     - primary
     - secondary
     - success
     - alert
     - `warning
     - link
     */

    public enum Color {
        case primary
        case secondary
        case success
        case alert
        case warning
        case link
        case custom(backgroundColor: UIColor, labelColor: UIColor)

        var tag: UIColor {
            switch self {
            case .primary:
                return getUIColorFromTokens(\.colorPrimary)
            case .secondary:
                return getUIColorFromTokens(\.colorSecondary)
            case .success:
                return getUIColorFromTokens(\.colorSuccess)
            case .alert:
                return getUIColorFromTokens(\.colorAlert)
            case .warning:
                return getUIColorFromTokens(\.colorWarning)
            case .link:
                return getUIColorFromTokens(\.colorLink)
            case .custom(let backgroundCustomColor, _):
                return backgroundCustomColor
            }
        }

        var label: UIColor {
            switch self {
            case .primary:
                return getUIColorFromTokens(\.colorOnPrimary)
            case .secondary:
                return getUIColorFromTokens(\.colorOnSecondary)
            case .success:
                return getUIColorFromTokens(\.colorOnSuccess)
            case .alert:
                return getUIColorFromTokens(\.colorOnAlert)
            case .warning:
                return getUIColorFromTokens(\.colorOnWarning)
            case .link:
                return getUIColorFromTokens(\.colorOnLink)
            case .custom(_, let labelCustomColor):
                return labelCustomColor
            }
        }
    }
}
