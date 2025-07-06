\version "2.24.2"

\include "../format.ly"
\include "../utils.ly"

tromboneI = \new Staff = "tromboneI" \with {
  instrumentName = "trombone I"
  shortInstrumentName = "tbn.I"
  midiInstrument = "trombone"
}
<<
  \relative {
    \clef bass

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
    R1 * 5
    e'4.\glissando f8~ f2
    a2 f2
    r8 gis4.~ gis2
    R1 * 4
    R1 * 6
    \time 2/4
    R2
    \bar "||"

    % PANTERA
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