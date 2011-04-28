#
#  Preferences.rb
#  sirtet
#
#  Created by Thomas R. Koll on 28.04.11.
#  Copyright 2011 ananasblau.com. All rights reserved.
#


class Preferences
  def self.player_name
    NSUserDefaults.standardUserDefaults['player.name'] || 'Thomas'
  end
  
  def self.rotate_with_mouse
    false
  end
end