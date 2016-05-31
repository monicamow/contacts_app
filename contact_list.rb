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
        puts Contact.new(name_input, email_input)
        
        Contact.create(@contact_array)

      when "list"
        Contact.all

      when "show"

        case ARGV[1]
        when /\d/
          Contact.find(ARGV[1])
        when nil
           display_menu 
        end 

      when "search"

        case ARGV[1]

        when /\w/
          puts Contact.search(ARGV[1]) 
        when nil
           display_menu
        end

      end

  end

end

ContactList.run_program
