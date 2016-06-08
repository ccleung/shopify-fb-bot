FactoryGirl.define do
  factory :fb_msg_event, class: Hash do
    sender { { id: 11_111_111_111_111_111 } }
    recipient { { id: 22_222_222_222_222_222 } }
    timestamp 1_463_254_696_945

    trait :message do
      transient do
        message do
          {
            mid: 'mid.1460245671959:dad2ec9421b03d6f78',
            seq: 216,
            text: 'hello'
          }
        end
      end
      after(:build) do |fb_msg_event, evaluator|
        fb_msg_event[:message] = evaluator.message
      end
    end

    trait :postback do
      transient do
        postback do
          {
            payload: 'USER_DEFINIED_PAYLOAD'
          }
        end
      end
      after(:build) do |fb_msg_event, evaluator|
        fb_msg_event[:postback] = evaluator.postback
      end
    end

    trait :delivery do
      transient do
        delivery do
          {
            mids: ['mid.1458668856218:ed81099e15d3f4f233'],
            watermark: 1_458_668_856_253,
            seq: 37
          }
        end
      end
      after(:build) do |fb_msg_event, evaluator|
        fb_msg_event[:delivery] = evaluator.delivery
      end
    end

    initialize_with { attributes }
  end
end
