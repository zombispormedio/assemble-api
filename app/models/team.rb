class Team < ActiveRecord::Base

  has_many :memberships
  has_many :members, :through => :memberships

  belongs_to :admin, :class_name => 'User'

  has_many :meetings

  has_many :messages, :class_name => 'TeamMessage'


  #Validation

  #Validation
  validates :name, presence: {message: "Name must be"}

  before_create do
    self.uid = SecureRandom.uuid
  end

  def serialize
    TeamSerializer.new(self).attributes
  end

  def serialized_admin
    AdminSerializer.new(self.admin).attributes
  end

  def serialized_members
    self.members.map do |member|
      result=MemberSerializer.new(member).attributes
      if result[:id]==self.admin_id
        result[:admin]=true
      end
      result
    end
  end

end