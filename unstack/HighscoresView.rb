#
#  HighscoresView.rb
#  unstack
#
#  Created by Thomas R. Koll on 08.05.11.
#  Copyright 2011 ananasblau.com. All rights reserved.
#


class HighscoresView < NSView
  attr_accessor :highscores

  def drawRect(rect)
    NSColor.blackColor.set
    NSRectFill(bounds)
    highscores.setString NSUserDefaults.standardUserDefaults['highscores'].collect{|r| r.join('\t')}.join('\n')
  end
end