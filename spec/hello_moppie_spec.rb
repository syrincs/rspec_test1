require "rails_helper"

class HelloMoppie
  def say_hello
    "Hello Moppie!"    
  end  
end

describe HelloMoppie do
  context "when testing the HelloMoppie class" do
    it "should return 'Hello Moppie!' when we call the say_hello method" do
      hm = HelloMoppie.new
      message = hm.say_hello
      expect(message).to eq "Hello Moppie!"
    end
  end
end

# Doubles
class ClassRoom 
  def initialize(students) 
    @students = students 
  end
  
  def list_student_names 
    @students.map(&:name).join(',') 
  end 
end

describe ClassRoom do
  it 'the list_student_names method should work correctly' do 
    student1 = double('student') 
    student2 = double('student') 
     
    allow(student1).to receive(:name) { 'John Smith'} 
    allow(student2).to receive(:name) { 'Jill Smith'} 
     
    cr = ClassRoom.new [student1,student2]
    expect(cr.list_student_names).to eq('John Smith,Jill Smith') 
  end 

  # Hooks
  class SimpleClass 
    attr_accessor :message 
    
    def initialize() 
      puts "\nCreating a new instance of the SimpleClass class" 
      @message = 'howdy' 
    end 
    
    def update_message(new_message) 
      @message = new_message 
    end 
  end 
 
  describe SimpleClass do 
    #before(:all), after(:all), after(:each)
    before(:each) do 
      @simple_class = SimpleClass.new 
    end 
    
    it 'should have an initial message' do 
      expect(@simple_class).to_not be_nil
      @simple_class.message = 'Something else. . .' 
    end 
    
    it 'should be able to change its message' do
      @simple_class.update_message('a new message')
      expect(@simple_class.message).to_not be 'howdy' 
    end
  end
end

# Subjects
class Person 
  attr_reader :first_name, :last_name 
  
  def initialize(first_name, last_name) 
    @first_name = first_name 
    @last_name = last_name 
  end 
end 

describe Person do 
  it 'create a new person with a first and last name' do
    person = Person.new 'John', 'Smith'
     
    expect(person).to have_attributes(first_name: 'John') 
    expect(person).to have_attributes(last_name: 'Smith') 
  end 
end

# Helpers
class Dog
  attr_reader :good_dog, :has_been_walked 
  
  def initialize(good_or_not)
    @good_dog = good_or_not 
    @has_been_walked = false 
  end 
  
  def walk_dog 
    @has_been_walked = true 
  end 
end 

describe Dog do 
  def create_and_walk_dog(good_or_bad)
    dog = Dog.new(good_or_bad)
    dog.walk_dog
    return dog 
  end 
  
  it 'should be able to create and walk a good dog' do
    dog = create_and_walk_dog(true)
     
    expect(dog.good_dog).to be true
    expect(dog.has_been_walked).to be true 
  end 
  
  it 'should be able to create and walk a bad dog' do 
    dog = create_and_walk_dog(false)
     
    expect(dog.good_dog).to be false
    expect(dog.has_been_walked).to be true 
  end 
end
