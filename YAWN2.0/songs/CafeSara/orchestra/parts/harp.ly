\version "2.24.2"

harp = \new PianoStaff = "harp" \with {
  instrumentName = "harp"
  shortInstrumentName = "hp."
} \relative c' {
  <<
    \new Voice {}
    \new Voice {}
  >>
}