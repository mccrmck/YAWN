\version "2.24.2"

\include "../scaledBars.ly"

tuba = \new Staff = "tuba" \with {
  instrumentName = "tuba"
  shortInstrumentName = "tuba"
} \relative c' {
  \clef bass

  \time 3/4
  R2.
  \time 4/4
  R1
  \time 4/4
  R1
  \time 9/8
  R4. * 3

  \bar "|."
}