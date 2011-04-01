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
  attr_accessor :timer
  
  def awakeFromNib
    self.timer = NSTimer.scheduledTimerWithTimeInterval( 1/20.0,
            target:self, selector:"tick:",
            userInfo:nil, repeats:true)
    start_game(self)
  end
  
  def start_game(sender)
    self.height = (game_view.tower_view.frame.size.height / 20).floor
    self.width = (game_view.tower_view.frame.size.width / 20).floor
    self.grade = rand/4 + 0.7
    self.blocks = []
    self.player ||= Player.new
    self.player.score = 0
    self.tower = Tower.random(self.grade, self.height, self.width)
    self.next_block = Block.new
    self.game_view.setNeedsDisplay true
  end

  def tick(seconds)
    self.next_block = Block.new unless self.next_block.tick(1/20.0)
    game_view.setNeedsDisplay true
  end

  def next_block
    game_view.next_block_view.block
  end

  def next_block=(block)
    game_view.next_block_view.block = block
    game_view.next_block_view.setNeedsDisplay true
  end

  def next_block_fits?(x,y)
    tower.fits?(next_block, x, y)
  end

  def score!(x,y)
    if tower.remove(next_block, x, y)
      player.score += next_block.time_remaining
      self.next_block = Block.new
      game_view.scores_view.setNeedsDisplay true
    end
  end

  def remove_block
  end
end
