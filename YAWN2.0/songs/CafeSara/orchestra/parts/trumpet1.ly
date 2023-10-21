\version "2.24.2"

trumpetI = \new Staff = "trumpetI" \with {
  instrumentName = "trumpet I"
  shortInstrumentName = "tpt.I"
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