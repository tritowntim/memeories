FactoryGirl.define do
  factory :meme do
    sequence(:name)         { |n| "meme name #{n}"}
    started_at              Date.today
    emoji                   true
    medium                  'Slack'
    sequence(:description)  { |n| "meme #{n} can be described like so..."}
  end
end
