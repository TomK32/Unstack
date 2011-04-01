#
#  Tower.rb
#  sirtet
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#


class Tower < Block
  
  def initialize(shape = [])
    self.shape = shape
  end

  def self.random(grade, height, width)
    raise "grade must be less than 1" if grade > 1
    self.new height.times.collect{|row| width.times.collect{|col| rand() + grade >= 1 ? self.color : nil } }
  end
  def self.color
    [NSColor.redColor, NSColor.blueColor, NSColor.greenColor].sample
  end
end