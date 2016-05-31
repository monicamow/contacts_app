require 'csv'

class Contact

  attr_accessor :name, :email
  
  def initialize(name, email)
    @name = name
    @email = email
  end

  # Provides functionality for managing contacts in the csv file.
  class << self

    def all #LIST
      # disgusting hash must fix!!!
      CSV.foreach('contacts.csv', :col_sep => ',') do |row|
        contact_list = {
          row[0] => [row[1],row[2]]
          }
        contact_list.each do |name, info|
          puts info[1] + ": " + name + " (" + info[0] + ")"
        end
      end  
    end

    def create
      @contact_array = []

      puts "What is the name of the contact?"
      name_input = STDIN.gets.chomp.strip
      @contact_array <<  name_input
      puts "What is the email of the contact?"
      email_input = STDIN.gets.chomp.strip
      @contact_array <<  email_input

      new_id = create_id
      @contact_array << new_id
      puts Contact.new(name_input, email_input)

      p @contact_array

      # doesn't create new file if file doesn't exist...

      CSV.open('contacts.csv', 'a+') do |csv_object|
          csv_object << @contact_array 
      end

    end

    def create_id 
      number_of_records = CSV.open('contacts.csv', 'a+').readlines.size
      (number_of_records + 1).to_s
    end
    
    def find(id) #SHOW
      @found_id = nil
      @id = id.to_i - 1
      CSV.open('contacts.csv', 'r') do |file|
        file.readlines.each_with_index do |line,index|
          if index == @id
            @found_id = line
          end
        end
      end
      if @found_id.nil?
        puts "not found"
      else
        puts @found_id
      end
    end
    
    def search(term) #SEARCH
      # THIS IS SO DISGUSTING MUST FIX THIS
      # returns and counts all instances of beyonce...
      @search_results = []
      @found_term = false
      CSV.open('contacts.csv', 'r') do |file|
        file.readlines.each do |line|
          line.each do |field|
            if field.downcase.match(term)
              @search_results << line unless @search_results.include?(line)
              @found_term = true
            end
          end
        end
      end
      if @found_term == false
        puts "not found"
      else
        p @search_results
        puts "---\n#{@search_results.size} records total"
      end
    end

  end

end

