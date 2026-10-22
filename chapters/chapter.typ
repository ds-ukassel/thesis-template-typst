#import "../macros.typ": *

= Es geht nicht nur Text

Neben Text kann man natürlich auch Bilder, Code, Formeln und mehr einfügen.

== Etwas Quelltext

Code kann mit dem Macro `#macros.codeBlock` erstellt werden.

#codeBlock(
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
  image("/assets/cat.jpg"),
  caption: [eine Katze],
)

== Abkürzungen
@HTML ist eine Abkürzung. Sie wird automatisch übernommen. <abkurzung>

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
