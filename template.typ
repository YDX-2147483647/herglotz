#import "@preview/ctheorems:1.1.3": thmrules, thmbox

#let _thmbox_fmt = (
  // 开头的负空白用于抵消 head、name 之间的空格。
  namefmt: (name) => text(weight: "bold", [#h(-1em/4)（#name] + box(width: 1em)[）#h(-1em/4).]),
  separator: h(0.5em),
  breakable: true,
)

#let remark = thmbox(
  "remark",
  "注",
  titlefmt: text.with(fill: purple.darken(10%), weight: "bold"),
  stroke: (left: purple),
  .._thmbox_fmt,
).with(numbering: none)

#let example = thmbox(
  "example",
  "例",
  titlefmt: text.with(fill: green.darken(10%), weight: "bold"),
  stroke: (left: green),
  .._thmbox_fmt,
).with(numbering: none)

#let small = text.with(size: 0.8em, fill: gray.darken(70%))

// A stylized table header
// TODO: Use a show rule on `table.header`.
// It is not possible at least in typst v0.11. “That will be fixed in a future release.”
// https://typst.app/docs/guides/table-guide/#basic-tables
// https://github.com/typst/typst/issues/3640
#let table-header(..headers) = {
  table.header(..headers.pos().map(strong))
}

#let project(title: "", authors: (), date: none, body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)

  // Save heading and body font families in variables.
  let body-fonts = ("Libertinus Serif", "Source Han Serif")
  let sans-fonts = ("Libertinus Sans", "Source Han Sans")
  let script-fonts = ("Libertinus Sans", "STKaiti")

  // Set body font family.
  set text(font: body-fonts, lang: "zh", region: "CN")
  // 中西共用标点默认全宽，破折号应不离不弃
  // TODO: 这样无法区分正文和`figure.caption`，引号高度可能不匹配汉字。
  // https://github.com/typst/typst/issues/3331
  show regex("[“‘’”]|——|……"): it => {
    set text(font: body-fonts.at(1)) if text.lang == "zh"
    it
  }
  show heading: set text(font: sans-fonts)
  show raw: set text(font: ("Fira Code", ..sans-fonts))
  show figure.caption: set text(font: script-fonts)
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

  set table(
    align: (x, y) => (if y == 0 { center } else { start }) + horizon,
    stroke: (x, y) => (
      if y == 0 { (bottom: 1pt + black) },
      if x > 0 { (left: 1pt + black) },
    ).sum(),
  )

  show: thmrules
  show math.equation: set block(breakable: true)

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

  figure(table(
    columns: 2,
    table-header(..hashes.at(0)),
    ..hashes.slice(1).map(row => (row.at(0), raw(row.at(1)))).flatten(),
  ), caption: [化名与真名的 hash])

  figure(
    raw(read(path + "/hash.py"), lang: "python", block: true),
    caption: [计算 hash 的 Python 脚本],
  )
}
