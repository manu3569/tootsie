require 'sinatra/base'

module Tranz
  
  class WebService < Sinatra::Base
    set :sessions, false
    set :run, false
    
    post '/job' do
      logger.info "Handling job: #{params.inspect}"
      job = Job.new(params)
      unless job.valid?
        halt 400, 'Invalid job specification'
      end
      Application.get.queue.push(job)
      201
    end
    
    private
    
      def logger
        return @logger ||= Application.get.logger
      end
    
  end
  
end
