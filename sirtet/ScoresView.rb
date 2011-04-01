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
  attr_accessor :last_score
  attr_accessor :player

  def drawRect rect
    NSColor.whiteColor.set
    player.setTitle game.player.name.to_s
    last_score.setTitle "+%.2f" % game.player.scores[-1][1] if game.player.scores[-1]
    score.setTitle "%.2f" % game.player.score
  end
end