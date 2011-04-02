#
#  Smiley.rb
#  sirtet
#
#  Created by Thomas R. Koll on 02.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#


class Smiley < Block
  def initialize
    c = NSColor.yellowColor
    n = nil
    self.shape = [
      [n, c, c, c, n],
      [c, n, n, n, c],
      [n, n, c, n, n],
      [n, c, n, c, n]
    ]
  end

  def alpha
    1.0
  end
end