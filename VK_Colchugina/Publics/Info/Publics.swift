//
//  Publics.swift
//  L2_Colchugina_Irina
//
//  Created by Ирина Кольчугина on 11/12/20.
//

import UIKit
import Foundation
public class Public {
    var name: String
    var icon: UIImage
    var newsText: String?
    var newsIcon: UIImage?
    init(name: String, icon: UIImage, newsText: String, newsIcon: UIImage) {
        self.name = name
        self.icon = icon
        self.newsIcon = newsIcon
        self.newsText = newsText
    }
    
    init(name: String, icon: UIImage) {
        self.name = name
        self.icon = icon
    }

}

public var allPublics = [
    Public(name: "WARD #6", icon: UIImage(named: "WARD #6")!, newsText: """
        Two roads diverged in a yellow wood,
        And sorry I could not travel both
        And be one traveler, long I stood
        And looked down one as far as I could
        To where it bent in the undergrowth.

        Then took the other, as just as fair,
        And having perhaps the better claim,
        Because it was grassy and wanted wear;
        Though as for that the passing there
        Had worn them really about the same.
        """, newsIcon: UIImage(named: "WARD #6")!),
    Public(name: "BLACK SQUARE", icon: UIImage(named: "BLACK SQUARE")!, newsText: """
        Media(R)evolution is a series of transatlantic online discussions dedicated to the current situation and future of the media in the United States, Europe and globally. The first three episodes took place in September and October 2020 and were presented by 1014 – space for ideas and the Institute for Media and Communication Policy (IfM). Curated by Leonard Novy, Director IfM.
        """, newsIcon: UIImage(named: "BLACK SQUARE")!),
    Public(name: "DON'T PISS ME OFF", icon: UIImage(named: "DON'T PISS ME OFF")!, newsText: """
        1014 and the American Council on Germany invite experts and practitioners from both sides of the Atlantic to discuss challenges – and opportunities – our societies are facing during the current public health, economic, and social crises. These events will explore what can be done to advance equality, justice, and sustainable development for the benefit of all.
        """, newsIcon: UIImage(named: "DON'T PISS ME OFF")!),
    Public(name: "FEMELE MEMS", icon: UIImage(named: "FEMELE MEMS")!, newsText: """
        In 2020, the United Nations celebrate their 75th anniversary. 1014 takes a look at their signature objectives – the seventeen sustainable development goals. Over the next months, we will interview seventeen local initiatives in the United States and in Europe that strive to turn these objectives into reality.
        """, newsIcon: UIImage(named: "FEMELE MEMS")!),
    Public(name: "SCIENCE", icon: UIImage(named: "SCIENCE")!, newsText: """
        As some communities around the globe slowly reopen, life does not simply snap back to the way it was before the pandemic. But what is the new normal? 1014 points out analysis and commentaries on globalization, social inequalities, geopolitical shifts, climate, and more. On a daily basis on Twitter @1014nyc.
        """, newsIcon: UIImage(named: "SCIENCE")!)
]

public  let newPublics = [
    Public(name: "V Λ C U U M", icon: UIImage(named: "V Λ C U U M")!),
    Public(name: "IN-SCALE", icon: UIImage(named: "IN-SCALE")!),
    Public(name: "Hajime Records", icon: UIImage(named: "Hajime Records")!),
    Public(name: "LOOK GIRL", icon: UIImage(named: "LOOK GIRL")!),
    Public(name: "CODE BLOG", icon: UIImage(named: "CODE BLOG")!),
    Public(name: "Better than yesterday", icon: UIImage(named: "Better than yesterday")!),
    Public(name: "LOOKBOOK", icon: UIImage(named: "LOOKBOOK")!),
    Public(name: "TATTOO", icon: UIImage(named: "TATTOO")!)
]
