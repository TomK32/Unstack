#
#  GameView.rb
#  sirtet
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#


class GameView < NSView
  attr_accessor :game

  def withContext(&block)
    context = NSGraphicsContext.currentContext
    context.saveGraphicsState
    yield
    context.restoreGraphicsState
  end

  def block_size
    @block_size ||= frame.size.width / game.width
  end

  def drawRect(rect)
    NSColor.blackColor.set
    NSRectFill(bounds)
    withContext do
      NSColor.greenColor.set
      game.tower.rows.each_with_index do |row, y|
        row.each_with_index do |field, x|
          if field
            NSRectFill(NSRect.new(NSPoint.new(y*block_size, x*block_size), [block_size, block_size]))
          end
        end
      end
    end
  end
end
