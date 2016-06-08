FactoryGirl.define do
  factory :fb_payload, class: Hash do
    object 'page'
    entry [id: 33_333_333_333_333_333, time: 1_463_254_696_945, messaging: []]
    initialize_with { attributes }
  end
end
