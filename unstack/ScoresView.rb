#
#  ScoresView.rb
#  unstack
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#


class ScoresView < NSView
  attr_accessor :game
  attr_accessor :score
  attr_accessor :last_score
  attr_accessor :player
  attr_accessor :stats

  def drawRect rect
    NSColor.whiteColor.set
    player.setTitle game.player.name
    l = game.player.scores[-1]
    last_score.setTitle "%s%.2f" % [l[1] > 0 ? '+' : nil, l[1]] if l
    score.setTitle "%.2f" % game.player.score
    stats.setTitle game.stats.to_s
  end
end