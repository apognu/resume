#let tint = rgb("#3d85c6")
#let background = rgb("#d5e3f0")

#let template(doc) = {
  let identity = json("../data/identity.json")

  set document(
    title: identity.firstname + " " + identity.lastname + " - Resume",
    author: identity.firstname + " " + identity.lastname,
    keywords: (identity.firstname, identity.lastname, "resume"),
  )

  set page(
    paper: "a4",
    margin: 30pt,
  )

  set par(spacing: 16pt)
  set text(font: "Roboto", size: 8pt, weight: "regular")
  set list(spacing: 10pt)

  show heading.where(level: 1): it => pad(y: 10pt, stack(
    spacing: 6pt,
    it,
    line(length: 100%, stroke: 0.5pt + tint),
  ))

  show heading.where(level: 2): it => text(size: 9pt, weight: "medium", fill: tint, smallcaps(it))

  doc
}

#let thin(body) = text(size: 7pt, fill: rgb("#525252"), body)