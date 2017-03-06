class UniqueHashGeneratorService
  EXCLUDED_CHARSET = %w(l I o O).freeze
  CHARSET = ('a'..'z').to_a + (2..9).to_a + ('A'..'Z').to_a - EXCLUDED_CHARSET
  MAX_RETRIES = 5
  UNIQUE_KEY_LENGTH = 1

  def initialize(url)
    @url = url
    @unique_key_length ||= UNIQUE_KEY_LENGTH
  end

  def try_to_create_model
    retries_count = 0
    begin
      set_generated_hash
      return save_success?
    rescue ActiveRecord::RecordNotUnique
      @unique_key_length += 1 unless (retries_count += 1) < MAX_RETRIES
      retry
    end
  end

  def set_generated_hash
    @url.unique_hash = generate_unique_hash
  end

  def generate_unique_hash
    (0...@unique_key_length).map { CHARSET[rand(CHARSET.size)] }.join
  end

  def save_success?
    @url.save ? true : false
  end
end
