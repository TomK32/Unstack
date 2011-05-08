#
#  TutorialView.rb
#  unstack
#
#  Created by Thomas R. Koll on 08.05.11.
#  Copyright 2011 ananasblau.com. All rights reserved.
#


class TutorialView < NSView
  def drawRect(rect)
    NSColor.blackColor.set
    NSRectFill(bounds)
  end
end