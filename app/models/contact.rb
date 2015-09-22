class Contact < ActiveRecord::Base

  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :first_name, {scope: :last_name}
  validate :has_phone_or_email?

  before_save :set_full_name

  serialize :emails, Array
  serialize :phones, Array

  def self.groupped_by_first_letter
    groupped_by_first_letter = {}

    all.
    sort_by { |contact| contact.full_name.downcase }.
    each do |contact|
      letter = contact.full_name[0].mb_chars.upcase.to_s

      groupped_by_first_letter[letter] ||= []
      groupped_by_first_letter[letter] << contact
    end

    groupped_by_first_letter
  end

  private
    def set_full_name
      self.full_name = "#{first_name} #{last_name}" if attributes_changed?
    end

    def attributes_changed?
      first_name_changed? || last_name_changed?
    end

    def has_phone_or_email?
      errors.add(:base, 'must have at least one phone or email') if phones.blank? &&   emails.blank?
    end

    # def phones_format
    #   if phones.collect { |phone| phone.match(/\D/).present? }.any?
    #     errors.add(:phones, 'invalid phone number format')
    #   end
    # end

    # def emales_format
    #   # if emails.collect { |email| phone.match(/\D/).present? }.any?
    #   #   errors.add(:emales, 'invalid email format')
    #   # end
    # end
end
