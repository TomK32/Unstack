#
#  Unstack.rb
#  unstack
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#

class Unstack
  attr_accessor :game_view
  attr_accessor :blocks
  attr_accessor :player
  attr_accessor :width
  attr_accessor :height
  attr_accessor :grade
  attr_accessor :tower
  attr_accessor :timer
  attr_accessor :tower_timer
  attr_accessor :game_ended_view

  def awakeFromNib
    start_timer
    start_game(self)
  end

  def start_timer
    self.timer ||= NSTimer.scheduledTimerWithTimeInterval( 1/20.0,
          target:self, selector:"tick:", userInfo:nil, repeats:true)
    self.tower_timer ||= NSTimer.scheduledTimerWithTimeInterval( 2.0,
          target:self, selector:"tick_tower:", userInfo:nil, repeats:true)
  end

  def stop_timer
    self.timer.invalidate
    self.timer = nil
    self.tower_timer.invalidate
    self.tower_timer = nil
  end
  
  def start_game(sender)
    start_timer
    self.game_ended_view.setHidden true
    self.game_view.tower_view.setHidden false

    self.height = (game_view.tower_view.frame.size.height / 20).floor
    self.width = (game_view.tower_view.frame.size.width / 20).floor
    self.grade = rand/4 + 0.7
    self.blocks = []
    self.player = Player.new(Preferences.player_name)
    self.player.score = 0
    self.tower = Tower.random(self.grade, self.height, self.width)
    self.next_block = Block.new
    game_view.setNeedsDisplay true
  end

  def end_game(awesome = false)
    self.stop_timer
    player.awesome = awesome
    self.next_block= Smiley.new
    self.game_ended_view.setHidden false
    self.game_ended_view.setNeedsDisplay true
    self.game_view.tower_view.setHidden true
    self.game_view.next_block_view.setNeedsDisplay true
  end

  def tick(seconds)
    if tower.blocks_sum == 0
      return end_game
    end
    unless self.next_block.tick(1/20.0)
      self.player.add_score -(self.next_block.initial_time/2)
      self.next_block = Block.new
    end
    game_view.setNeedsDisplay true
    game_view.scores_view.setNeedsDisplay true
  end

  # every 10 seconds we remove the bottom line of the tower without penalty for the player
  def tick_tower(seconds)
    self.tower.remove_row(0)
  end

  def next_block
    game_view.next_block_view.block
  end

  def next_block=(block)
    game_view.next_block_view.block = block
  end

  def next_block_fits?(x,y)
    tower.fits?(next_block, x, y)
  end

  # player gets 100 extra if he cleans the tower
  def score!(x,y)
    if tower.remove(next_block, x, y)

      player.add_score(next_block.time_remaining * next_block.blocks_sum / 2)
      self.next_block = Block.new
      if tower.empty?
        player.add_score(100)
        self.end_game(true)
      end
      return true
    end
    return false
  end

  def shuffle_and_remove(sender)
    if tower.shuffle_and_remove
      player.add_score(-20)
      game_view.scores_view.setNeedsDisplay true
    end
    self.next_block = Block.new
  end

  def stats
    "%i blocks, %i lines" % [tower.blocks_sum, tower.size.height]
  end
end
