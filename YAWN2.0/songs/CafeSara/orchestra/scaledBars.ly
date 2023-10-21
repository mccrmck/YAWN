\version "2.24.2"

scaledThree = #(define-music-function
                ( ratio music )
                ( fraction? ly:music? )
                #{
                  \scaleDurations $ratio {
                    \set Timing.measureLength = #(ly:make-moment (* (car ratio) 3/4) (cdr ratio) )
                    $music
                  }
                #})

scaledFour = #(define-music-function
               ( ratio music )
               ( fraction? ly:music? )
               #{
                 \scaleDurations $ratio {
                   \set Timing.measureLength = #(ly:make-moment (car ratio) (cdr ratio) )
                   $music
                 }
               #})

scaledFive = #(define-music-function
               ( ratio music )
               ( fraction? ly:music? )
               #{
                 \scaleDurations $ratio {
                   \set Timing.measureLength = #(ly:make-moment (* (car ratio) 5/4) (cdr ratio) )
                   $music
                 }
               #})

tempoArrow = #(define-music-function
               ( note startTempo )
               ( number? markup? )
               #{
                 \override TextSpanner.bound-details.left.text = \markup { \concat { \normal-text {\note-by-number #note #0 #UP " = " #startTempo } } }
                 \override TextSpanner.style = #'line
                 \override TextSpanner.bound-details.right.text = \markup { \fontsize #3 \arrow-head #X #RIGHT ##t }
               #})

tempoToTempo = #(define-music-function
                 ( note startTempo endTempo )
                 ( number? markup? markup? )
                 #{
                   \override TextSpanner.bound-details.left.text = \markup {
                     \concat {
                       \normal-text {
                         \note-by-number #note #0 #UP " = " #startTempo
                       }
                     }
                   }
                   \override TextSpanner.style = #'line
                   \override TextSpanner.bound-details.right.text = \markup {
                     \concat {
                       \fontsize #3 \arrow-head #X #RIGHT ##t
                       \normal-text {
                         " "
                         \note-by-number #note #0 #UP
                         " = "
                         #endTempo
                       }
                     }
                   }
                 #})
