#
#  Block.rb
#  sirtet
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#


class Block
  attr_accessor :position
  attr_accessor :shape
  attr_accessor :field
  SHAPES = [
    [[0,1,0], [1,1,1]], # T
    [[1,0], [1,0], [1,1]], # L
    [[0,1], [0,1], [1,1]], # inverse L
    [[1,1,0], [0,1,1]], # z
    [[0,1,1], [1,1,0]], # inverse z
    [[1,1,1,1]], # long john
    [[1,1], [1,1]] # block
  ]
  def initialize(field, position = nil, shape = nil)
    self.field = field
    self.shape = shape || SHAPES[rand(SHAPES.size)]
    self.position = position || NSPoint(rand(self.field.width), 0)
    return self
  end
end

