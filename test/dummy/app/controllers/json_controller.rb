
class JsonController < ActionController::Base

  def empty_response
    head :ok
  end

  def dummy_response
    render json: dummy_object
  end

  def another_response
    render json: nested_object
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

  def nested_object
    {
      one: {
        name: 'John',
        instrument: 'Guitar'
      },
      two: {
        name: 'Paul',
        instrument: 'Bass'
      }
    }
  end
end
