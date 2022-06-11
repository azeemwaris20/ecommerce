namespace :db do
  desc 'ensures the db is upto date by running migrations and seeds in the right order'
  task ensure_upto_date: :environment do
    begin
      ActiveRecord::Base.connection
    rescue ActiveRecord::NoDatabaseError
      puts 'Database missing. Running initial setup'
      Rake::Task['db:create'].invoke
      Rake::Task['db:seed'].invoke
    else
      Rake::Task['db:migrate'].invoke
    end

    Rake::Task['db:test:prepare'].invoke
  end
end
