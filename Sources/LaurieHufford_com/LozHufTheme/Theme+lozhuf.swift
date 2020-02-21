import Foundation
import Plot
import Publish

extension Theme where Site == LaurieHufford_com {
    /// The default "Foundation" theme that Publish ships with, a very
    /// basic theme mostly implemented for demonstration purposes.
    static var lozhuf: Self {
        Theme(
            htmlFactory: LozHufHTMLFactory(),
            resourcePaths: ["Resources/LozHufTheme/styles.css"]
        )
    }
    
    private struct LozHufHTMLFactory: HTMLFactory {
        
        func makeIndexHTML(for index: Index,
                           context: PublishingContext<Site>) throws -> HTML {
            
            try makeSectionHTML(for: context.sections[.blog], context: context)
        }
        
        func makeSectionHTML(for section: Section<Site>,
                             context: PublishingContext<Site>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: section, on: context.site),
                .body(
                    .header(for: context, selectedSection: section.id),
                    .wrapper(
                        .h1(.text(section.title)),
                        .itemList(for: section.items, on: context.site)
                    ),
                    .footer(for: context.site)
                )
            )
        }
        
        func makeItemHTML(for item: Item<Site>,
                          context: PublishingContext<Site>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: item, on: context.site),
                .body(
                    .class("item-page"),
                    .header(for: context, selectedSection: item.sectionID),
                    .wrapper(
                        .article(
                            .h1(.text(item.title)),
                            .div(.class("metadata"),
                                .text(DateFormatter.lozhuf.string(from: item.date))),
                            .contentBody(item.body)
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        }
        
        func makePageHTML(for page: Page,
                          context: PublishingContext<Site>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: page, on: context.site),
                .body(
                    .header(for: context, selectedSection: .about),
                    .wrapper(.contentBody(page.body)),
                    .footer(for: context.site)
                )
            )
        }
        
        func makeTagListHTML(for page: TagListPage,
                             context: PublishingContext<Site>) throws -> HTML? {
            HTML(
                .lang(context.site.language),
                .head(for: page, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .wrapper(
                        .h1("Browse all tags"),
                        .ul(
                            .class("all-tags"),
                            .forEach(page.tags.sorted()) { tag in
                                .li(
                                    .class("tag"),
                                    .a(
                                        .href(context.site.path(for: tag)),
                                        .text(tag.string)
                                    )
                                )
                            }
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        }
        
        func makeTagDetailsHTML(for page: TagDetailsPage,
                                context: PublishingContext<Site>) throws -> HTML? {
            HTML(
                .lang(context.site.language),
                .head(for: page, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .wrapper(
                        .h1(
                            "Tagged with ",
                            .span(.class("tag"), .text(page.tag.string))
                        ),
                        .a(
                            .class("browse-all"),
                            .text("Browse all tags"),
                            .href(context.site.tagListPath)
                        ),
                        .itemList(
                            for: context.items(
                                taggedWith: page.tag,
                                sortedBy: \.date,
                                order: .descending
                            ),
                            on: context.site
                        )
                    ),
                    .footer(for: context.site)
                )
            )
        }
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }
    
    static func header(
        for context: PublishingContext<LaurieHufford_com>,
        selectedSection: LaurieHufford_com.SectionID?
    ) -> Node {
        .header(
            .wrapper(
                .nav(
                    .ul(
                        .li(.a(
                            .class(selectedSection == .blog ? "selected" : ""),
                            .href(context.sections[.blog].path),
                            .text(context.sections[.blog].title)
                            )),
                        .li(.class("site-name"), .text("LH")),
                        .li(.a(
                            .class(selectedSection == .about ? "selected" : ""),
                            .href(context.sections[.about].path),
                            .text(context.sections[.about].title)
                            ))
                    )
                )
            )
        )
    }
    
//    static func post(for item: Item<LaurieHufford_com>, on site: LaurieHufford_com) -> Node {
//        return .pageContent(
//            .h2(
//                .class("post-title"),
//                .a(
//                    .href(item.path),
//                    .text(item.title)
//                )
//            ),
//            .p(
//                .class("post-meta"),
//                .text(DateFormatter.blog.string(from: item.date))
//            ),
//            .tagList(for: item, on: site),
//            .div(
//                .class("post-description"),
//                .div(
//                    .contentBody(item.body)
//                )
//            )
//        )
//    }
    
    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.a(
                        .href(item.path),
                        .text(item.title)
                        )),
                    .tagList(for: item, on: site),
                    .p(.text(item.description))
                    ))
            }
        )
    }
    
    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
                ))
            })
    }
    
    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .p(
                .text("Generated using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                ),
                .text(". 100% JavaScript-free.")
            ),
            .p(.a(
                .text("RSS feed"),
                .href("/feed.rss")
                ))
        )
    }
}
