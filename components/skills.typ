= Skills

#let skills = json("../data/skills.json")

== #skills.first().section

#text(size: 8pt, skills.first().skills.join(" - "))

#grid(
  columns: (auto, auto, auto),
  gutter: 16pt,
  ..for skill in skills.slice(1) {(
    [
      == #skill.section
      #text(size: 8pt, skill.skills.join(" - "))
    ]
  ,)}
)
