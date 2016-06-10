
class JsonController < ActionController::Base  
  def timestamps
    head :ok
  end

  private

  def get_timestamps_json
    {
      starts_at: '',
      starts_at_millis: '',
      starts_at_in_words: ''
    }
  end
end
