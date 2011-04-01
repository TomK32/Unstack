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
  attr_accessor :width
  attr_accessor :height
  attr_accessor :grade
  attr_accessor :tower
  
  def awakeFromNib
    start_game(self)
  end
  
  def start_game(sender)
    self.height = 20
    self.width = 10
    self.grade = rand
    self.blocks = []
    self.player ||= Player.new
    self.player.score = 0
    self.tower = Tower.random(self.grade, self.height, self.width)
  end

  def remove_block
  end
end
