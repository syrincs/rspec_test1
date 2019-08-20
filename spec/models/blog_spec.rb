require 'rails_helper'

RSpec.describe Blog, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "A test double" do
    it "returns canned responses from the methods named in the provided hash" do
      dbl = double("Some Collaborator", foo: 3, bar: 4)
      expect(dbl.foo).to eq(3)
      expect(dbl.bar).to eq(4)
    end
  end

  describe "allow" do
    it "returns nil from allowed messages" do
      dbl = double("Some Collaborator")
      allow(dbl).to receive(:foo)
      expect(dbl.foo).to be_nil
    end
  end

  describe "receive_messages" do
    it "configures return values for the provided messages" do
      dbl = double("Some Collaborator")
      allow(dbl).to receive_messages(foo: 2, bar: 3)
      expect(dbl.foo).to eq(2)
      expect(dbl.bar).to eq(3)
    end
  end  

  describe "A fulfilled positive message expectation" do
    it "passes" do
      dbl = double("Some Collaborator")
      expect(dbl).to receive(:foo)
      dbl.foo
    end
  end  

  describe "A negative message expectation" do
    it "passes if the message is never received" do
      dbl = double("Some Collaborator").as_null_object
      expect(dbl).not_to receive(:foo)
    end
  end

  describe "A person" do
    it "passes when the find method is called" do
      person = double("person")
      expect(person).to receive(:find) { person }
      person.find
    end
  end

  describe "A partial double" do
    # Note: stubbing a string like this is a terrible idea.
    #       This is just for demonstration purposes.
    let(:string) { "a string" }
    before { allow(string).to receive(:length).and_return(500) }
  
    it "redefines the specified methods" do
      expect(string.length).to eq(500)
    end
  
    it "does not effect other methods" do
      expect(string.reverse).to eq("gnirts a")
    end
  end

  # partial double
  class User
    def self.find(id)
      :original_return_value
    end
  end
  describe "A partial double" do
    it "redefines a method" do
      allow(User).to receive(:find).and_return(:redefined)
      expect(User.find(3)).to eq(:redefined)
    end
  
    it "restores the redefined method after the example completes" do
      expect(User.find(3)).to eq(:original_return_value)
    end
  end  

  # null_objects
  describe "as_null_object" do
    it "returns itself" do
      dbl = double("Some Collaborator").as_null_object
      expect(dbl.foo.bar.bazz).to be(dbl)
    end
  end  

  describe "as_null_object / added method" do
    it "can allow extra methods" do
      dbl = double("Some Collaborator", foo: 3).as_null_object
      allow(dbl).to receive(:bar).and_return(4)
  
      expect(dbl.foo).to eq(3)
      expect(dbl.bar).to eq(4)
    end
  end

  #spies
  describe "have_received" do
    it "passes when the message has been received" do
      invitation = spy('invitation')
      invitation.deliver
      expect(invitation).to have_received(:deliver)
    end
  end  

  class Invitation
    def self.deliver; end
  end
  describe "have_received" do
    it "passes when the expectation is met" do
      allow(Invitation).to receive(:deliver)
      Invitation.deliver
      expect(Invitation).to have_received(:deliver)
    end
  end  

  # describe "failure when the message has not been received" do
  #   example "for a spy" do
  #     invitation = spy('invitation')
  #     #invitation.deliver
  #     expect(invitation).to have_received(:deliver)
  #   end
  
  #   example "for a partial double" do
  #     allow(Invitation).to receive(:deliver)
  #     #Invitation.deliver
  #     expect(Invitation).to have_received(:deliver)
  #   end
  # end  

  describe "An invitiation" do
    let(:invitation) { spy("invitation") }
  
    before do
      invitation.deliver("foo@example.com")
      invitation.deliver("bar@example.com")
    end
  
    it "passes when a count constraint is satisfied" do
      expect(invitation).to have_received(:deliver).twice
    end
  
    it "passes when an order constraint is satisfied" do
      expect(invitation).to have_received(:deliver).with("foo@example.com").ordered
      expect(invitation).to have_received(:deliver).with("bar@example.com").ordered
    end
  
    # it "fails when a count constraint is not satisfied" do
    #   # invitation.deliver("foo@example.com")
    #   # invitation.deliver("foo@example.com")
    #   # invitation.deliver("foo@example.com")
    #   expect(invitation).to have_received(:deliver).at_least(3).times
    # end
  
    # it "fails when an order constraint is not satisfied" do
    #   expect(invitation).to have_received(:deliver).with("bar@example.com").ordered
    #   expect(invitation).to have_received(:deliver).with("foo@example.com").ordered

    #   # right order
    #   # expect(invitation).to have_received(:deliver).with("foo@example.com").ordered
    #   # expect(invitation).to have_received(:deliver).with("bar@example.com").ordered
    # end
  end

  context "validation tests" do
    it "ensures name presence" do
      blog = Blog.new(description: 'foobar').save
      expect(blog).to eq(false)
    end
  end 
end
