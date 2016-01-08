# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity

require 'pg'
require_relative 'model/owner'
require_relative 'model/pet'

# VetClinic manages a DB of Owners and Pets
class VetClinicCLI
  def initialize
    # Connect to the Database
    ActiveRecord::Base.establish_connection(
      adapter:  'postgresql', # or 'mysql2' or 'sqlite3'
      host:     'localhost',
      database: 'vet-clinic'
      # username: 'your_username',
      # password: 'your_password'
    )
  end

  def run
    while process_command(ask_user); end
  end

  private

  def ask_user
    puts
    puts 'What would you like to do?'
    puts '(IO) See an index of all owners'
    puts '(CO) Create a new owner'
    puts '(RO) See details on a specific owner'
    puts '(UO) Update an owner'
    puts '(DO) Delete an owner'
    puts '(IP) See an index of all pets'
    puts '(CP) Create a new pet'
    puts '(RP) See details on a specific pet'
    puts '(UP) Update a pet'
    puts '(DP) Delete a pet'
    puts '(Q)  Quit'
    gets.chomp.upcase
  end

  def process_command(command)
    keep_going = true
    case command
    when 'IO' then index_owners
    when 'CO' then create_owner
    when 'RO' then read_owner
    when 'UO' then update_owner
    when 'DO' then delete_owner
    when 'IP' then index_pets
    when 'CP' then create_pet
    when 'RP' then read_pet
    when 'UP' then update_pet
    when 'DP' then delete_pet
    when 'Q'  then keep_going = false
    else
      puts 'That is not a valid command'
    end
    keep_going
  end

  def get_response(prompt)
    puts prompt
    gets.chomp
  end

  def index_owners
    puts 'Owners'
    owners = Owner.all
    puts owners
  end

  def create_owner
    first_name = get_response('Enter the first name of the owner: ')
    last_name  = get_response('Enter the last name of the owner: ')

    # Owner.new(first_name: first_name, last_name: last_name).save
    Owner.create(first_name: first_name, last_name: last_name)

    puts "#{first_name} #{last_name} has been added to the database."
  end

  def read_owner
    id = get_response('Enter the id of the owner:').to_i
    owner = Owner.find(id)
    puts owner ? owner : 'Owner not found'
  end

  def update_owner
    id = get_response('Enter the id of the owner:').to_i
    owner = Owner.find(id)
    if owner
      owner.first_name = get_response('Enter the first name of the owner:')
      owner.last_name  = get_response('Enter the last name of the owner:')
      owner.save
    else
      puts 'Owner not found'
    end
  end

  def delete_owner
    id = get_response('Enter the id of the owner:').to_i
    owner = Owner.find(id)
    if owner
      owner.destroy
    else
      puts 'Owner not found'
    end
  end

  def index_pets
    puts 'Pets'
    pets = Pet.all
    puts pets
  end

  def create_pet
    name      = get_response('Enter the name of the pet:')
    type      = get_response('Enter the type of the pet:')
    age       = get_response('Enter the age of the pet:')
    owner_id  = get_response('Enter the owner id of the pet:')

    # Pet.new(name: name, type: type, age:  age, owner_id: owner_id).save
    Pet.create(name: name, type: type, age:  age, owner_id: owner_id)

    puts "#{name} has been added to the database."
  end

  def read_pet
    id = get_response('Enter the id of the pet:').to_i
    pet = Pet.find(id)
    puts pet ? pet : 'Pet not found'
  end

  def update_pet
    id = get_response('Enter the id of the pet:').to_i
    pet = Pet.find(id)
    if pet
      pet.name      = get_response('Enter the name of the pet:')
      pet.type      = get_response('Enter the type of the pet:')
      pet.age       = get_response('Enter the age of the pet:')
      pet.owner_id  = get_response('Enter the owner id of the pet:')
      pet.save
    else
      puts 'Pet not found'
    end
  end

  # new stuff:
  def delete_pet
    id = get_response('Enter the id of the pet:').to_i
    pet = Pet.find(id)
    if pet
      pet.destroy
    else
      puts 'Pet not found'
    end
  end
end

VetClinicCLI.new.run
