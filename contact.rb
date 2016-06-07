require 'pg'

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly

# 1) CONNECT
# 2) INITIALIZE
# 3) CLASS METHODS
# 4) INSTANCE METHODS
class Contact

  attr_accessor :name, :email
  attr_reader :id

  @@conn = PG.connect(
    host: 'localhost',
    dbname: 'contacts',
    user: 'development',
    password: 'development'
    )

  @@found_id_hash

  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(name, email, id=nil) # *** add ID to initialize
    @name = name
    @email = email
    @id = id
  end

  #################
  # CLASS METHODS #
  #################

  # Opens 'contacts' database and creates a Contact object for each record in the database (aka each contact).
  # @return [Array<Contact>] Array of Contact objects
  def self.all
    puts 'Finding contacts...'
    results = []
    @@conn.exec("SELECT * FROM contacts ORDER BY id ASC;").each do |contact|
      results <<  Contact.new(contact["name"], contact["email"], contact["id"].to_i)
    end
    p results
  end

  def self.create(name, email)
    # calls #save method
    contact_obj = Contact.new(name, email)
    contact_obj.save
    contact_obj
  end

  # execute an SQL statement 
  # convert the resulting data into a new Contact before returning it
  def self.find(id)
    found_id = @@conn.exec("SELECT * FROM contacts WHERE id=$1::int;", [id])
    found_id.each do |info|
      @@found_id_hash = info
    end
    found_id_obj = Contact.new(@@found_id_hash["name"], @@found_id_hash["email"], @@found_id_hash["id"].to_i)
    found_id_obj
  end

  def self.search
  end


  ####################
  # INSTANCE METHODS #
  ####################

  def save
    if id 
      @@conn.exec("UPDATE contacts SET name=$1, email=$2 WHERE id=$3;", [name, email, id.to_i])
    else
      result = @@conn.exec("INSERT INTO contacts (name, email) VALUES ($1, $2) RETURNING id;", [name, email])
      @id = result[0]["id"].to_i
    end
    self
  end


  def destroy
  end


end

#Contact.create("Jay-Z", "jigga@hotmail.com")

p Contact.find("1")


