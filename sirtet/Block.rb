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
  attr_accessor :position

  SHAPES = [
    [[1,1,1], [nil,1,nil]], # T
    [[1,1,1], [1,nil,nil]], # L
    [[1,1,1], [nil,nil,1]], # inverse L
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

  def fits?(other_block, other_x, other_y)
    other_block.shape.each_with_index do |row, y|
      row.each_with_index do |field, x|
        return false if !field.nil? && (shape[other_y+y].nil? || shape[other_y+y][other_x+x].nil?)
      end
    end
    return true
  end

  def remove(other_block, other_x, other_y)
    @fill_grade = nil
    @size = nil
    new_shape = shape.clone
    other_block.shape.each_with_index do |row, y|
      row.each_with_index do |field, x|
        if !field.nil?
          return false if new_shape[other_y+y].nil? || new_shape[other_y+y][other_x+x].nil?
          new_shape[other_y+y][other_x+x] = nil
        end
      end
    end
    # remove empty rows
    self.shape = new_shape.reject{|row| row.compact.empty? }
    return true
  end

  def remove_row(row)
    @fill_grade = nil
    @size = nil
    self.shape.delete_at(row)
  end

  def rotate!(angle)
    self.shape = self.shape.transpose if angle % 180
    self.shape = self.shape.collect{|row| row.reverse} if angle % 90
  end

  # uses a instance variable for performance,
  # don't forget to set @fill_grade nil when changing the stack
  def fill_grade
    return @fill_grade if @fill_grade
    blocks =  self.shape.collect{|r| r.compact.size }.inject{|r,sum| sum+=r }
    return @fill_grade = blocks.to_f / (self.size.height * self.size.width)
  end
end
