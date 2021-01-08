class PictureUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 画像が未設定の時にデフォルトで設定する画像のURL
  def default_url(*args)
    "thumb400_default.png"
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # 詳細表示用：400 * 400の正方形に整形
  version :thumb400 do
    process resize_and_pad(400, 400, background = :transparent, gravity = 'Center')
  end

  # 一覧表示用：200 * 200の正方形に中央から切り抜き
  version :thumb200 do
    process resize_to_fill: [200, 200, "Center"]
  end

  # コメント表示用：50 * 50の正方形に中央から切り抜き
  version :thumb50 do
    process resize_to_fill: [50, 50, "Center"]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
