#
#  Field.rb
#  sirtet
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#


class TowerView < NSView
  include GameHelper
  attr_accessor :game
  attr_accessor :game_view

  def block_size
    game_view.block_size
  end

  def drawRect rect
    withContext do
      game.tower.drawRect(rect, block_size)
    end
  end
end
