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

    # commands typed by use from terminal
    menu = {
      command: ARGV[0],
      argument: ARGV[1]
    }

    case menu[:command]
      when "list"
        all_contacts = Contact.all
        all_contacts.each do |contact|
          puts "#{contact.id}: #{contact.name} (#{contact.email})"
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
        
        new_contact = Contact.create(name_input, email_input, new_id)
        puts "The contact, \"#{new_contact.name}\" (#{new_contact.email}), \
        \nwas created with a new ID of #{new_contact.id}."

      when "show"

        case menu[:argument]
        when /\d/
          found_id = Contact.find(menu[:argument])
          if found_id.nil?
            puts "not found"
          else
            puts "ID: #{found_id.id}\nNAME: #{found_id.name}\nEMAIL: #{found_id.email}"
          end
        when nil
           display_menu 
        end 

      when "search"

        case menu[:argument]

        when /\w/
          search_results = Contact.search(menu[:argument])
          if search_results.empty?
            puts "not found"
          else
            search_results.each do |contact|
              puts "#{contact[2]}: #{contact[0]} (#{contact[1]})"
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

# code entry point
ContactList.run_program
