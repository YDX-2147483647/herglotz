#import "@preview/ctheorems:1.0.0": thmrules, thmenv

#let remark = thmenv("remark", none, none, none, (name, number, body, fill: black) => [
  #text(fill: fill, weight: "bold")[
    #if name == none {
      [注.]
    } else {
      [注（#name）.]
    }
  ]
  #h(.5em)
  #body
  #v(.5em)
]).with(numbering: none)

#let small = text.with(size: 0.8em, fill: gray.darken(70%))

#let project(title: "", authors: (), date: none, body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)

  // Save heading and body font families in variables.
  let body-fonts = ("Linux Libertine", "Source Han Serif")
  let sans-fonts = ("Inria Sans", "Source Han Sans")

  // Set body font family.
  set text(font: body-fonts, lang: "zh")
  show heading: set text(font: sans-fonts)
  show raw: set text(font: ("Fira Code", ..sans-fonts))
  set heading(numbering: "1.1")

  // Title row.
  align(center)[
    #block(text(font: sans-fonts, weight: 700, 1.75em, title))
    #v(1em, weak: true)
    #date
  ]

  // Author information.
  pad(top: 0.5em, bottom: 0.5em, x: 2em, grid(
    columns: (1fr,) * calc.min(3, authors.len()),
    gutter: 1em,
    ..authors.map(author => align(center, strong(author))),
  ))

  // Main body.
  set par(justify: true)

  show: thmrules

  show strong: set text(fill: blue.darken(10%))
  show link: set text(fill: blue)
  show link: underline

  body
}
