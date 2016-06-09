require 'pg'

class PhoneNumber

  attr_accessor :number, :kind
  attr_reader :id, :contact_id

  @@conn = PG.connect(
    host: 'localhost',
    dbname: 'contacts',
    user: 'development',
    password: 'development'
    )

  def initialize(kind, number, contact_id, id=nil)
    @kind = kind
    @number = number
    @contact_id = contact_id
    @id = id
  end

  def self.create(kind, number, contact_id)
    # calls #save method
      phone_number_obj = PhoneNumber.new(kind, number, contact_id)
      phone_number_obj.save
      phone_number_obj
  end  

  def save
    if id 
      @@conn.exec("UPDATE phone_numbers SET kind=$1, phone_number=$2, contact_id=$3 WHERE id=$4;", [kind, number, contact_id.to_i, id.to_i])
    else
      result = @@conn.exec("INSERT INTO phone_numbers (kind, phone_number, contact_id) VALUES ($1, $2, $3) RETURNING id;", [kind, number, contact_id.to_i])
      @id = result[0]["id"].to_i
    end
    self    
  end

  def self.all
    results = []
    @@conn.exec("SELECT * FROM phone_numbers ORDER BY contact_id ASC;").each do |number|
      results <<  PhoneNumber.new(number["kind"], number["phone_number"], number["contact_id"].to_i, number["id"].to_i)
    end
    results
  end

end