# -*- encoding : utf-8 -*-
class CabRequest < ActiveRecord::Base
  attr_accessor :pick_up_date

  attr_accessible :requester, :traveler_name, :contact_no, :pick_up_date, :pick_up_date_time, :source, :destination, :vehicle_type, :other_travellers, :comments, :status

  validates_presence_of :requester, :traveler_name, :contact_no, :pick_up_date, :pick_up_date_time, :source, :destination, :vehicle_type, :status
  validates_length_of :traveler_name, maximum: 35
  validates_length_of :contact_no, minimum: 10
  validates_length_of :source, maximum: 100
  validates_length_of :destination, maximum: 100
  validates_length_of :other_travellers, maximum: 500
  validates_length_of :comments, maximum: 500

  validate :check_source_and_destination
  validate :time_validation

  def check_source_and_destination
    errors.add(:source, ' and Destination can\'t be same') if source == destination
  end

  def time_validation
    unless pick_up_date_time.nil?
      current_time = Time.now
      errors.add(:pick_up_date_time,'should not be less than current time') if pick_up_date_time < current_time
    end
  end

end

