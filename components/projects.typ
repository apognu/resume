#import "common.typ": *

= Projects

#let projects = json("../data/projects.json")

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 4pt,
  ..for project in projects {(
    block(fill: background, radius: 4pt, inset: 6pt, width: 100%)[
      == #project.name

      #block(spacing: 5pt, project.description)

      #box(baseline: 3pt, image(height: 11pt, "../assets/github.svg"))
      #thin(link(project.url, project.url.trim("https://github.com/")))
    ]
  ,)}
)
