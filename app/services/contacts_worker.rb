class ContactsWorker
  class << self
    def export(contacts, file_name)
      file_path = Rails.root.to_s + '/docs/' + file_name
      book = Spreadsheet::Workbook.new
      sheet1 = book.create_worksheet

      sheet1[0,0] = "First name"
      sheet1[0,1] = "Last name"
      sheet1[0,2] = "Phones"
      sheet1[0,3] = "Emails"

      contacts.each_with_index do |contact, i|
        i += 1
        sheet1[i,0] = contact.first_name
        sheet1[i,1] = contact.last_name
        sheet1[i,2] = contact.phones.join(", ")
        sheet1[i,3] = contact.emails.join(", ")
      end

      sheet1.row(0).height = 14

      format = Spreadsheet::Format.new :color => :red,
                                       :weight => :bold,
                                       :size => 12
      sheet1.row(0).default_format = format

      book.write(file_path)
      return file_path
    end

    def import(file)
      book = Spreadsheet.open(file.path)
      sheet1 = book.worksheets.select { |w| w.count > 0 }.first
      sheet1.each 1 do |row|
        first_name = row[0]
        last_name  = row[1]
        phones     = row[2].split(", ").flatten
        emails     = row[3].split(", ").flatten

        next if (first_name.blank? && last_name.blank?) || (phones.blank? && emails.blank?)

        contact = Contact.find_by(first_name: first_name, last_name: last_name)
        if contact.present?
          contact.update(phones: phones, emails: emails)
        else
          Contact.create(
            first_name: first_name,
            last_name:  last_name,
            phones:     phones,
            emails:     emails
          )
        end
      end
    end
  end
end