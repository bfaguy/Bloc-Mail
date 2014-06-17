require 'mailchimp'

class ApplicationController < ActionController::Base
  before_action :setup_mcapi

  def setup_mcapi
    @mc = Mailchimp::API.new(ENV['MAILCHIMP_API_KEY'])
    @gibbon_export = Gibbon::Export.new(ENV['MAILCHIMP_API_KEY'])
  end
end
