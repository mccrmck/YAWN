\version "2.24.2"

\include "../format.ly"

doubleBass = \new Staff = "doubleBass" \with {
  instrumentName = "double bass"
  shortInstrumentName = "d.b."
  midiInstrument = "acoustic bass"
}
<<
  \relative {
    \clef "bass_8"

    % LASTB
    \time 4/4
    R1 * 3
    \time 2/4
    R2
    \bar "||"

    % DOOM
    \time 3/4
    R2.
    \time 4/4
    R1 * 2
    \compoundMeter #'((2 2 3 2 8))
    R1 * 9/8

    \time 3/4
    R2.
    \time 4/4
    R1 * 2
    \compoundMeter #'((2 2 2 3 8))
    R1 * 9/8

    \time 3/4
    R2.
    \time 4/4
    R1 * 2
    \compoundMeter #'((2 2 3 2 8))
    R1 * 9/8

    % AMBIENCE
    \time 4/4
    \repeat unfold 6 {
      R1 * 8
    }
    \bar "||"

    % HARMONY
    R1 * 6
    R1 * 6
    R1 * 6
    R1 * 3
    r8 cis,4.->~ cis2
    r8 f4.->~ f2
    r4 e,2.->\ff~
    \time 2/4
    e2\<
    \bar "||"

    \time 4/4
    <<
      {
        R1 * 8
      }
      \panteraTempi
    >>

    \bar "|."
  }
  \scoreFormat
>>