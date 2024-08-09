# frozen_string_literal: true

require 'telegram_bot'
require './sonarr_handler'
require 'logger'

$LOG_INFO = Logger.new('./info_log.log', 'monthly')

token_telegram = '1361309538:AAFATp9onP9DCoVE4A-cyiU1n8JVAyg4dYk'

bot = TelegramBot.new(token: token_telegram)

bot.get_updates(fail_silently: true) do |message|
  puts "@#{message.from.username}: #{message.text}"
  command = message.get_command_for(bot)

  message.reply do |reply|
    reply.text = case command
                 when /start/i
                   'Hello This is a Sonar Reporting Bot. /help for commands list.'
                 when /help/i
                   '/help - Commands List
                   /chatid - Display Chat ID of this chat.
                   /sonarrStatus - Display The Status of Sonarr Server.
                   /seriesList - Displar the available Series in Sonarr.'
                 when /chatid/i
                   "Chat ID: #{message.chat.id}"
                 when /sonarrStatus/i
                   "Sonarr Status \n#{SonarrHandler.sonarr_status}"
                 when /seriesList/i
                   series_data = SonarrHandler.sonarr_series_list
                   rep_ser = ''
                   series_data.each do |series|
                     rep_ser += "#{series['title']} - #{series['episodeCount']}/#{series['episodeFileCount']}\n"
                   end
                   rep_ser
                 else
                   "Sorry #{command.inspect} Command not Found."
                 end
    reply.send_with(bot)
  end
end
