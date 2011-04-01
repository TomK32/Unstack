#
#  ScoresView.rb
#  sirtet
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#


class ScoresView < NSView
  attr_accessor :game
  attr_accessor :score
  attr_accessor :player
  def drawRect rect
    NSColor.whiteColor.set
    score.setTitle "%.2f" % game.player.score
  end
end