#
#  Unstack.rb
#  unstack
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#

class Unstack
  attr_accessor :game_view
  attr_accessor :fullscreen_view
  attr_accessor :blocks
  attr_accessor :player
  attr_accessor :width
  attr_accessor :height
  attr_accessor :grade
  attr_accessor :tower
  attr_accessor :timer
  attr_accessor :tower_timer
  attr_accessor :highscores_view
  attr_accessor :tutorial_view
  attr_accessor :current_view
  attr_accessor :paused
  attr_accessor :pause_menu_item
  
  def awakeFromNib
    self.current_view = self.game_view
    start_game(self)
  end

  def start_timer
    self.timer ||= NSTimer.scheduledTimerWithTimeInterval( 1/20.0,
          target:self, selector:"tick:", userInfo:nil, repeats:true)
    self.tower_timer ||= NSTimer.scheduledTimerWithTimeInterval( 2.0,
          target:self, selector:"tick_tower:", userInfo:nil, repeats:true)
  end

  def stop_timer
    return if self.timer.nil?
    self.timer.invalidate
    self.timer = nil
    return if self.tower_timer.nil?
    self.tower_timer.invalidate
    self.tower_timer = nil
  end
  
  def start_game(sender)
    if self.current_view != self.game_view
      fullscreen_view.replaceSubview(self.current_view, with:self.game_view)
      self.current_view = self.game_view
    end
    if(!self.timer)
      start_timer
    end
    if(!self.paused)
      self.height = (game_view.tower_view.frame.size.height / 20).floor
      self.width = (game_view.tower_view.frame.size.width / 20).floor
      self.grade = rand/4 + 0.7
      self.blocks = []
      self.player = Player.new(Preferences.player_name)
      self.player.score = 0
      self.tower = Tower.random(self.grade, self.height, self.width)
      self.next_block = Block.new
    end
    self.paused = false
    game_view.start_game
    game_view.setNeedsDisplay true
  end

  def end_game(awesome = false)
    self.stop_timer
    player.awesome = awesome
    self.next_block= Smiley.new
    self.game_view.end_game()

    self.game_view.next_block_view.setNeedsDisplay true
  end

  def show_highscores(sender)
    stop_timer()
    self.paused = true
    fullscreen_view.replaceSubview(self.current_view, with:self.highscores_view)
    self.highscores_view.setNeedsDisplay true
    self.current_view = self.highscores_view
  end

  def toggle_timer(sender)
    if(!self.paused)
      self.paused = true
      stop_timer()
      fullscreen_view.replaceSubview(self.current_view, with:self.tutorial_view)
      self.tutorial_view.setNeedsDisplay true
      self.current_view = self.tutorial_view
      self.pause_menu_item.setTitle "Unpause"
    else
      self.pause_menu_item.setTitle "Pause"
      start_game(sender)
    end
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
