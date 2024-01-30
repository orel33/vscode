// compile with: typst compile demo.typ
#show: rest => columns(2, rest) // double colonne
#set heading(numbering: "1.") // numérotation des sections

= Introduction

*Typst* is a new markup-based typesetting system for the sciences.

+ Fast
+ Flexible
  - Easy to learn
  - Easy to use
+ Intuitive

A guide for _LaTeX_ users is available here:
https://typst.app/docs/guides/guide-for-latex-users/

== Figures and references

Simple inclusion:

#image("gnu.png", width: 20%)

Centered figure with label:

#figure(
  image("gnu.png", width: 20%),
  caption: [
    _GNU_ is a recursive acronym for "GNU's Not Unix!".
  ],
) <gnu>

A reference to the @gnu.

A reference to bibliography @ramet:tel-01668740.

== Maths

The equation $Q = rho A v + C$
defines a flow rate.

Another equation:

$ 7.32 beta +
  sum_(i=0)^nabla
    (Q_i (a_i - epsilon)) / 2 $

A vector:

$ v := vec(x_1, x_2, x_3) $

An arrow:

$ a arrow.squiggly b $

= Fibonacci sequence

The Fibonacci sequence is defined through the recurrence relation $F_n = F_(n-1) + F_(n-2)$
It can also be expressed in _closed form:_

$ F_n = (phi^n - psi^n) / sqrt(5) $

where $phi = (1 + sqrt(5)) / 2$ and $psi = (1 - sqrt(5)) / 2$.

#let count = 8
#let nums = range(1, count + 1)
#let fib(n) = (
    if n <= 2 { 1 }
    else { fib(n - 1) + fib(n - 2) }
)

The first #count Fibonacci numbers are:

#align(center, table(
    columns: count,
    ..nums.map(n => $F_#n$),
    ..nums.map(n => $#fib(n)$),
))

#bibliography("hdr.bib")
