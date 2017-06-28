FactoryGirl.define do
  factory :bookmark do
		name RandomData.random_word
    url "http://example.com"
		description RandomData.random_sentence
    topic
  end
end
