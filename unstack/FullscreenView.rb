#
#  FullscreenView.rb
#  unstack
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#


class FullscreenView < NSView
  attr_accessor :game_view


  def drawRect(rect)
    NSColor.darkGrayColor.set
    NSRectFill(bounds)
  end

  def toggleFullscreen(sender)
    if self.isInFullScreenMode
      self.exitFullScreenModeWithOptions nil
    else
      self.enterFullScreenMode self.window.screen, withOptions:nil
    end
  end
end
