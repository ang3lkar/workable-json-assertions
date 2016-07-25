
class JsonController < ActionController::Base

  def empty_response
    head :ok
  end

  def dummy_response
    render json: dummy_object
  end

  private

  def dummy_object
    {
      one:    'John',
      two:    'Paul',
      three:  'George',
      four:   'Ringo'
    }
  end
end
