class UniqueHashGeneratorService
  EXCLUDED_CHARACTERS = %w(l I o O)
  CHARSET = ('a'..'z').to_a + (2..9).to_a + ('A'..'Z').to_a - EXCLUDED_CHARACTERS
  MAX_RETRIES = 5
  UNIQUE_KEY_LENGTH = 1

  def initialize(url)
    @url = url
    @unique_key_length ||= UNIQUE_KEY_LENGTH
  end

  def generator
    retries_count = 0
    begin
      set_generated_hash
      return save?
    rescue ActiveRecord::RecordNotUnique => err
      if (retries_count += 1) < MAX_RETRIES
        retry
      else
        @unique_key_length += 1
        retry
      end
    end
  end

  def set_generated_hash
    @url.unique_hash = generate_unique_hash
  end

  def generate_unique_hash
    (0...@unique_key_length).map{ CHARSET[rand(CHARSET.size)] }.join
  end

  def save?
    @url.save ? true : false
  end
end