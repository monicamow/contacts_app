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
    def create(contact_array)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      CSV.open('contacts.csv', 'a+') do |csv_object|
          csv_object << contact_array 
      end

      puts "The contact, \"#{contact_array[0]}\" (#{contact_array[1]}), \
      \nwas created with a new ID of #{contact_array[2]}."
    end

    # Creates a new contact ID based on the number of existing records in contacts.csv
    # returns number of rows as string
    def create_id # *** add ID to initialize
      # ID SHOULD BE LARGEST ID CREATED + 1 (ENSURES UNIQUENESS)
      number_of_records = CSV.open('contacts.csv', 'a+').readlines.size
      (number_of_records + 1).to_s
    end
    
    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id) #SHOW
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      @id = id.to_i - 1
      CSV.open('contacts.csv', 'r') do |file|
        file.readlines.each_with_index do |line,index|
          if index == @id
            @found_id = line
          end
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
      CSV.open('contacts.csv', 'r') do |file|
        file.readlines.each do |line|
          line.each do |field|
            if field.downcase.match(term)
              @search_results << line unless @search_results.include?(line)
            end
          end
        end
      end
      return @search_results
    end

  end

end

