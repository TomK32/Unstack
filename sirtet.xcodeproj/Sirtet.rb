#
#  Sirtet.rb
#  sirtet
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#

class Sirtet
  attr_accessor :game_view
  attr_accessor :blocks
  attr_accessor :player
  
  def awakeFromNib
    start_game(self)
  end
  
  def start_game(sender)
    self.blocks = []
    self.player ||= Player.new
    self.player.score = 0
  end

  def remove_block
  end
end
