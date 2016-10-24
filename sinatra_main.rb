require 'sinatra/base'
require 'pg'
require 'active_record'
require './customer'
require 'rubygems'
require 'will_paginate'
require 'will_paginate/active_record'
require 'will_paginate-bootstrap'
require "sinatra/reloader"


ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database =>  'customer_db',
  :host => 'localhost'
)


class CustomerApp < Sinatra::Base
  include WillPaginate::Sinatra::Helpers
  register Sinatra::Reloader

  get '/' do
    @customers = Customer.paginate(:page => params[:page], :per_page => 2)
    erb :root
  end

  get '/customers/:id' do
    @customer = Customer.find(params[:id])
    erb :customer
  end
  
  post '/add_new_customer' do
    Customer.create(params)
    redirect '/'
  end


end

CustomerApp.run!
