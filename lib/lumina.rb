require "lumina/version"

require 'hue'
require 'pry'

class Lumina
  def main
    brightness = ARGV[0].to_f
    set_brightness_f(brightness)
  end

  def f_to_brightness(f)
    range = ::Hue::Light::BRIGHTNESS_RANGE
    magnitude = range.end - range.begin
    brightness = range.begin + (magnitude * f).floor
    brightness.to_i
  end

  def brightness_to_f(brightness)
    range = ::Hue::Light::BRIGHTNESS_RANGE
    magnitude = range.end - range.begin
    (brightness - range.begin).to_f / magnitude.to_f
  end

  def set_brightness_f(f)
    client = Hue::Client.new
    group = client.groups.first

    # "derp" is the birghtness as an 8-bit float, it seems
    derp = f_to_brightness(f)
    prev_derp = group.brightness
    prev_f = brightness_to_f(prev_derp)

    puts "setting brigtness of #{group}: #{prev_f} (#{prev_derp}) => #{f} (#{derp})"

    group.set_state(:brightness => derp)
  end
  # Your code goes here...
end
