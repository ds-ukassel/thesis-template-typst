#import "@preview/abbr:0.3.0"
#import "macros.typ"
#import "@preview/hydra:0.6.2": hydra

// Latex style
#set par(leading: 0.6em, spacing: 1.1em, first-line-indent: 0em, justify: true)
#set text(font: "New Computer Modern", lang: "de")
#show raw: set text(font: "FiraMono Nerd Font")
#show heading: set block(above: 1.4em, below: 1em)
#set math.equation(numbering: "1.")

// Überschriften von Figuren und Bildbreite einstellen
#set figure.caption(position: top)
#show figure.caption: set text(size: 1.1em)
#show figure.where(kind: image): set block(width: 80%)

// Einstellungen
#let double-sided = false // Doppelseitiger Druck -> newpage() startet auf ungerader Seite
#let show-chapter-on-page-top = false // Kopfzeile über der Seite (Zusatzoption für einseitigen Druck)

#set page(
  paper: "a4",
  number-align: center,
  numbering: none,
)

#set page(header: context {
  if show-chapter-on-page-top {
    align(left, emph(hydra(1, skip-starting: false)))
    line(length: 100%)
  }
})

#let newpage() = {
  if double-sided {
    pagebreak(to: "odd", weak: true)
  } else {
    pagebreak()
  }
}

// Titelseite
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


// Abkürzungen
#abbr.make(
  ("HTML", "Hypertext Markup Language"),
)

// Seitenzahl beginnt bei Abstract (römisch)
#newpage()
#set page(numbering: "I")
#counter(page).update(1)

// Abstract
= Abstract
#lorem(100)

// Abkürzungsverzeichnis
#newpage()
#show: abbr.show-rule
#abbr.list(title: "Abkürzungsverzeichnis")

// Inhaltsverzeichnis
#newpage()
#outline(depth: 3)

// Seitenzahl merken (für später korrekt weiterführen)
<last_romanic>

// Seitenzahlen beginnen für Inhalt wieder bei 1 (arabisch)
#newpage()
#set heading(numbering: "1.")
#set page(numbering: "1")
#counter(heading).update(0)
#counter(page).update(1)

= Typst

Typst @noauthor_typst_2025 ist eine moderne Alternative zu LaTeX.

Es schreibt sich wie Markdown, mit Live-Preview, und Scripting im Text.

== Mit Unterüberschriften

Kapitel sind ganz einfach anzulegen.

=== Und Unterunterüberschriften

Auch hier könnte Text stehen!

= Es geht nicht nur Text

Neben Text kann man natürlich auch Bilder, Code, Formeln und mehr einfügen.

== Etwas Quelltext

Code kann mit dem Macro `#macros.codeBlock` erstellt werden.

#macros.codeBlock(
  ```py
  print('Hello World')
  ```,
  caption: "Mit Überschrift",
  subtext: [Und optionalem Kommentar.],
) <block1>

Zusätzlich kann man @block1 einfach referenzieren.

== Abbildungen

Einfach mit `#figure` ein Bild einfügen.

#figure(
  image("assets/cat.jpg"),
  caption: [eine Katze],
)

== Abkürzungen
@HTML ist eine Abkürzung. Sie wird automatisch übernommen.

== Mathe

Formeln können inline $a^2 + b^2=c^2$ genutzt werden...
$
  f(x) = cases(
    x &"if" x < 0,
    1 &"if" x=0,
    -x &"if" x>0
  )
$ <formel1>

...oder als eigene Linie dargestellt und referenziert werden, wie in @formel1.

// Ende der Arbeit, setze die Überschriften neu und setze die Seitenzahlen wieder auf römisch
#newpage()
#set heading(numbering: none)
#set page(numbering: "I")
#context [
  #let last_romanic_page = counter(page).at(<last_romanic>).at(0)
  #let addition = if double-sided { 2 } else { 1 }
  #counter(page).update(last_romanic_page + addition)
]

// Verzeichnisse
= Abbildungsverzeichnis
#outline(title: none, target: figure.where(kind: image))

= Tabellenverzeichnis
#outline(title: none, target: figure.where(kind: table))

= Codeverzeichnis
#outline(title: none, target: figure.where(kind: "code"))


// Literaturverzeichnis
#newpage()
#bibliography("references.bib", full: true, style: "ieee", title: "Literaturverzeichnis")


// Erklärung
#newpage()
#counter(page).update(0)
#set page(numbering: none)
#set par(spacing: 1.55em, first-line-indent: 0em, justify: true)

#heading("Ehrenwörtliche Erklärung", outlined: false, numbering: none)
Ich versichere hiermit, dass ich die vorliegende Arbeit selbständig und ohne Benutzung anderer als der
angegebenen Quellen und Hilfsmittel verfasst habe. Wörtlich übernommene Sätze oder Satzteile sind als
Zitat belegt, andere Anlehnungen, hinsichtlich Aussage und Umfang, unter Quellenangabe kenntlich
gemacht.

Die Arbeit hat in gleicher oder ähnlicher Form noch keiner Prüfungsbehörde vorgelegen und ist
nicht veröffentlicht. Sie wurde nicht, auch nicht auszugsweise, für eine andere Prüfungs- oder
Studienleistung verwendet
#v(4em)
#grid(
  rows: 1,
  columns: 2,
  column-gutter: (0.5fr, 0.5fr),
  grid.cell(
    [#line(length: 70%) #v(-1em) Ort, Datum],
  ),
  grid.cell(
    align: right,
    [#line(length: 70%) #v(-1em) Unterschrift],
  ),
)
