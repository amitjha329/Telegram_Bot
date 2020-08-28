# frozen_string_literal: true

require 'telegram_bot'
require 'logger'

token = '1361309538:AAFATp9onP9DCoVE4A-cyiU1n8JVAyg4dYk'

bot = TelegramBot.new(token: token)

bot.get_updates(fail_silently: true) do |message|
  puts "@#{message.from.username}: #{message.text}"
  command = message.get_command_for(bot)

  message.reply do |reply|
    reply.text = case command
                 when /start/i
                   'Hello This is a Sonar Reporting Bot. /help for commands list.'
                 when /help/i
                   "/help - Commands List\n/chatid - Display Chat ID."
                 when /chatid/i
                   "Chat ID: #{message.chat.id}"
                 else
                   "Sorry #{command.inspect} Command not Found."
                 end
    reply.send_with(bot)
  end
end
