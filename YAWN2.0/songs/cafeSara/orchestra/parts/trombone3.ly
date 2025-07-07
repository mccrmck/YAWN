\version "2.24.2"

\include "../format.ly"

tromboneIII = \new Staff = "tromboneIII" \with {
  instrumentName = "trombone III"
  shortInstrumentName = "tbn.III"
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
    dis2~-> dis4. c4->

    % AMBIENCE
    \time 4/4
    \repeat unfold 6 {
      R1 * 8
    }
    \bar "||"

    % HARMONY
    R1 * 6
    R1 * 5
    g4.\glissando gis8~ gis2
    f1
    R1 * 5
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