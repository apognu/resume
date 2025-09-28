#import "common.typ": *

#grid(
  columns: (2fr, 1fr, 1fr),
  gutter: 10pt,
  [
    = Education

    #let education = json("../data/education.json")

      #for school in education {
        pad(bottom: 4pt)[
          #place(right, thin(school.location))

          == #school.year

          #school.institution \
          #if school.keys().contains("diploma") [ #text(weight: "bold", school.diploma)] \
          #if school.keys().contains("extra") { emph(school.extra) }
        ]
      }
  ],
  [
    = Languages

    #let languages = json("../data/languages.json")

    #for language in languages [
      == #language.language

      #language.level
    ]
  ],
  [
    = Miscellaneous

    #let misc = json("../data/misc.json")

    == Hobbies

    #if misc.keys().contains("hobbies") {
      for hobby in misc.hobbies [
        #hobby \
      ]
    }
  ]
)
