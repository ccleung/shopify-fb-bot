FactoryGirl.define do
  factory :fb_msg_event, class: Hash do
    sender { { id: 11_111_111_111_111_111 } }
    recipient { { id: 22_222_222_222_222_222 } }
    timestamp 1_463_254_696_945

    initialize_with { attributes }
  end
end
