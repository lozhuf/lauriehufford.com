
import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct LaurieHufford_com: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case blog
        case about
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://lauriehufford.com")!
    var name = "Mostly Code"
    var description = "A description of LaurieHufford.com"
    var language: Language { .english }
    var imagePath: Path? { nil }
}
