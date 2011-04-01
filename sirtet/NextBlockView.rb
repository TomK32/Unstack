#
#  NextBlockView.rb
#  sirtet
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#


class NextBlockView < NSView
  attr_accessor :game
  attr_accessor :block
  def drawRect rect
    NSColor.greenColor.colorWithAlphaComponent(block.alpha||1.0).set
    block.drawRect(rect, [frame.size.height, frame.size.width].min / 4)
  end
end