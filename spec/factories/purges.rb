FactoryGirl.define do

  factory :purge do
    list_id "123"
    user_id 1
    created_at Time.now
    unsubscribed_count 1
  end

end

