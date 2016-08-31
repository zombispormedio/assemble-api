class Meeting < ActiveRecord::Base
  after_create :create_attendances, :create_uid
  after_destroy :destroy_attendances

  belongs_to :team

  has_many :messages, :class_name => 'MeetingMessage', :foreign_key => "meeting_id"


  has_many :attendances, :dependent => :destroy
  has_many :attendants, :through => :attendances

  private
  def create_attendances
    attendances.create(
        team.memberships.map { |membership|
          {attendants: membership}
        }
    ) if not team.nil?
  end

  def destroy_attendances
    attendances.each{|attendance| attendance.destroy}
  end

  def create_uid
    self.uid = SecureRandom.uuid
  end


end