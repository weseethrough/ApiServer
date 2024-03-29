# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey_beta_insight do
    response_id 1
    time_started "2014-05-16 15:59:37"
    time_submitted "2014-05-16 15:59:37"
    status "MyString"
    contact_id "MyText"
    legacy_comments "MyText"
    comments "MyText"
    language "MyText"
    referrer "MyText"
    extended_referrer "MyText"
    session_id "MyText"
    user_agent "MyText"
    extended_user_agent "MyText"
    ip_address "MyString"
    longitude 1.5
    latitude 1.5
    country_auto "MyString"
    city "MyString"
    region "MyString"
    post_code "MyString"
    mobile_device_1 "MyString"
    mobile_device_2 "MyString"
    wearable_glass "MyString"
    wearable_other_title "MyString"
    wearable_other "MyString"
    running_fitness "MyString"
    cycling_fitness "MyString"
    workout_fitness "MyString"
    goal_faster "MyString"
    goal_further "MyString"
    goal_slimmer "MyString"
    goal_stronger "MyString"
    goal_happier "MyString"
    goal_live_longer "MyString"
    goal_manage_condition "MyString"
    goal_other_title "MyString"
    goal_other "MyString"
    first_name "MyString"
    last_name "MyString"
    email "MyString"
    phone_number "MyString"
    url "MyString"
    gender "MyString"
    age_group "MyString"
    country_as_entered "MyString"
  end
end
