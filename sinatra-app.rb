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

# Return the home page
get '/' do
  erb :home
end

# Get all owners
get '/owners' do
  @owners = Owner.all
  erb "owners/index".to_sym
end

# Return the form for creating a new owner
get '/owners/new' do
  erb "owners/new".to_sym
end

# Return the detail page for the specified owner
get '/owners/:id' do
  @owner = Owner.find(params[:id])
  erb "owners/view".to_sym
end

# Create a new owner (called from the new owner page)
post '/owners' do
  puts "got params = #{params}"
  Owner.create(params[:owner])
  redirect '/owners'
end

# Return the form for editing the specified owner
get '/owners/:id/edit' do
  @owner = Owner.find(params[:id])
  erb "owners/edit".to_sym
end

# Update the specified owner (called from the edit page)
put '/owners/:id' do
  owner = Owner.find(params[:id])
  owner.update(params[:owner])
  redirect '/owners'
end

# Delete the specified owner
delete '/owners/:id' do
  Owner.destroy(params[:id])
  redirect '/owners'
end

# Get all pets
get '/pets' do
  @pets = Pet.all
  erb "pets/index".to_sym
end

# Return the form for creating a new pet
get '/pets/new' do
  @owners = Owner.all
  erb "pets/new".to_sym
end

# Return the detail page for the specified pet
get '/pets/:id' do
  @pet = Pet.find(params[:id])
  erb "pets/view".to_sym
end

# Create a new pet (called from the new pet page)
post '/pets' do
  puts "got params = #{params}"
  Pet.create(params[:pet])
  redirect '/pets'
end

# Return the form for editing the specified pet
get '/pets/:id/edit' do
  @owners = Owner.all
  @pet = Pet.find(params[:id])
  erb "pets/edit".to_sym
end

# Update the specified pet (called from the edit page)
put '/pets/:id' do
  pet = Pet.find(params[:id])
  pet.update(params[:pet])
  redirect '/pets'
end

# Delete the specified pet
delete '/pets/:id' do
  Pet.destroy(params[:id])
  redirect '/pets'
end
