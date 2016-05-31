require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  def self.run_program
    puts "Here is a list of available commands: \
    \n    new    - Create a new contact \
    \n    list   - List all contacts \
    \n    show   - Show a contact \
    \n    search - Search contacts"
  end


  ARGV << self.run_program if ARGV.empty?

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

  def build_contact_list

    case ARGV[0]
    when "new"
      Contact.create
    when "list"
      Contact.all
    when "show"

      case ARGV[1]
      when /\d/
        Contact.find(ARGV[1])
      when nil
         puts "I don't understand. You need to ask me to search/show something."
      end
      
    when "search"

      case ARGV[1]
      when /\w/
        Contact.search(ARGV[1])     
      when nil
         puts "I don't understand. You need to ask me to search/show something."
      end
    end

  end

end

test = ContactList.new
test.build_contact_list
