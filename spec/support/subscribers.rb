module Test
  class Base
    def call(event, opts = {})
    end
  end

  class MessageSubscriber < Base
  end

  class DeliverySubscriber < Base
  end

  class PostbackSubscriber < Base
  end
end
