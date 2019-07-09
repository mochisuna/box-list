require "boxr"

def run(event:, context:)
  p ENV.fetch('TARGET_NAME')
  file_dir = ENV.fetch('BOX_JWT_PRIVATE_KEY_DIR')
  token = Boxr::get_user_token(
    ENV.fetch('BOX_USER_ID'),
    private_key: File.open(file_dir).read.gsub("\\n", "\n"),
    private_key_password: ENV.fetch('BOX_JWT_PRIVATE_KEY_PASSWORD'),
    public_key_id: ENV.fetch('BOX_JWT_PUBLIC_KEY_ID'),
    client_id: ENV.fetch('BOX_CLIENT_ID'),
    client_secret: ENV.fetch('BOX_CLIENT_SECRET')
  )
  client = Boxr::Client.new(token.access_token)
  cnt = show(client, '0', '')

  { statusCode: 200, num_of_files: JSON.generate(cnt) }
end

# ファイルの一覧を全て捜査する
def show(client, folder_id, parent_path)
  cnt = 0
  items = client.folder_from_id(folder_id).item_collection.entries
  items.each do |item|
    if item.type == 'folder'
      cnt += show(client, item.id, "#{parent_path}/#{item.name}")
    elsif item.type == 'file'
      cnt += 1
      p "#{parent_path}/#{item.name}"
    end
  end
  cnt
end
