class SubscriptionsSerializer
  def self.get_subscriptions(subscriptions)
    {
      data: subscriptions.map do |sub| {
        id: sub.id,
        type: "subscription",
        attributes: {
          title: sub.title,
          price: sub.price,
          status: sub.status,
          frequency: sub.frequency
        }
      }
      end
    }
  end
end