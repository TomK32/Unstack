#
#  Player.rb
#  unstack
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#

class Player
  attr_accessor :score
  attr_accessor :scores
  attr_accessor :awesome
  
  def initialize()
    self.scores = []
    self.awesome = false
  end

  def name
    Preferences.player_name
  end

  def add_score(points)
    self.scores << [Time.now, points]
    self.score += points
  end

  def score_text
    return 'Fail!' if score <= 0.0
    return awesome ? 'Awesome' : 'Nice'
  end
end