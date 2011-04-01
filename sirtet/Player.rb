#
#  Player.rb
#  sirtet
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#

class Player
  attr_accessor :name
  attr_accessor :score
  attr_accessor :scores
  
  def initialize(name)
    self.name = name
    self.scores = []
  end

  def add_score(points)
    self.scores << [Time.now, points]
    self.score += points
  end
end