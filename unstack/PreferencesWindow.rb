#
#  PreferencesController.rb
#  unstack
#
#  Created by Thomas R. Koll on 01.04.11.
#  Copyright 2011 Ananasblau.com. All rights reserved.
#

class PreferencesWindow < NSWindow
  attr_accessor :name
  attr_accessor :game

  def awakeFromNib
    set_values
  end

  def set_values
		self.name.stringValue = Preferences.player_name
  end

  def performClose(sender)
    NSUserDefaults.standardUserDefaults['player.name'] = self.name.stringValue
    game.player.name = self.name.stringValue
    game.setNeedsDisplay true
    NSUserDefaults.standardUserDefaults.synchronize
    self.set_values
    self.close
  end
end