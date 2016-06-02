require 'csv'

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact

  attr_reader :name, :email, :id

  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(name, email, id) # *** add ID to initialize
    @name = name
    @email = email
    @id = id
  end

  # Provides functionality for managing contacts in the csv file.
  class << self

    # Opens 'contacts.csv' and creates a Contact object for each line in the file (aka each contact).
    # @return [Array<Contact>] Array of Contact objects
    def all #LIST
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
      @all_contacts = []
      CSV.open('contacts.csv', 'r') do |file|
        file.readlines.each do |line|
            contact = Contact.new(line[0], line[1], line[2])
            @all_contacts << contact
        end
      end
      return @all_contacts
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    # @param name [String] the new contact's name
    # @param email [String] the contact's email
    def create(name_input, email_input, new_id) # define new parameters so they don't conflict with attr_readers
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      new_contact = Contact.new(name_input, email_input, new_id)
      contact_array = [new_contact.name, new_contact.email, new_contact.id]

      CSV.open('contacts.csv', 'a+') do |csv_object|
          csv_object << contact_array 
      end

      puts "The contact, \"#{new_contact.name}\" (#{new_contact.email}), \
      \nwas created with a new ID of #{new_contact.id}."
    end

    # Creates a new contact ID based on the number of existing records in contacts.csv
    # returns number of rows as string
    def create_id # *** add ID to initialize
      # ID SHOULD BE LARGEST ID CREATED + 1 (ENSURES UNIQUENESS)
      contacts = all
      next_id = contacts.reduce(0) do |id, contact|
        id = contact.id.to_i + 1 if contact.id.to_i >= id
        id
      end
    end
    
    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id) #SHOW
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
        all.each do |contact|
          if contact.id == id
            @found_id = contact
          end
        end
      return @found_id
    end
  
    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term) #SEARCH
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      # THIS IS SO DISGUSTING MUST FIX THIS
      # returns and counts all instances of beyonce...
      @search_results = []
        all.each do |contact|
          contact_array = [contact.name, contact.email,contact.id]
          contact_array.each do |field|
            if field.match(term)
              @search_results << contact_array unless @search_results.include?(contact_array)
            end
          end
        end
      return @search_results
    end

  end

end

