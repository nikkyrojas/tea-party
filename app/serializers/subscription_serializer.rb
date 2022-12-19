class SubscriptionSerializer
  def self.create_subscription(new_sub)
    {
      data: {
        id: new_sub.id},
        type: "subscription",
        attributes: {
          title: new_sub.title,
          price: new_sub.price,
          status: new_sub.status,
          frequency: new_sub.frequency
        }
      }
  end
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