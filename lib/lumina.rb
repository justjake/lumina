require "lumina/version"

require 'hue'
require 'pry'

module Lumina
  def self.main
    brightness = ARGV[0].to_f
    set_brightness_f(brightness)
  end

  def self.set_brightness_f(brightness)
    client = Hue::Client.new
    group = client.groups.first

    derp = (255 * brightness).floor

    puts "setting brigtness of #{group}: #{group.brightness} => #{derp} (from #{brightness})"

    group.set_state(:brightness => derp)
  end
  # Your code goes here...
end
