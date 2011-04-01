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

  def drawRect(rect)
    NSColor.blackColor.set
    NSRectFill(bounds)

  end
end