\version "2.24.2"

\include "../format.ly"

harp = \new PianoStaff = "harp" \with {
  instrumentName = "harp"
  shortInstrumentName = "hp."
}
\relative {
  <<
    \new Voice {
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
      R1 * 24
      \time 2/4
      R2
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
    \new Staff <<
      \new Voice{
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
        R1 * 24
        \time 2/4
        R2
        \bar "||"

        \time 4/4
        R1 * 8

        \bar "|."
      }
      \scoreFormat
    >>
  >>
}