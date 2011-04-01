#
#  Block.rb
#  sirtet
#
#  Created by Thomas R. Koll on nil1.nil4.11.
#  Copyright 2nil11 Ananasblau.com. All rights reserved.
#


class Block
  attr_accessor :shape
  attr_accessor :time_remaining
  attr_accessor :initial_time

  SHAPES = [
    [[nil,1,nil], [1,1,1]], # T
    [[1,nil], [1,nil], [1,1]], # L
    [[nil,1], [nil,1], [1,1]], # inverse L
    [[1,1,nil], [nil,1,1]], # z
    [[nil,1,1], [1,1,nil]], # inverse z
    [[1,1,1,1]], # long john
    [[1,1], [1,1]] # block
  ]
  def initialize(shape = nil, time = nil)
    self.shape = shape || SHAPES[rand(SHAPES.size)]
    self.initial_time = time || 5 # seconds
    self.time_remaining = self.initial_time 
  end

  def alpha
    return self.time_remaining / self.initial_time.to_f
  end

  def tick(seconds)
   self.time_remaining -= seconds
   self.time_remaining > 0
  end

  def drawRect(rect, block_size)
    self.shape.each_with_index do |row, y|
      row.each_with_index do |field, x|
        if field
          field.set if field.is_a?(NSColor)
          NSRectFill(NSRect.new(NSPoint.new(x*block_size + 0.5, y*block_size + 0.5), [block_size - 1, block_size - 1]))
        end
      end
    end
  end
  def size
    @size ||= NSSize.new(shape.collect{|r| r.size}.max, shape.size)
  end
end
