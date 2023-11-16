#import "@preview/ctheorems:1.0.0": thmrules, thmbox
#import "@preview/tablex:0.0.6": tablex, hlinex, vlinex

#let remark = thmbox(
  "remark",
  "注",
  titlefmt: text.with(fill: purple.darken(10%), weight: "bold"),
  // -0.5em 用于抵消 head、name 之间的空格。
  namefmt: (name) => text(weight: "bold")[#h(-0.5em)（#name）],
  separator: text(weight: "bold")[.#h(0.5em)],
  breakable: true,
  stroke: (left: purple),
).with(numbering: none)

#let example = thmbox(
  "example",
  "例",
  titlefmt: text.with(fill: green.darken(10%), weight: "bold"),
  // -0.5em 用于抵消 head、name 之间的空格。
  namefmt: (name) => text(weight: "bold")[#h(-0.5em)（#name）],
  separator: text(weight: "bold")[.#h(0.5em)],
  breakable: true,
  stroke: (left: green),
).with(numbering: none)

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
  set heading(numbering: "1.1", supplement: [§])

  // Make the empty set round
  // https://github.com/typst/typst/pull/1526#issuecomment-1596326198
  show sym.emptyset: sym.diameter

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

/// 列出化名
/// path: pseudonym 模块所在路径
/// subset: 要列出的化名范围，默认全列
/// sort: 是否排序，默认排
#let pseudonyms(path, subset: none, sort: true) = {
  // Load and drop field names
  let hashes = csv(path + "/hashes.csv")
  assert.eq(hashes.at(0), ("化名", "hash"))

  if subset != none {
    hashes = (hashes.at(0), ..hashes.slice(1).filter(row => row.at(0) in subset))
  }

  if sort {
    hashes = (hashes.at(0), ..hashes.slice(1).sorted(key: row => repr(row.at(0))))
  }

  [#hashes.slice(1).map(row => row.at(0)).join("、")当然是化名，他们的真名按 UTF-8 编码的 SHA256
    如下。]

  figure(tablex(
    columns: (auto, auto),
    align: center + horizon,
    auto-vlines: false,
    auto-hlines: false,
    [*#hashes.at(0).at(0)*],
    vlinex(),
    [*#hashes.at(0).at(1)*],
    hlinex(),
    ..hashes.slice(1).map(row => (row.at(0), raw(row.at(1)))).flatten(),
  ), caption: [化名与真名的 hash], kind: table)

  figure(
    raw(read(path + "/hash.py"), lang: "python", block: true),
    caption: [计算 hash 的 Python 脚本],
  )
}
