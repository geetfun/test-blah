module Configuration
  def load_configuration(*additional_config_files)
    config_files = []
    config_files << 'global.yml'
    additional_config_files.each do |f|
      config_files << f
    end
    configure do
      config_files.each do |config_file|
        config_file = File.join(Dir.getwd, 'config', config_file)
        @config = YAML::load_file(config_file).to_hash.each do |k, v|
          set k, v
        end
      end

      set :current_db, Sinatra::Application.db_development if Sinatra::Application.development?
      set :current_db, Sinatra::Application.db_production if Sinatra::Application.production?
      set :current_db, Sinatra::Application.db_test if Sinatra::Application.test?

      puts "Environment: #{Sinatra::Application.environment}"
      puts "Database   : #{Sinatra::Application.current_db}"
    end
  end
end