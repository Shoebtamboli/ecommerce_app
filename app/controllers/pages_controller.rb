class PagesController < ApplicationController
  def home
    @featured_products = Product.order(created_at: :desc).limit(4)
    # Add any other instance variables you need for the homepage
  end

  def about
  end

  def contact
    @contact_submission = ContactSubmission.new
  end

  def submit_contact
    @contact_submission = ContactSubmission.new(contact_params)

    if @contact_submission.save
      # Here you would typically send an email notification
      ContactMailer.new_submission(@contact_submission).deliver_later
      redirect_to contact_path, notice: 'Your message has been sent. We will get back to you soon!'
    else
      flash.now[:alert] = 'There was a problem with your submission. Please check the form and try again.'
      render :contact
    end
  end

  private

  def contact_params
    params.require(:contact_submission).permit(:name, :email, :message)
  end
end