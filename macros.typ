#import "@preview/zebraw:0.6.1": *
#import "@preview/ez-today:2.1.0"
#show: zebraw

// creates the titlepage
#let titlePage(
  fachbereich: none,
  fachgebiet: none,
  arbeitstyp: none,
  titel: none,
  untertitel: none,
  name: none,
  matrikelnummer: none,
  email: none,
  erstprüfer: none,
  zweitprüfer: none,
  betreuer: none,
) = {
  page(
    footer-descent: 0%,
    footer: align(center)[
      #ez-today.today()
    ],
    // margin: 2em,
    paper: "a4",
  )[
    #grid(
      columns: (1fr, 1fr),
      align: horizon,
      grid(
        image("assets/uk-logo.pdf", width: 6.8cm),
      ),
      (align(right)[Fachbereich #fachbereich \ Fachgebiet #fachgebiet])
    )
    #align(center)[
      #grid(
        gutter: 1fr,
        grid(
          row-gutter: 2em,
        ),
        grid(
          row-gutter: 1em,
          text(size: 1.3em)[#arbeitstyp],
          v(.5em),
          text(size: 1.85em, weight: "bold")[#titel],
          v(.5em),
          text(size: 1.5em)[#untertitel],
          v(5em),
          text(size: 1.2em, style: "italic")[#name],
          v(0em),
          text(size: 1em)[Mat.-Nr.: #matrikelnummer],
          text(size: 1em)[#email],
        ),
        grid(
          row-gutter:1em,
          "Prüfer:",
          erstprüfer,
          zweitprüfer,
          v(.5em),
          "Betreuer:",
          betreuer,
          v(2em)
        ),
        grid(
          row-gutter: 2em,
        ),
      )
    ]
  ]
}

// creates a codeblock
#let codeBlock(code, caption: none, subtext: none) = {
  figure(
    [
      #zebraw(numbering-separator: true, code)
      #if subtext != none {
        block(
          subtext,
          width: 80%,
        )
      }
    ],
    caption: caption,
    kind: "code",
    supplement: "Code Block",
  )
}
