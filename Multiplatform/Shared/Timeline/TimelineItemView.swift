//
//  TimelineItemView.swift
//  NetNewsWire
//
//  Created by Maurice Parker on 7/1/20.
//  Copyright © 2020 Ranchero Software. All rights reserved.
//

import SwiftUI

struct TimelineItemView: View {
	
	@EnvironmentObject var defaults: AppDefaults
	@StateObject var articleIconImageLoader = ArticleIconImageLoader()
	
	var timelineItem: TimelineItem
	
    var body: some View {
		VStack {
			HStack(alignment: .top) {
				TimelineItemStatusView(status: timelineItem.status)
				if let image = articleIconImageLoader.image {
					IconImageView(iconImage: image)
						.frame(width: CGFloat(defaults.timelineIconSize), height: CGFloat(defaults.timelineIconSize), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
				}
				VStack {
					Text(verbatim: timelineItem.article.title ?? "N/A")
						.fontWeight(.semibold)
						.lineLimit(defaults.timelineNumberOfLines)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding(.trailing, 4)
					Spacer()
					HStack {
						Text(verbatim: timelineItem.byline)
							.lineLimit(1)
							.truncationMode(.tail)
							.font(.footnote)
							.foregroundColor(.secondary)
						Spacer()
						Text(verbatim: timelineItem.dateTimeString)
							.lineLimit(1)
							.font(.footnote)
							.foregroundColor(.secondary)
							.padding(.trailing, 4)
					}
				}
			}
			Divider()
		}
		.onAppear {
			articleIconImageLoader.loadImage(for: timelineItem.article)
		}
    }
}

struct TimelineItemView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			TimelineItemView(timelineItem: TimelineItem(article: PreviewArticles.basicRead))
				.frame(maxWidth: 250)
			TimelineItemView(timelineItem: TimelineItem(article: PreviewArticles.basicUnread))
				.frame(maxWidth: 250)
			TimelineItemView(timelineItem: TimelineItem(article: PreviewArticles.basicStarred))
				.frame(maxWidth: 250)
		}
    }
}
