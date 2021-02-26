class BackgroundJob
  include SuckerPunch::Job

  def attempt_job(options)
  end

  def perform(options = {})
    ActiveRecord::Base.connection_pool.with_connection do
      attempt_job(options)
    end
  end
end