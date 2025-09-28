#let identity = json("../data/identity.json")

#block(spacing: 12pt)[
  #grid(
    columns: (auto, 1fr),
    gutter: 8pt,
    block(
      image(identity.picture),
      width: 70pt,
      radius: 6pt,
      clip: true
    ),
    [
      #text(size: 15pt)[#text(weight: "light", identity.firstname) #text(weight: "medium", identity.lastname)] \
      #text(size: 11pt, weight: "light", identity.title) \
      
      #grid(
        columns: (1fr, 1fr),
        text(size: 8pt)[
          #identity.location \
          #identity.email \
          #identity.phone
        ],
        align(right + bottom)[
          #text(size: 8pt, for website in identity.websites [
            #text(size: 7pt, website.url)
            #box(baseline: 0pt + 1pt, image(width: 9pt, height: 8pt, fit: "cover", website.icon))
            #linebreak()
          ])
        ]
      )
    ]
  )
]

#par(justify: true, identity.summary)
