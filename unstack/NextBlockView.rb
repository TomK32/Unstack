#
#  NextBlockView.rb
#  unstack
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#


class NextBlockView < NSView
  attr_accessor :game
  attr_accessor :block

  def drawRect rect
    NSColor.greenColor.colorWithAlphaComponent(block.alpha||1.0).set
    transform = NSAffineTransform.transform
    block_size = [frame.size.height/(block.size.height+1), frame.size.width/(block.size.width+1)].min
    offsetY = (frame.size.height - block.size.height*block_size) / 2
    offsetX = (frame.size.width - block.size.width*block_size) / 2
    transform.translateXBy offsetX, yBy: offsetY
    transform.concat
    block.drawRect(rect, block_size)
  end
end