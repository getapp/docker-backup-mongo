backup_name = (ENV['BACKUP_NAME'] || 'mongo').to_sym
Model.new(backup_name, 'Mongo Backup') do
  database MongoDB do |db|
    db.name               = ENV['MONGO_DATABASE']
    db.username           = ENV['MONGO_USER'] unless ENV['MONGO_USER'].nil?
    db.password           = ENV['MONGO_PASS'] unless ENV['MONGO_PASS'].nil?
    db.host               = ENV['MONGO_HOST']
    db.port               = ENV['MONGO_PORT']
    db.ipv6               = false
    db.lock               = false
    db.oplog              = false
    db.additional_options = [].tap |opts| do
      opts << "--query=#{ENV['MONGO_QUERY']}" unless ENV['MONGO_QUERY']}.nil?
    end
    unless ENV['MONGO_COLLECTIONS'].nil?
      db.only_collections = ENV['MONGO_COLLECTIONS'].split(',')
    end
  end

  store_with S3 do |s3|
    s3.access_key_id = ENV['AWS_ACCESS_KEY_ID']
    s3.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    s3.region = ENV['AWS_REGION']
    s3.bucket = ENV['AWS_BUCKET']
    s3.path = ENV['AWS_MONGO_PATH']
  end
end
