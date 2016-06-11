class Contact < ActiveRecord::Base

  has_many :phone_numbers

  def to_s
    "The contact, \"#{first_name}\" (#{email}), \
    \nwas created with a new ID of #{id}."
  end

end

#Contact.create(first_name: "Test", last_name: "Name", email: "testing@test.com")
