\version "2.24.2"

% layout
\include "layoutPaper.ly"

% voices
\include "parts/loadParts.ly"

\header {
  title = "YAWN.2023"
  composer = "Mike McCormick"
  copyright = "© 2023 Mike McCormick"
  tagline = ##f
}

\score{
  <<
    \new StaffGroup <<
      \fluteI
      \fluteII
      \oboeI
      \oboeII
      \clarinetI
      \clarinetII
      \bassoonI
      \bassoonII
    >>
    \new StaffGroup <<
      \hornI
      \hornII
      \hornIII
      \hornIV
      \trumpetI
      \trumpetII
      \trumpetIII
      \tromboneI
      \tromboneII
      \tromboneIII
      \tuba
    >>
    \harp
    \new StaffGroup <<
      \violinI
      \violinII
      \viola
      \violoncello
      \doubleBass
    >>
  >>
}