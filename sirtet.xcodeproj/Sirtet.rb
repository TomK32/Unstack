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
    self.player = Player.new(NSUserDefaults.standardUserDefaults['player.name'] || "Thomas")
    self.player.score = 0
    self.tower = Tower.random(self.grade, self.height, self.width)
    self.next_block = Block.new
    self.game_view.setNeedsDisplay true
  end

  def tick(seconds)
    unless self.next_block.tick(1/20.0)
      self.player.add_score -(self.next_block.initial_time/2)
      self.next_block = Block.new
    end
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
    size_before = tower.size
    if tower.remove(next_block, x, y)

      player.add_score(next_block.time_remaining ** (1 + size_before.width - tower.size.width + size_before.height - tower.size.height))
      self.next_block = Block.new
      game_view.scores_view.setNeedsDisplay true
      return true
    end
    return false
  end

  def shuffle_and_remove(sender)
    if self.tower.shuffle_and_remove
      self.player.add_score(-2)
      self.game_view.tower_view.setNeedsDisplay true
    end
  end
end
