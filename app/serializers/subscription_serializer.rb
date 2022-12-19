class SubscriptionSerializer
  def self.create_subscription(new_subscription)
    {
      data:{
        id: "#{new_subscription.id}",
        type: "subscription",
        attributes: {
          title: new_subscription.title,
          price: new_subscription.price,
          status: new_subscription.status,
          frequency: new_subscription.frequency
        }
      }
    }
  end
end