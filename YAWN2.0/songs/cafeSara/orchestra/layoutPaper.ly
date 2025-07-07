\version "2.24.2"

\paper {
  #( set-paper-size "a2portrait" )
  indent = 1.25\cm
  top-margin = 1.25\cm
  bottom-margin = 1.5\cm
  % line-width = 37.5\cm
  left-margin = 2.7\cm
  right-margin = 1.8\cm
  ragged-right = ##f
  markup-system-spacing = #'(
                              (basic-distance . 12)
                              (minimum-distance . 6)
                              (padding . 1.4)
                              (stretchability . 12)
                              )
  system-system-spacing = #'(
                              (basic-distance . 12)
                              (minimum-distance . 8)
                              (padding . 2.2)
                              (stretchability . 6)
                              )

  scoreTitleMarkup = \markup {
    \fill-line {
      \fontsize #2 \bold
      \fromproperty #'header:piece
    }
  }
  system-separator-markup = \slashSeparator
}

\layout {
  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet
  %  \autoLineBreaksOff

  \context {
    \Score
    \remove "Timing_translator"
    \remove "Default_bar_line_engraver"
    \remove "Bar_number_engraver"
    \remove "Metronome_mark_engraver"
    \numericTimeSignature
    % \RemoveEmptyStaves
    \override SpacingSpanner.base-shortest-duration = #(ly:make-moment 1/32)
    \override SpacingSpanner.uniform-stretching = ##t
    % \override SpacingSpanner.strict-note-spacing = ##t
    %  proportionalNotationDuration = #(ly:make-moment 1/32)
  }

  \context {
    \Staff
    \consists "Timing_translator"
    \consists "Default_bar_line_engraver"
    \consists "Bar_number_engraver"
    \consists "Metronome_mark_engraver"
    barNumberVisibility = #(every-nth-bar-number-visible 4)
    \override BarNumber.break-visibility = #end-of-line-invisible
    centerBarNumbers = ##t
    \override CenteredBarNumber.Y-offset = #-5.5
    % \RemoveEmptyStaves
  }

  \context {
    \DrumStaff
    \consists "Timing_translator"
    \consists "Default_bar_line_engraver"
    \consists "Bar_number_engraver"
    \consists "Metronome_mark_engraver"
    barNumberVisibility = #(every-nth-bar-number-visible 4)
    \override BarNumber.break-visibility = #end-of-line-invisible
    centerBarNumbers = ##t
    \override CenteredBarNumber.Y-offset = #-5.5
  }

}