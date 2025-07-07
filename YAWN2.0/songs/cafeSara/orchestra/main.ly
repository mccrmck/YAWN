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
      % ChoirStaffs can help in Polytempo situation
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

    \percI
    \harp

    \new StaffGroup <<
      \violinI
      \violinII
      \viola
      \violoncello
      \doubleBass
    >>
  >>
  %  \midi {} %  must increase dynamic range
}