import Foundation
import Publish
import Plot
import SplashPublishPlugin

// This will generate your website using the built-in Foundation theme:
try LaurieHufford_com()
    .publish(
        withTheme: .lozhuf,
        deployedUsing: .gitHub("lozhuf/lozhuf.github.io"),
        additionalSteps: [
            .copyFile(at: "Resources/.noJekyll")
        ],
        plugins: [
            .splash(withClassPrefix: "")
        ]
)
