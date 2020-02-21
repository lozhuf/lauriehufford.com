import Foundation

struct SocialMediaLink {
    let title: String
    let url: String
    let icon: String
}

extension SocialMediaLink {
    static var location: SocialMediaLink {
        return SocialMediaLink(
            title: "Copenahgen, Denmark",
            url: "https://en.wikipedia.org/wiki/Copenhagen",
            icon: "fas fa-map-marker-alt"
        )
    }
    
    static var linkedIn: SocialMediaLink {
        return SocialMediaLink(
            title: "LinkedIn",
            url: "https://www.linkedin.com/in/povilas-staškus-6b10528b",
            icon: "fab fa-linkedin"
        )
    }
    
    static var email: SocialMediaLink {
        return SocialMediaLink(
            title: "Email",
            url: "mailto:povilas@staskus.io",
            icon: "fas fa-envelope-open-text"
        )
    }
    
    static var github: SocialMediaLink {
        return SocialMediaLink(
            title: "GitHub",
            url: "https://github.com/nitesuit",
            icon: "fab fa-github-square"
        )
    }
    
    static var twitter: SocialMediaLink {
        return SocialMediaLink(
            title: "Twitter",
            url: "https://twitter.com/PovilasStaskus",
            icon: "fab fa-twitter-square"
        )
    }
}
