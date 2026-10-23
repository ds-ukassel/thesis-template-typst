#import "@preview/abbr:0.3.0"
#import "macros.typ"
#import "@preview/hydra:0.6.2": hydra

// Latex style
#set par(leading: 0.6em, spacing: 1.1em, first-line-indent: 0em, justify: true)
#set text(font: "New Computer Modern", lang: "de")
#show raw: set text(font: ("FiraMono Nerd Font", "Liberation Mono", "Courier New"))
#show heading: set block(above: 1.4em, below: 1em)
#set math.equation(numbering: "1.")

// Headings and Figures
#set figure.caption(position: bottom)
#show figure.caption: set text(size: 10pt, weight: "bold")
#show figure.where(kind: image): set block(width: 80%)

// Config
#let double-sided = false // Duplex print -> newpage() starts on an odd page
#let show-chapter-on-page-top = false // Add a header showing the chapter above the page (only useful for single sided prints)

// Page Setup
#set page(
  paper: "a4",
  number-align: center,
  numbering: none,
)

// Title Page
#macros.titlePage(
  fachbereich: "Elektrotechnik/Informatik",
  fachgebiet: "Verteilte Systeme",
  arbeitstyp: "MASTERARBEIT",
  titel: "Untersuchung der allgemeinen Anwendbarkeit von Fluxkondensatoren",
  untertitel: "Zur Gewinnung von Einblicken",
  name: "Max Mustermann",
  matrikelnummer: "1234567",
  email: "max.mustermann@student.uni-kassel.de",
  erstprüfer: "Prof. Dr. Oliver Hohlfeld",
  zweitprüfer: "Prof. Dr. Emmett Brown",
  betreuer: "Christian Coupé, M.Sc.",
)

#set page(header: context {
  if show-chapter-on-page-top {
    align(left, emph(hydra(1, skip-starting: false)))
    line(length: 100%)
  }
})

#set page(
  margin: if double-sided {
    (inside: 3cm, outside: 2cm)
  } else {
    (x: 2.5cm, y: 2.5cm)
  }
)

#let newpage() = {
  if double-sided {
    pagebreak(to: "odd", weak: true)
  } else {
    pagebreak()
  }
}


// Abbreviations Setup
#show: abbr.show-rule
#abbr.make(
  ("HTML", "Hypertext Markup Language"),
)

// Page numbers start at the Abstract with I in roman numbers
#newpage()
#set page(numbering: "I")
#counter(page).update(1)

// Abstract
#include "chapters/abstract.typ"

// List of Abbreviations
#newpage()
#abbr.list(title: "Abkürzungsverzeichnis")

// Table of Contents
#show outline.entry: set outline.entry(fill: repeat([.], gap: 0.3em))
#show outline.entry.where(level: 1): set outline.entry(fill: none)
#show outline.entry.where(level: 1): set text(weight: "bold")
#show outline.entry.where(level: 1): set block(above: 1em)
#newpage()
#outline(depth: 3)

// Pages for the main content start at 1 in arabic numbers
#newpage()
#set heading(numbering: "1.")
#set page(numbering: "1")
#counter(heading).update(0)
#counter(page).update(1)

#include "chapters/intro.typ"

#newpage()
#include "chapters/chapter.typ"

// End of main content, reset headings and use roman numbers again
#newpage()
#set heading(numbering: none)
#set page(numbering: "I")
#counter(page).update(4) // TODO: Needs to be updated manually

// Outlines
#show outline.entry: e => link(
  e.element.location(),
  e.indented([*#e.prefix()*:], e.inner()),
)
#show outline.entry.where(level: 1): set text(weight: "regular")

= Abbildungsverzeichnis
#outline(title: none, target: figure.where(kind: image))

= Tabellenverzeichnis
#outline(title: none, target: figure.where(kind: table))

= Codeverzeichnis
#outline(title: none, target: figure.where(kind: "code"))


// Bibliography
#newpage()
#bibliography("references.bib", full: true, style: "ieee", title: "Literaturverzeichnis")


// Declaration
#newpage()
#counter(page).update(0)
#set page(numbering: none)
#set par(spacing: 1.55em, first-line-indent: 0em, justify: true)
#include "chapters/declaration.typ"
