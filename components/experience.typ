#import "common.typ": *

#let experiences = json("../data/experiences.json")
#show heading.where(level: 3): it => block(spacing: 12pt, text(size: 9pt, smallcaps(it)))

= Professional experience

#for job in experiences {
  block(breakable: false, pad(bottom: 8pt)[
    #grid(
      columns: (1fr, auto),
      gutter: 10pt,
      [
        == #job.year
        #text(size: 10pt)[*#job.company* - #job.title]
      ],
      block(align(right)[
        #box(image(height: 16pt, job.logo)) \
        #thin(job.countries)
      ]),
    )

    #block(fill: rgb("#f9f9f9"), radius: 4pt, inset: 8pt, spacing: 8pt)[
      #par(justify: true, job.summary)
    ]
    
    #if job.keys().contains("extra") {
      par(justify: true, emph(job.extra))
    }

    #if job.keys().contains("metrics") {
      place(
        right,
        dy: -6pt,
        block(fill: background, radius: 4pt, pad(x: 8pt, y: 5pt, text(size: 7pt)[*Metrics:* #job.metrics]))
      )
    }

    === Responsibilities

    #grid(
      columns: (1fr, 1fr),
      gutter: 8pt,
      for resp in job.responsibilities.slice(0, calc.ceil(job.responsibilities.len() / 2)) [- #resp],
      for resp in job.responsibilities.slice(calc.ceil(job.responsibilities.len() / 2)) [- #resp],
    )
  ])
}

