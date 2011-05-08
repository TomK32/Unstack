#
#  GameView.rb
#  unstack
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#


class GameView < NSView
  include GameHelper
  attr_accessor :game
  attr_accessor :next_block_view
  attr_accessor :scores_view
  attr_accessor :tower_view
  attr_accessor :game_ended_view

  def block_size
    @block_size ||= (frame.size.width / game.width).floor
  end

  def drawRect(rect)
    NSColor.blackColor.set
    NSRectFill(bounds)
  end

  def start_game
    self.replaceSubview(self.game_ended_view, with:self.tower_view)
    self.tower_view.setNeedsDisplay true
  end

  def end_game
    self.replaceSubview(self.tower_view, with:self.game_ended_view)
    self.game_ended_view.setNeedsDisplay true
  end

end