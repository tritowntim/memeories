FactoryGirl.define do
  factory :meme do
    sequence(:name)          { |n| "meme name #{n}"}
    funny                    true
    sequence(:emoji_pattern) { |n| "meme #{n} :emoji:"}
    sequence(:description)   { |n| "meme #{n} can be described like so..."}
  end
end
