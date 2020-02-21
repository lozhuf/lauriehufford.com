import Foundation
import Publish
import Plot
import SplashPublishPlugin

// This will generate your website using the built-in Foundation theme:
try LaurieHufford_com()
    .publish(
        withTheme: .lozhuf,
        additionalSteps: [
            .deploy(using: .gitHub("lozhuf/lozhuf.github.io"))
        ],
        plugins: [
            .splash(withClassPrefix: "")
        ]
)
