\version "2.24.2"

hornII = \new Staff = "hornII" \with {
  instrumentName = "horn II"
  shortInstrumentName = "hn.II"
} \relative c' {
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