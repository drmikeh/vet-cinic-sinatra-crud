require 'sinatra'
require_relative 'model/owner'
require_relative 'model/pet'

# Connect to the Database
ActiveRecord::Base.establish_connection(
  adapter:  'postgresql', # or 'mysql2' or 'sqlite3'
  host:     'localhost',
  database: 'vet-clinic'
  # username: 'your_username',
  # password: 'your_password'
)

helpers do
  def pluralize(noun, count)
    count == 1 ? noun : noun + 's'
  end
end

set :show_exceptions, :after_handler

error do
  'Sorry there was a nasty error - ' + env['sinatra.error'].message
end

get '/' do
  erb :home
end

get '/owners' do
  @owners = Owner.all
  erb :owners
end

get '/owners/:id' do
  id = params[:id]
  @owner = Owner.find(id)
  erb :owner
end

get '/owners/new' do
  erb "new-owner".to_sym
end

post '/owners' do
  puts "got params = #{params}"
  Owner.create(params[:owner])
  redirect '/owners'
end

get '/pets' do
  @pets = Pet.all
  erb :pets
end

get '/pets/new' do
  @owners = Owner.all
  erb "new-pet".to_sym
end

post '/pets' do
  puts "got params = #{params}"
  Pet.create(params[:pet])
  # raise RuntimeError.new("boom")
  redirect '/pets'
end
