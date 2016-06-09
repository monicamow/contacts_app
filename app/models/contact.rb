class Contact < ActiveRecord::Base

  has_many :phone_numbers

end

#Contact.create(first_name: "Test", last_name: "Name", email: "testing@test.com")
