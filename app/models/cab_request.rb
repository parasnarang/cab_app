class CabRequest < ActiveRecord::Base

  attr_accessible :requester,:traveler_name, :contact_no, :pick_up_date, :pick_up_time ,:source,:destination,:no_of_passengers, :comments

  validates_presence_of :traveler_name, :contact_no , :destination, :pick_up_time, :source, :no_of_passengers, :pick_up_date , :requester
  validates_format_of :traveler_name, :with => /^[a-z.A-Z\s]*$/
  validates_numericality_of :contact_no, :only_integer => true

  validates_length_of :contact_no, :is => 10
  validates_length_of :comments, :maximum => 25
  validates_length_of :traveler_name, :maximum => 10

  validate :check_source_and_destination
  validate :date_and_time_validation

  def check_source_and_destination
    errors.add(:source ," and Destination can't be same") if source == destination
  end

  def date_and_time_validation
    current_date = Date.today
    current_time = Time.now
    current_time = current_time.strftime("%I:%M%p")
    # pick_up_time = pick_up_time.strftime("%I:%M%p")
    p '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    p current_time.class
    p pick_up_time.class
    # p pick_up_time.change(:day =>2023)
    # p current_time.to_formatted_s(:db)
    p '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    errors.add(:pick_up_date," and pick_up_time should not be less than current date-time") if (pick_up_date < current_date) #|| (pick_up_time < current_time)
  end
end