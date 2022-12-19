class CustomerSerializer
  def self.create_customer(new_customer)
    {
      data:{
        id: "#{new_customer.id}",
        type: "customers",
        attributes: {
          first_name: new_customer.first_name,
          last_name: new_customer.last_name,
          address: new_customer.address,
          email: new_customer.email
        }
      }
    }
  end
end