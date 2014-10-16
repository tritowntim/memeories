# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, funny: true, description: '', emoji_pattern: '' },{ name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

MEMES = [
  { name: 'Dustin Portraits',       funny: true,  description: 'Framed pictures of Dustin''s WDI grad picture, with inspiratioinal quotes', emoji_pattern: ':dustin:' },
  { name: 'Slack Cop',              funny: true,  description: 'David''s polite patrol of Slack manners', emoji_pattern: ':cop:' },
  { name: 'Tim Was There',          funny: false, description: 'Tumblr documenting Tim''s attendance at historical events' , emoji_pattern: ':watch: :watch:' },
  { name: 'Lil'' Adrian',           funny: true,  description: 'Campaign by Adrian and Dustin to influence baby names' , emoji_pattern: ':baby:' },
  { name: 'YELLING AT BROOKS',      funny: true,  description: 'Folks shouting at mild-mannered Brooks in all caps', emoji_pattern: '' },
  { name: 'Michelle :heart: Emoji', funny: false, description: 'Michelle is launching Emoji Communication Immersive' , emoji_pattern: ':raised_hands:' },
  { name: 'Don''t Say Stamm',       funny: false, description: 'David reprimands and threatens any reference to him with his last name ', emoji_pattern: ':dragon:' },
  { name: 'Toilet Paper Bandit',    funny: true,  description: 'Troublemaker in GA NYC 6th floor coworking space', emoji_pattern: ':toilet:' },
  { name: 'The Dave Special',       funny: true,  description: 'Mysterious treat from GA NYC 6th floor coworking space', emoji_pattern: ':cocktail: :beer:' },
  { name: '6th Floor Love Story',   funny: true,  description: 'Rampant canoodling in the 6th floor kitchen and lobby', emoji_pattern: ':heart::kiss:' }
]

MEMES.each { |meme| Meme.create(meme) }
