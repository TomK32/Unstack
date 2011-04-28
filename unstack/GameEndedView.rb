#
#  GameEndedView.rb
#  unstack
#
#  Created by Thomas R. Koll on 02.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#


class GameEndedView < NSView
  attr_accessor :winning_text
  attr_accessor :game

  def drawRect rect
    NSColor.whiteColor.set
    NSFrameRect bounds
    winning_text.setTitle "You made %.2f points. %s" % [
      game.player.score, game.player.score_text]
  end
end
