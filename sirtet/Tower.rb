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

  # generate a complely random field
  # param :grade is the fill grade of the field
  def self.random(grade, height, width)
    raise "grade must be less than 1" if grade > 1
    self.new height.times.collect{|row| width.times.collect{|col| rand() + grade >= 1 ? self.color : nil } }
  end

  # retuns a random from these colors: red, blue, green
  def self.color
    [NSColor.redColor, NSColor.blueColor, NSColor.greenColor].sample
  end

  def shuffle_and_remove
    return false if self.shape.size < 3
    blocks = self.shape[-1].compact.size
    hit = false
    while blocks > 0 do
      c = 0
      begin
        c+=1
        # find a new position for the block
        y = rand(self.shape.size-1)
        x = self.shape[y].index(nil) if self.shape[y]
      end while c < self.size.height && x.nil?
      return hit if y.nil? || x.nil? || self.shape[y].nil?
      hit = true
      # move the block to its new palce in society
      self.shape[y][x] = self.shape[-1].pop
      blocks -= 1
    end
    # remove the top line from stack
    self.shape.pop
    # and now suffle the remainder
    self.shape.collect!{|r| r.sort{rand}}.sort!{rand}
  end
end
