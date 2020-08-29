# frozen_string_literal: true

require 'net/http'
require 'json'
require 'logger'

$LOG_INFO = Logger.new('./info_log.log', 'monthly')
# Class to handle sonarr requests in the bot.
class SonarrHandler
  $apikey = '?apikey=45020f01258e48978aec2d640e49f073'
  $uri = 'http://192.168.29.13:8989/api'

  def self.sonarr_status
    path = '/system/status'
    res = Net::HTTP.get_response(URI.parse("#{$uri}#{path}#{$apikey}"))
    data = JSON.parse(res.body)
    return "Version: #{data['version']}\nMono Version: #{data['runtimeVersion']}\nAuthentication Type: #{data['authentication']}"
  end

  def self.sonarr_series_list
    path = '/series'
    res = Net::HTTP.get_response(URI.parse("#{$uri}#{path}#{$apikey}"))
    data = JSON.parse(res.body)
    return data
  end
end
