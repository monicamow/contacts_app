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
      when "list"
        all_contacts = Contact.all
        all_contacts.each do |contact|
          puts "#{contact.id}: #{contact.name}(#{contact.email})"
        end

      when "new"
        @contact_array = []

        puts "What is the name of the contact?"
        name_input = STDIN.gets.chomp.strip

        puts "What is the email of the contact?"
        email_input = STDIN.gets.chomp.strip

        new_id = Contact.create_id

        # need array of <Contacts> NOT array of arrays
        #puts Contact.new(name_input, email_input, new_id) # *** add ID to initialize
        
        Contact.create(name_input, email_input, new_id)

      when "show"

        case ARGV[1]
        when /\d/
          found_id = Contact.find(ARGV[1])
          if found_id.nil?
            puts "not found"
          else
            puts found_id
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
            search_results.each do |contact|
              puts "#{contact[2]}: #{contact[0]}(#{contact[1]})"
            end
            puts "---\n#{search_results.size} records total"
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
