#
#  Field.rb
#  sirtet
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#


class TowerView < NSView
  include GameHelper
  attr_accessor :game
  attr_accessor :game_view
  attr_accessor :block_position
  attr_accessor :last_rotation
  attr_accessor :last_drag_point

  def block_size
    game_view.block_size
  end

  def drawRect rect
    with_context do
      game.tower.drawRect(rect, block_size)
    end
    draw_block if self.block_fits? && self.block_position
  end

  def mouseDown(event)
    point = self.point_in_grid(convertPoint event.locationInWindow, fromView:nil)
    self.block_position = point
  end

  def point_in_grid(point)
    NSPoint.new(point.x - (point.x % block_size), point.y - (point.y % block_size))
  end

  def mouseUp(event)
    if self.block_fits? && game.score!(self.block_position.x/block_size, self.block_position.y/block_size)
      self.block_position = nil
      self.last_rotation = nil
      self.setNeedsDisplay true
    end
  end

  def mouseDragged(event)
    return unless Preferences.rotate_with_mouse
    point = convertPoint event.locationInWindow, fromView:nil
    if last_drag_point && (last_drag_point.x - point.x + last_drag_point.y - point.y).abs < block_size/2
      return
    end
    self.last_drag_point ||= self.block_position
    rotation =
      ((point.y - self.last_drag_point.y) > block_size/2 ? 180 : 0) +
      ((point.x - self.last_drag_point.x) > block_size/2 ?  90 : 0)
    if self.last_rotation != rotation && self.game.next_block.rotate!(rotation)
      self.last_rotation = rotation
    end
  end

  def draw_block
    with_context do
      transform = NSAffineTransform.transform
      transform.translateXBy self.block_position.x, yBy: self.block_position.y
      transform.concat
      NSColor.yellowColor.colorWithAlphaComponent(0.7).set
      game.next_block.drawRect(frame, block_size)
    end
    setNeedsDisplay true
  end

  def block_fits?
    return false unless self.block_position
    game.next_block_fits?(self.block_position.x/block_size, block_position.y/block_size)
  end
end
