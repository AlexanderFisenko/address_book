class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :destroy, :update, :share]

  def export
    contacts = Contact.all.order(full_name: :asc)
    file_name = 'contacts_export.xls'
    file_path = ContactsWorker.export(contacts, file_name)
    send_file file_path, filename: file_name, disposition: 'attachment'
  end

  def import
    ContactsWorker.import(params[:file])
    redirect_to contacts_path, notice: t('.success')
  end

  def share
    mail = params[:mail]
    if mail.present? || @contact.present?
      Mailer.share(@contact, mail).deliver_now
      redirect_to contacts_path, notice: t('.success')
    else
      return redirect_to contacts_path, alert: t('.failure')
    end
  end

  def index
    @contacts_groupped_by_first_letter = Contact.groupped_by_first_letter
  end

  def show
  end

  def new
    @contact = Contact.new(phones: [nil], emails: [nil])
  end

  def edit
  end

  def create
    @contact = Contact.create(contact_params)
    if @contact.valid?
      redirect_to contact_path(@contact), notice: t('.success')
    else
      render :new
    end
  end

  def update
    @contact.update(contact_params)
    if @contact.valid?
      redirect_to contact_path(@contact), notice: t('.success')
    else
      render :new
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path, notice: t('.success')
  end

  private

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).
      permit(:first_name, :last_name, phones: [], emails: []).
      merge(phones: params[:contact][:phones].reject { |phone| phone.empty? }).
      merge(emails: params[:contact][:emails].reject { |email| email.empty? })
    end

end
