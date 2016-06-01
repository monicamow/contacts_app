require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # This method is called when no user arguments are given after the 'ruby contact_list.rb' command
  def self.display_menu
    puts "Here is a list of available commands: \
    \n    new    - Create a new contact \
    \n    list   - List all contacts \
    \n    show   - Show a contact \
    \n    search - Search contacts"
  end

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

  def self.run_program

    case ARGV[0]
      when "new"
        @contact_array = []

        puts "What is the name of the contact?"
        name_input = STDIN.gets.chomp.strip
        @contact_array <<  name_input

        puts "What is the email of the contact?"
        email_input = STDIN.gets.chomp.strip
        @contact_array <<  email_input

        new_id = Contact.create_id
        @contact_array << new_id

        puts Contact.new(name_input, email_input, new_id) # *** add ID to initialize
        
        Contact.create(@contact_array)

      when "list"
        all_contacts = Contact.all
        all_contacts.each do |contact|
          puts "#{contact[2]}: #{contact[0]}(#{contact[1]})"
        end

      when "show"

        case ARGV[1]
        when /\d/
          found_id = Contact.find(ARGV[1])
          if found_id.nil?
            puts "not found"
          else
            puts "#{found_id} ... here it is"
          end
        when nil
           display_menu 
        end 

      when "search"

        case ARGV[1]

        when /\w/
          search_results = Contact.search(ARGV[1])
          if search_results.empty?
            puts "not found"
          else
            puts "#{search_results} ... hello"
          end
        when nil
           display_menu
        end

      when nil
        display_menu
      end

  end

end

ContactList.run_program
