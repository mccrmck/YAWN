\version "2.24.2"

hornI = \new Staff = "hornI" \with {
  instrumentName = "horn I"
  shortInstrumentName = "hn.I"
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