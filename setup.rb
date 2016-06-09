require 'pry' # in case you want to use binding.pry
require 'active_record'
require_relative 'lib/contact'
require_relative 'lib/contact_list'
require_relative 'lib/phone_number'

# Output messages from Active Record to standard out
ActiveRecord::Base.logger = Logger.new(STDOUT)

puts 'Establishing connection to database ...'
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'ar_contacts',
  username: 'development',
  password: 'development',
  host: 'localhost',
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error'
)
puts 'CONNECTED'

puts 'Setting up Database (recreating tables) ...'

ActiveRecord::Schema.define do
  #drop_table :stores if ActiveRecord::Base.connection.table_exists?(:stores)
  #drop_table :employees if ActiveRecord::Base.connection.table_exists?(:employees)
  create_table :contacts do |t|
    t.column :first_name, :string
    t.column :last_name, :string
    t.column :email, :string
    t.timestamps null: false
  end
  create_table :phone_numbers do |table|
    table.references :contact
    table.column :kind, :string
    table.column :phone_number, :string
    table.timestamps null: false
  end
end

puts 'Setup DONE'
